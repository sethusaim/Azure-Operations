import os


class BlobConfig:
    def __init__(self):
        self.AZURE_CONN_STR = os.environ["AZURE_CONN_STR"]

    def get_blob_config(self):
        return self.__dict__
