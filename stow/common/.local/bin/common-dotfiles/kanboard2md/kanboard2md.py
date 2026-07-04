#!/usr/bin/env python3

"""Migrate Kanboard tasks to Markdown files (one file per task)."""

import argparse
import json
import logging
import re
import sys
from datetime import UTC, datetime
from pathlib import Path
from typing import Any

import kanboard

logger = logging.getLogger(__name__)


def parse_args() -> argparse.Namespace:
    parser = argparse.ArgumentParser(
        description="Migrate Kanboard tasks to Markdown files.",
    )
    parser.add_argument("--url", required=True, help="Kanboard JSON-RPC endpoint URL")
    parser.add_argument("--api-token", required=True, help="Kanboard API token")
    parser.add_argument("--verbose", action="store_true", help="Enable debug logging")
    parser.add_argument(
        "--project_id",
        required=True,
        type=int,
        help="ID of the Kanboard project to migrate",
    )
    parser.add_argument(
        "--output_dir",
        required=True,
        type=Path,
        help=(
            "Directory to write Markdown card files into "
            "(must be empty or non-existent)"
        ),
    )
    return parser.parse_args()


def validate_output_dir(output_dir: Path) -> None:
    if output_dir.exists():
        if not output_dir.is_dir():
            logger.error("%s exists but is not a directory", output_dir)
            sys.exit(1)
        if any(output_dir.iterdir()):
            logger.error("Output directory %s is not empty", output_dir)
            sys.exit(1)
    else:
        output_dir.mkdir(parents=True)
        logger.info("Created output directory: %s", output_dir)


def unix_to_utc(ts: Any) -> datetime | None:  # noqa: ANN401
    """Convert a Unix timestamp (int, str, or None/falsy) to a UTC-aware datetime."""
    try:
        val = int(ts)  # type: ignore[arg-type]
    except (TypeError, ValueError):
        return None
    if val == 0:
        return None
    return datetime.fromtimestamp(val, tz=UTC)


def sanitize_title(title: str) -> str:
    slug = title.lower()
    slug = re.sub(r"\s+", "_", slug)
    slug = re.sub(r"[^a-z0-9_-]", "", slug)
    return slug[:64] or "untitled"


def format_ts(ts: Any) -> str:  # noqa: ANN401
    dt = unix_to_utc(ts)
    return dt.strftime("%Y-%m-%dT%H:%M:%SZ") if dt else ""


def markdown_cell(value: Any) -> str:  # noqa: ANN401
    if value is None:
        return ""
    if isinstance(value, bool):
        out = "true" if value else "false"
    elif isinstance(value, (dict, list)):
        out = json.dumps(value, ensure_ascii=False, sort_keys=True)
    else:
        out = str(value)
    return out.replace("|", "\\|").replace("\n", "<br>")


def build_markdown(  # noqa: PLR0913
    task: dict,
    project_name: str,
    columns: dict[str, dict],
    categories: dict[str, dict],
    tags: list[str],
    comments: list[dict],
) -> str:
    task_id = task.get("id", "")
    title = task.get("title") or f"task_{task_id}"
    column_id = str(task.get("column_id") or "0")
    column_title = columns.get(column_id, {}).get("title", "")
    category_id = str(task.get("category_id") or "0")
    category_name = categories.get(category_id, {}).get("name", "")
    status_label = "open" if str(task.get("is_active", "")) == "1" else "closed"

    lines = [f"# {title}", "", "## Metadata", "", "| Field | Value |", "| --- | --- |"]

    metadata_rows: list[tuple[str, Any]] = [
        ("project_name", project_name),
        ("resolved_status", status_label),
        ("resolved_column_title", column_title),
        ("resolved_category_name", category_name),
        ("tags", ", ".join(tags)),
        ("comment_count", len(comments)),
        ("date_creation_iso", format_ts(task.get("date_creation"))),
        ("date_modification_iso", format_ts(task.get("date_modification"))),
        ("date_due_iso", format_ts(task.get("date_due"))),
        ("date_started_iso", format_ts(task.get("date_started"))),
        ("date_completed_iso", format_ts(task.get("date_completed"))),
    ]
    for key in sorted(task):
        value = task.get(key)
        if key.startswith("date_"):
            value = format_ts(value)
        metadata_rows.append((key, value))

    for key, value in metadata_rows:
        lines.append(f"| {markdown_cell(key)} | {markdown_cell(value)} |")

    description = task.get("description") or ""
    lines.extend(["", "## Description", "", description])

    lines.extend(["", "## Comments", ""])
    if not comments:
        lines.append("_No comments_")
    else:
        for comment in comments:
            username = comment.get("name") or comment.get("username") or "unknown"
            when = format_ts(comment.get("date_creation")) or "unknown date"
            text = comment.get("comment") or ""
            lines.extend(
                [
                    f"### {username} ({when})",
                    "",
                    text,
                    "",
                ],
            )

    return "\n".join(lines).rstrip() + "\n"


def write_markdown(
    markdown: str,
    output_dir: Path,
    column_title: str,
    task_id: object,
    title: str,
) -> None:
    column_dir = output_dir / sanitize_title(column_title or "unknown_column")
    column_dir.mkdir(parents=True, exist_ok=True)
    sanitized = sanitize_title(title)
    filename = f"{task_id}_{sanitized}.md"
    filepath = column_dir / filename
    filepath.write_text(markdown, encoding="utf-8")
    logger.debug("Wrote %s", filepath)


def main() -> None:
    args = parse_args()
    logging.basicConfig(
        level=logging.DEBUG if args.verbose else logging.INFO,
        format="%(levelname)s: %(message)s",
        stream=sys.stderr,
    )

    validate_output_dir(args.output_dir)

    url = args.url.rstrip("/")
    if not url.endswith(".php"):
        url = f"{url}/jsonrpc.php"
        logger.debug("Resolved API endpoint: %s", url)

    logger.info("Connecting to %s", url)

    with kanboard.Client(url, "jsonrpc", args.api_token) as kb:
        try:
            project = kb.get_project_by_id(project_id=args.project_id)
        except kanboard.ClientError:
            logger.exception("Failed to fetch project %d", args.project_id)
            sys.exit(1)

        if not project:
            logger.error("Project %d not found", args.project_id)
            sys.exit(1)

        logger.info("Migrating project '%s' (id=%d)", project["name"], args.project_id)

        columns: dict[str, dict] = {
            str(c["id"]): c for c in (kb.get_columns(project_id=args.project_id) or [])
        }
        categories: dict[str, dict] = {
            str(c["id"]): c
            for c in (kb.get_all_categories(project_id=args.project_id) or [])
        }

        active_tasks: list[dict] = (
            kb.get_all_tasks(project_id=args.project_id, status_id=1) or []
        )
        closed_tasks: list[dict] = (
            kb.get_all_tasks(project_id=args.project_id, status_id=0) or []
        )
        all_tasks = active_tasks + closed_tasks

        logger.info(
            "Found %d task(s) (%d active, %d closed)",
            len(all_tasks),
            len(active_tasks),
            len(closed_tasks),
        )

        success = 0
        skipped = 0
        for task in all_tasks:
            task_id = task["id"]
            title = task.get("title") or f"task_{task_id}"
            try:
                raw_tags = kb.get_task_tags(task_id=task_id) or {}
                tags = list(raw_tags.values()) if isinstance(raw_tags, dict) else []
                comments = kb.get_all_comments(task_id=task_id) or []
                markdown = build_markdown(
                    task=task,
                    project_name=project.get("name") or "",
                    columns=columns,
                    categories=categories,
                    tags=tags,
                    comments=comments,
                )
                column_id = str(task.get("column_id") or "0")
                column_title = columns.get(column_id, {}).get("title", "")
                write_markdown(markdown, args.output_dir, column_title, task_id, title)
                success += 1
            except Exception as exc:  # noqa: BLE001
                logger.warning("Skipping task %s (%r): %s", task_id, title, exc)
                skipped += 1

    logger.info("Done: %d written, %d skipped", success, skipped)


if __name__ == "__main__":
    main()
