#!/bin/bash

set -e

ollama cp llama3.2 alberttalkstech/problemChecker || echo "⚠️ Model may already exist, skipping copy."

ollama create alberttalkstech/problemChecker -f ./Modelfile

ollama push alberttalkstech/problemChecker

ollama pull alberttalkstech/problemChecker:latest

ollama run alberttalkstech/problemChecker:latest

