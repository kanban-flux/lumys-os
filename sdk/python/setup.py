from setuptools import setup

setup(
    name="lumys",
    version="0.1.0",
    description="Official Python client for the Lumys OS Agent OS REST API",
    py_modules=["lumys_sdk", "lumys_client"],
    python_requires=">=3.8",
    classifiers=[
        "Programming Language :: Python :: 3",
        "License :: OSI Approved :: MIT License",
        "Operating System :: OS Independent",
    ],
)
