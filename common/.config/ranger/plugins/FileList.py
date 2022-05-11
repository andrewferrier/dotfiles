from ranger.api.commands import Command

import os
import os.path
import shlex
import subprocess


class FileListDirectorySwitch(Command):
    def execute(self):
        file_list = self.fm.execute_command(
            "file-list -d -s", stdout=subprocess.PIPE
        )
        stdout, stderr = file_list.communicate()
        if file_list.returncode == 0:
            dir = os.path.abspath(
                os.path.expanduser(stdout.decode("utf-8").rstrip("\n"))
            )
            assert os.path.isdir(dir)
            self.fm.execute_command('fasd -A ' + shlex.quote(dir))
            self.fm.cd(dir)
        else:
            self.fm.notify("Error running file-list!")


class FileListFileFind(Command):
    def execute(self):
        file_list = self.fm.execute_command(
            "file-list -f -s", stdout=subprocess.PIPE
        )
        stdout, stderr = file_list.communicate()
        if file_list.returncode == 0:
            file = os.path.abspath(
                os.path.expanduser(stdout.decode("utf-8").rstrip("\n"))
            )
            assert os.path.isfile(file)
            self.fm.execute_command('fasd -A ' + shlex.quote(file))
            self.fm.select_file(file)
        else:
            self.fm.notify("Error running file-list!")
