import hashlib
import os.path
import pathlib
import ranger.api
import ranger.core.linemode


@ranger.api.register_linemode
class MD5Linemode(ranger.core.linemode.LinemodeBase):
    name = "md5"

    def get_file_hash(self, path):
        return hashlib.md5(pathlib.Path(path).read_bytes()).hexdigest()

    def filetitle(self, file, metadata):
        return file.relative_path

    def infostring(self, file, metadata):
        if os.path.isdir(file.path):
            raise NotImplementedError
        else:
            return self.get_file_hash(file.path)
