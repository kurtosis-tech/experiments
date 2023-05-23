#!/bin/bash

docker build -t app:0.1 .
kurtosis clean -a
kurtosis run --enclave tests app-package/
