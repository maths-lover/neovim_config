import http
import os


def main():
    print("Hello, world!")
    print("The current working directory is", os.getcwd())
    print("The current environment is", os.environ)
    print("The current HTTP status code is", http.HTTPStatus.OK)
    x = 5
    print(x)
