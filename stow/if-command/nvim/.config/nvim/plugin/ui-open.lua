if vim.fn.has("nvim-0.10.0") == 1 then
    local OPEN_CMD

    if vim.uv.os_uname().sysname == "Linux" then
        OPEN_CMD = "xdg-open"
    else
        -- Mac
        OPEN_CMD = "open"
    end

    vim.ui.open = function(path)
        vim.system(
            { OPEN_CMD, path },
            { detach = true },
            function(sys_completed)
                if sys_completed.code > 0 then
                    vim.schedule(function()
                        vim.notify(
                            '"'
                                .. OPEN_CMD
                                .. " "
                                .. path
                                .. '" failed: '
                                .. sys_completed.stderr
                        )
                    end)
                end
            end
        )
    end
end
