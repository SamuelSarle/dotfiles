#!/bin/sh

if [ -d "/home/samuel" ] ; then
	HOME="/home/samuel"
fi

if [ -d "$HOME/bin" ] ; then
	PATH="$HOME/bin:$PATH"
fi

if [ -d "$HOME/go/bin" ] ; then
	PATH="$HOME/go/bin:$PATH"
fi

if [ -d "$HOME/.local/bin" ] ; then
	PATH="$HOME/.local/bin:$PATH"
fi

if [ -d "$HOME/go" ] ; then
	GOPATH="$HOME/go"
fi

