#!/bin/bash

echo "Building box..."
vagrant up

if [ -f package.box ]; then
  rm package.box
fi

echo "Packing..."
vagrant package

