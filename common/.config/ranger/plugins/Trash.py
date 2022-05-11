from ranger.api.commands import Command

import subprocess


class Trash(Command):
    """:Trash <filenames>

    Trashes files.
    """

    def execute(self):
        paths = [f.realpath for f in self.fm.thistab.get_selection()]

        rc = subprocess.call(["which", "trash"])
        if rc == 0:
            command = ["trash"]
            command.extend(paths)
            self.fm.notify(command)
            self.fm.execute_command(command)
            self.fm.notify("Trashed!")
        else:
            self.fm.notify("`trash` command not installed!", bad=True)
