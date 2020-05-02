#!/bin/bash

# Author      : BALAJI POTHULA <balaji.pothula@techie.com>,
# Date        : 02 May 2020,
# Description : Installing / Compiling REDIS from Source Code.

# connecting to redis server.
# redis-cli -h 127.0.0.1 -p 6379 -a password PING

# exit immediately if a command exits with a non-zero exit status.
set -e

# debugging shell script.
set -x

# updating package repositories.
sudo apt -y update

# upgrading packages.
sudo apt -y upgrade

# installing build essentials.
sudo apt -y install autoconf        \
                    automake        \
                    build-essential \
                    g++             \
                    gcc             \
                    make            \
                    tcl

# redis source downloading, extracting, 
# compiling and installing.
curl -JL http://download.redis.io/redis-stable.tar.gz -o $HOME/redis-stable.tar.gz && \
tar  -xf $HOME/redis-stable.tar.gz -C $HOME                                        && \
rm   -rf $HOME/redis-stable.tar.gz                                                 && \
mv       $HOME/redis-stable $HOME/redissrc                                         && \
cd       $HOME/redissrc                                                            && \
make                                                                               && \
make test                                                                          && \
mkdir -p $HOME/redis                                                               && \
make install PREFIX=$HOME/redis                                                    && \
cd       $HOME                                                                     && \
cp       $HOME/redissrc/redis.conf $HOME/redis/conf                                && \
touch    $HOME/redis/{redis.log,redis.pid}                                         && \
echo "export PATH=$HOME/redis/bin:$PATH" | tee -a $HOME/.bashrc $HOME/.profile     && \
source   $HOME/.bashrc $HOME/.profile                                              && \
rm   -rf $HOME/redissrc
