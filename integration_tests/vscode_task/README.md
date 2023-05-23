Integration tests VSCode task
=============================

Disclaimer: This experiment is not prod-ready, use at your own risk!

This experiment shows how Kurtosis can simplify the dev/test loop.  A developer is working on a Python REST API serving content from a Postgres DB.  The Kurtosis package `app-package` starts the Postgres DB, the Python app and runs some integration tests.  The VSCode task packages the Python app as a Docker image and runs the Kurtosis package.

Open the `vscode_task` directory in your VSCode IDE and press F1 to select and run the task.

Contents
--------

- `main.py`: Python app
- `Dockerfile`: Python app Dockerfile
- `app-package`: Kurtosis package
- `.vscode/tasks.json`: VSCode task calling `test.sh`
