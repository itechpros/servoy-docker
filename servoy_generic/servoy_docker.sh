#!/bin/sh

echo "Running Servoy Start Script"
echo "Filling templates with environmental variables"
ep servoy_server.sh

echo "Starting Servoy"
servoy_server.sh
