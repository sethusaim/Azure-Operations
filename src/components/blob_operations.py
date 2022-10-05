import logging
import pickle
import sys
from io import StringIO
from os import listdir, remove
from os.path import join
from pickle import loads
from shutil import rmtree
from typing import Any

from azure.storage.blob import BlobServiceClient, ContainerClient

from src.constant import SAVE_FORMAT
from src.entity.config_entity import BlobConfig
from src.exception import CustomException
from src.logger import logging


class BlobOperation:
    def __init__(self):
        self.blob_config = BlobConfig()

    def get_blob_client(
        self, blob_filename: str, container_name: str
    ) -> BlobServiceClient:
        """
        Method Name :   get_blob_client
        Description :   This method gets the blob client based on the blob_filename and container filename
        
        Output      :   BlobServiceClient object is returned 
        On Failure  :   Raise a Custom Exception
        
        Version     :   1.2
        Revisions   :   Moved to setup to cloud 
        """
        logging.info("Entered get_blob_client method of BlobOperation class")

        try:
            client = BlobServiceClient.from_connection_string(
                self.blob_config.AZURE_CONN_STR
            )

            logging.info("Got BlobServiceClient from connection string")

            blob_client = client.get_blob_client(container_name, blob_filename)

            logging.info(
                f"Got blob client for {blob_filename} blob from {container_name} container_name"
            )

            logging.info("Exited get_blob_client method of BlobOperation class ")

            return blob_client

        except Exception as e:
            raise CustomException(e, sys) from e

    def get_container_client(self, container_name: str) -> ContainerClient:
        """
        Method Name :   get_container_client
        Description :   This method gets the container client based on the container_name
        
        Output      :   ContainerClient object is returned 
        On Failure  :   Raise a Custom Exception
        
        Version     :   1.2
        Revisions   :   Moved to setup to cloud 
        """
        logging.info("Entered get_container_client method of BlobOperation class")

        try:
            container_client = ContainerClient.from_connection_string(
                self.blob_config.AZURE_CONN_STR, container_name
            )

            logging.info("Got container_name client from connection string")

            logging.info("Exited get_container client method of BlobOperation class")

            return container_client

        except Exception as e:
            raise CustomException(e, sys) from e

    def get_object(self, filename: str, container_name: str) -> object:
        """
        Method Name :   get_object
        Description :   This method gets file object based on filename from container_name container
        
        Output      :   File object is returned based on filename from container_name container
        On Failure  :   Raise a Custom Exception
        
        Version     :   1.2
        Revisions   :   Moved to setup to cloud 
        """
        logging.info("Entered get_object method of BlobOperation class")

        try:
            client = self.get_container_client(container_name)

            blob_object = client.download_blob(blob=filename)

            logging.info(f"Got {filename} info from {container_name} container_name")

            logging.info("Exited get_object method of BlobOperation class")

            return blob_object

        except Exception as e:
            raise CustomException(e, sys) from e

    @staticmethod
    def read_object(
        object: object, decode: bool = True, make_readable: bool = False
    ) -> StringIO:
        """
        Method Name :   read_object
        Description :   This method reads the blob object with kwargs
        
        Output      :   ContainerClient object is returned 
        On Failure  :   Raise a Custom Exception
        
        Version     :   1.2
        Revisions   :   Moved to setup to cloud 
        """
        logging.info("Entered read_object method of BlobOperation class")

        try:
            func = (
                lambda: object.readall().decode()
                if decode is True
                else object.readall()
            )

            logging.info(f"Read {object} object with decode as {decode}")

            conv_func = lambda: StringIO(func()) if make_readable is True else func()

            logging.info(f"Read {object} with make_readable as {make_readable}")

            logging.info("Exited read_object method of BlobOperation class")

            return conv_func()

        except Exception as e:
            raise CustomException(e, sys) from e

    def load_model(
        self, model_name: str, container_name: str, model_dir: str = None
    ) -> pickle:
        """
        Method Name :   load_model
        Description :   This method loads the model based on model_name from container_name container based on model_dir
        
        Output      :   ContainerClient object is returned 
        On Failure  :   Raise a Custom Exception
        
        Version     :   1.2
        Revisions   :   Moved to setup to cloud 
        """
        logging.info("Entered load_model method of BlobOperation class")

        try:
            func = (
                lambda: model_name + SAVE_FORMAT
                if model_dir is None
                else model_dir + "/" + model_name + SAVE_FORMAT
            )

            model_file = func()

            logging.info(f"Got {model_file} as model file")

            f_obj = self.get_object(model_file, container_name)

            model_content = self.read_object(f_obj, decode=False)

            model = loads(model_content)

            logging.info(
                f"Loaded {model_name} model from {container_name} container_name"
            )

            logging.info("Exited load_model method of BlobOperation class")

            return model

        except Exception as e:
            raise CustomException(e, sys) from e

    def delete_file(self, filename: str, container_name: str) -> None:
        """
        Method Name :   delete_file
        Description :   This method deletes the filename file from container_name container
        
        Output      :   filename file is deleted from the container_name container
        On Failure  :   Raise a Custom Exception
        
        Version     :   1.2
        Revisions   :   Moved to setup to cloud 
        """
        logging.info("Entered delete_file method of BlobOperation class")

        try:
            client = self.get_container_client(container_name)

            client.delete_blob(filename)

            logging.info(
                f"Deleted {filename} file from {container_name} container_name"
            )

            logging.info("Exited delete_file method of BlobOperation class")

        except Exception as e:
            raise CustomException(e, sys) from e

    def load_file(self, filename: str, container_name: str) -> bool:
        """
        Method Name :   load_file
        Description :   This method loads the filename file from container_name container
        
        Output      :   Returns True if the filename file exists else False
        On Failure  :   Raise a Custom Exception
        
        Version     :   1.2
        Revisions   :   Moved to setup to cloud 
        """
        logging.info("Entered load_file method of BlobOperation class")

        try:
            blob_client = self.get_blob_client(filename, container_name)

            logging.info("Got blob client from blob service client")

            _file = blob_client.exists()

            logging.info(f"{filename} file exists is {_file}")

            logging.info("Exited load_file method of BlobOperation class")

            return _file

        except Exception as e:
            raise CustomException(e, sys) from e

    def upload_file(
        self,
        local_filename: str,
        container_filename: str,
        container_name: str,
        delete: bool = True,
        replace: bool = True,
    ) -> None:
        """
        Method Name :   upload_file
        Description :   This method uploads the the local_filename file to container_name container with container_filename
        
        Output      :   local_filename file is uploaded to container_name container with container_filename
        On Failure  :   Raise a Custom Exception
        
        Version     :   1.2
        Revisions   :   Moved to setup to cloud 
        """
        logging.info("Entered upload_file method of BlobOperation class")

        try:
            client = self.get_container_client(container_name)

            if replace is True:
                f = self.load_file(container_filename, container_name)

                logging.info(
                    f"{container_filename} file exists is {f}, and replace option is set to {replace}..Deleting the file"
                )

                if f is True:
                    self.delete_file(container_filename, container_name)

                else:
                    logging.info(f"{container_filename} file exists is {f}",)

                with open(local_filename, "rb") as f:
                    client.upload_blob(data=f, name=container_filename)

                logging.info(
                    f"Uploaded {local_filename} to {container_name} container_name with name as {container_filename} file"
                )

            else:
                logging.info(
                    f"Replace option is set to {replace}, not replacing the {container_filename} file in {container_name} container_name",
                )

            if delete is True:
                remove(local_filename)

                logging.info(
                    f"delete option is set to {delete}, deleted {local_filename} from local"
                )

            else:
                logging.info(
                    f"deleted option is set to {delete}, not removing the {local_filename} from local"
                )

            logging.info("Exited upload_file method of BlobOperation class")

        except Exception as e:
            raise CustomException(e, sys) from e

    def upload_folder(
        self, folder_name: str, container_name: str, delete: bool = True
    ) -> None:
        """
        Method Name :   upload_folder
        Description :   This method uploads folder_name folder to container_name container with kwargs
        
        Output      :   folder_name folder is uploaded to container_name container
        On Failure  :   Raise a Custom Exception
        
        Version     :   1.2
        Revisions   :   Moved to setup to cloud 
        """
        logging.info("Entered upload_folder method of BlobOperation class")

        try:
            lst = listdir(folder_name)

            logging.info(f"Got list of files from the {folder_name} folder")

            logging.info(f"Uploading files from {folder_name} folder to container")

            for f in lst:
                local_f = join(folder_name, f)

                dest_f = folder_name + "/" + f

                self.upload_file(local_f, dest_f, container_name)

            if delete is True:
                rmtree(folder_name)

            else:
                pass

            logging.info(f"Uploaded {folder_name} folder_name to container_name")

            logging.info("Exited upload_folder method of BlobOperation class")

        except Exception as e:
            raise CustomException(e, sys) from e
