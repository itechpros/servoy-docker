#!/bin/sh

echo "Running Servoy Start Script"
echo "Filling templates with environmental variables"
ep servoy_server_docker.sh
ep servoy.properties

echo "Starting Servoy"
./servoy_server_docker.sh
