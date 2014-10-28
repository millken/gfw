#!/bin/bash

NGX_LUA_VER=0.9.10
LUAJIT_VER=2.1-20140707
NGX_VER=1.7.2
DIR=$(cd "$(dirname "$0")"; pwd)

[ -d objs ] || mkdir objs;
[ -d gfw ] || mkdir gfw;
cd objs;

curl https://codeload.github.com/openresty/luajit2/tar.gz/v{$LUAJIT_VER} > luajit2.tar.gz
tar xf luajit2.tar.gz
cd luajit2-$LUAJIT_VER && make

cd ..
curl https://codeload.github.com/openresty/lua-nginx-module/tar.gz/v{$NGX_LUA_VER} > lua-nginx-module.tar.gz
tar xf lua-nginx-module.tar.gz

curl http://nginx.org/download/nginx-{$NGX_VER}.tar.gz > nginx.tar.gz
tar xf nginx.tar.gz

cd nginx-$NGX_VER

export LUAJIT_LIB={$DIR}/luajit2-{$LUAJIT_VER}/src
export LUAJIT_INC={$DIR}/luajit2-{$LUAJIT_VER}/src

./configure --prefix=$DIR/gfw \
        --add-module=$DIR/lua-nginx-module-$NGX_LUA_VER

make -j2 && make install

