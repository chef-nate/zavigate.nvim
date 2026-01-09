#!/usr/bin/env bash
set -euo pipefail

unset LUA_PATH
unset LUA_CPATH

bash ./external/panvimdoc/panvimdoc.sh \
--project-name zavigate \
--input-file ./doc/zavigate.md \

nvim --headless "+helptags doc" +q
