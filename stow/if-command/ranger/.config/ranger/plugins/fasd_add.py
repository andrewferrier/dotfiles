# This plugin adds opened files to `fasd`

from shlex import quote
import ranger.api

old_hook_init = ranger.api.hook_init

# Based on
# https://github.com/ranger/ranger/wiki/Integration-with-other-programs#fasd


def hook_init(fm):
    def fasd_add():
        for fobj in fm.thistab.get_selection():
            fm.execute_console("shell fasd --add " + quote(fobj.path))
    fm.signal_bind('execute.before', fasd_add)
    return old_hook_init(fm)


ranger.api.hook_init = hook_init
