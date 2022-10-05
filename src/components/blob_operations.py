import logging
import sys
from io import StringIO
from os import environ, listdir, remove
from os.path import join
from pickle import loads
from shutil import rmtree

from azure.storage.blob import BlobServiceClient, ContainerClient

from src.exception import CustomException
from src.utils.read_params import read_params


class BlobOperation:
    def __init__(self):
        self.log_writer = logging.getLogger(__name__)

        self.config = read_params()

        self.save_format = self.config["save_format"]

        self.connection_string = environ["AZURE_CONN_STR"]

    def get_blob_client(self, blob_fname, container):
        self.log_writer.info("Entered get_blob_client method of BlobOperation class")

        try:
            client = BlobServiceClient.from_connection_string(self.connection_string)

            self.log_writer.info("Got BlobServiceClient from connection string")

            blob_client = client.get_blob_client(container=container, blob=blob_fname)

            self.log_writer.info(
                f"Got blob client for {blob_fname} blob from {container} container"
            )

            self.log_writer.info("exit")

            return blob_client

        except Exception as e:
            raise CustomException(e, sys) from e

    def get_container_client(self, container):
        self.log_writer.info(
            "Entered get_container_client method of BlobOperation class"
        )

        try:
            container_client = ContainerClient.from_connection_string(
                self.connection_string, container
            )

            self.log_writer.info("Got container client from connection string")

            self.log_writer.info(
                "Exited get_container client method of BlobOperation class"
            )

            return container_client

        except Exception as e:
            raise CustomException(e, sys) from e

    def get_object(self, fname, container):
        self.log_writer.info("Entered get_object method of BlobOperation class")

        try:
            client = self.get_container_client(container)

            f = client.download_blob(blob=fname)

            self.log_writer.info(f"Got {fname} info from {container} container")

            self.log_writer.info("Exited get_object method of BlobOperation class")

            return f

        except Exception as e:
            raise CustomException(e, sys) from e

    def read_object(self, object, decode=True, make_readable=False):
        self.log_writer.info("Entered read_object method of BlobOperation class")

        try:
            func = (
                lambda: object.readall().decode()
                if decode is True
                else object.readall()
            )

            self.log_writer.info(f"Read {object} object with decode as {decode}")

            conv_func = lambda: StringIO(func()) if make_readable is True else func()

            self.log_writer.info(f"Read {object} with make_readable as {make_readable}")

            self.log_writer.info("Exited read_object method of BlobOperation class")

            return conv_func()

        except Exception as e:
            raise CustomException(e, sys) from e

    def load_model(self, model_name, container, model_dir=None):
        self.log_writer.info("Entered load_model method of BlobOperation class")

        try:
            func = (
                lambda: model_name + self.save_format
                if model_dir is None
                else model_dir + "/" + model_name + self.save_format
            )

            model_file = func()

            self.log_writer.info(f"Got {model_file} as model file")

            f_obj = self.get_object(model_file, container)

            model_content = self.read_object(f_obj, decode=False)

            model = loads(model_content)

            self.log_writer.info(
                f"Loaded {model_name} model from {container} container"
            )

            self.log_writer.info("Exited load_model method of BlobOperation class")

            return model

        except Exception as e:
            raise CustomException(e, sys) from e

    def delete_file(self, fname, container):
        self.log_writer.info("Entered delete_file method of BlobOperation class")

        try:
            client = self.get_container_client(container)

            client.delete_blob(fname)

            self.log_writer.info(f"Deleted {fname} file from {container} container")

            self.log_writer.info("Exited delete_file method of BlobOperation class")

        except Exception as e:
            raise CustomException(e, sys) from e

    def load_file(self, fname, container):
        self.log_writer.info("Entered load_file method of BlobOperation class")

        try:
            blob_client = self.get_blob_client(fname, container)

            self.log_writer.info("Got blob client from blob service client")

            f = blob_client.exists()

            self.log_writer.info(f"{fname} file exists is {f}")

            self.log_writer.info("Exited load_file method of BlobOperation class")

            return f

        except Exception as e:
            raise CustomException(e, sys) from e

    def upload_file(
        self, local_fname, container_fname, container, delete=True, replace=True
    ):
        self.log_writer.info("Entered upload_file method of BlobOperation class")

        try:
            client = self.get_container_client(container)

            if replace is True:
                f = self.load_file(container_fname, container)

                self.log_writer.info(
                    f"{container_fname} file exists is {f}, and replace option is set to {replace}..Deleting the file"
                )

                if f is True:
                    self.delete_file(container_fname, container)

                else:
                    self.log_writer.info(f"{container_fname} file exists is {f}",)

                with open(local_fname, "rb") as f:
                    client.upload_blob(data=f, name=container_fname)

                self.log_writer.info(
                    f"Uploaded {local_fname} to {container} container with name as {container_fname} file"
                )

            else:
                self.log_writer.info(
                    f"Replace option is set to {replace}, not replacing the {container_fname} file in {container} container",
                )

            if delete is True:
                remove(local_fname)

                self.log_writer.info(
                    f"delete option is set to {delete}, deleted {local_fname} from local"
                )

            else:
                self.log_writer.info(
                    f"deleted option is set to {delete}, not removing the {local_fname} from local"
                )

            self.log_writer.info("Exited upload_file method of BlobOperation class")

        except Exception as e:
            raise CustomException(e, sys) from e

    def upload_folder(self, folder, container, delete=True):
        self.log_writer.info("Entered upload_folder method of BlobOperation class")

        try:
            lst = listdir(folder)

            self.log_writer.info(f"Got list of files from the {folder} folder")

            self.log_writer.info(f"Uploading files from {folder} folder to container")

            for f in lst:
                local_f = join(folder, f)

                dest_f = folder + "/" + f

                self.upload_file(local_f, dest_f, container)

            if delete is True:
                rmtree(folder)

            else:
                pass

            self.log_writer.info(f"Uploaded {folder} folder to container")

            self.log_writer.info("Exited upload_folder method of BlobOperation class")

        except Exception as e:
            raise CustomException(e, sys) from e
