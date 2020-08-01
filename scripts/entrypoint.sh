#!/usr/bin/env bash

# Source ASDF helpers
. $HOME/.asdf/asdf.sh

# Add local bin folder to path
export PATH=~/.local/bin:$PATH

# Launch bash with all parameters
/bin/bash -c "$@"
