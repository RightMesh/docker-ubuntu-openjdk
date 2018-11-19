Docker Ubuntu with OpenJDK
==========================

This repository contains some simple Dockerfiles for LTS releases of
Ubuntu, with the OpenJDK-8 installed. These images can be used as simple
dev environments, or as runtime environments for CI runners, etc.

Building the images
------------------

To build the images, run the following and grab a coffee:

    git clone https://github.com/RightMesh/docker-ubuntu-openjdk.git
    cd docker-ubuntu-openjdk
    sudo make [all | bionic | xenial]

Using the images
----------------

You can use the prebuilt images from [Docker Hub](hub.docker.io). Pull
one of the following:

    docker pull rightmesh/ubuntu-openjdk:16.04
    docker pull rightmesh/ubuntu-openjdk:18.04

Then run one of the follow, depending on what was built:

    docker run rightmesh/ubuntu-openjdk:16.04 <commands>
    docker run rightmesh/ubuntu-openjdk:18.04 <commands>
