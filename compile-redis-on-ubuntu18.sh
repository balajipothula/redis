#!/bin/bash

# Author      : BALAJI POTHULA <balaji.pothula@techie.com>,
# Date        : 02 May 2020,
# Description : Installing / Compiling REDIS from Source Code.

# update package repositories.
sudo apt -y update

# build essentials installing.
sudo apt -y install build-essential gcc g++ make autoconf automake tcl

# redis source downloading and extracting.
curl -JL http://download.redis.io/redis-stable.tar.gz -o $HOME/redis-stable.tar.gz && \
tar  -xf $HOME/redis-stable.tar.gz -C $HOME                                        && \
rm   -rf $HOME/redis-stable.tar.gz                                                 && \
mv       $HOME/redis-stable $HOME/redissrc                                         && \
cd       $HOME/redissrc                                                            && \
make                                                                               && \
make test                                                                          && \
mkdir -p $HOME/redis/conf                                                          && \
make install PREFIX=$HOME/redis                                                    && \
cp       $HOME/redissrc/redis.conf $HOME/redis/conf
