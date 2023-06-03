from ranger.api.commands import Command

import os


class Zip(Command):
    """:Zip <filenames>

    Zips directories.
    """

    def execute(self):
        paths = [f.realpath for f in self.fm.thistab.get_selection()]

        for path in paths:
            if os.path.isdir(path):
                zipfile = path + ".zip"
                pathtozip = os.path.basename(path)
                command = ["zip", "-r9", zipfile, pathtozip]
                self.fm.execute_command(command)
                self.fm.notify(zipfile + " created.")
            else:
                self.fm.notify(path + " is not a directory!")
