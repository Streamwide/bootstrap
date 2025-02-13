#!/bin/bash

source ~/.nvm/nvm.sh

rm -rf package-lock.json node_modules
npm install && npm run dist

