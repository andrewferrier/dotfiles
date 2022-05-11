from os.path import expanduser
from ranger.api.commands import Command

import datetime
import os
import shutil
import sys


class Folderize(Command):
    """:Folderize <dirname>

    Puts selected files and folders into a subfolder (named dirname if
    provided).
    """

    def execute(self):
        # os.path.commonpath() requires Python 3.5+
        assert sys.version_info >= (3, 5)
        paths = [f.realpath for f in self.fm.thistab.get_selection()]

        if len(paths) < 1:
            self.fm.notify(
                "You need to select at least one item to Folderize!"
            )
        else:
            formatted_time = datetime.datetime.today().strftime(
                "%Y-%m-%dT%H-%M-%S"
            )

            dirname = expanduser(self.rest(1))

            if not dirname:
                if len(paths) >= 2:
                    dirname = os.path.join(
                        os.path.commonpath(paths), formatted_time
                    )
                else:
                    dirname = os.path.join(
                        os.path.dirname(paths[0]), formatted_time
                    )

            os.mkdir(dirname)

            for path in paths:
                shutil.move(path, dirname)
                self.fm.notify(str(len(paths)) + " items moved to " + dirname)
