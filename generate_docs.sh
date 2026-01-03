#!/usr/bin/env bash

vimcats -c lua/zavigate/config.lua > doc/zavigate-config.txt
nvim --headless "+helptags doc" +q
