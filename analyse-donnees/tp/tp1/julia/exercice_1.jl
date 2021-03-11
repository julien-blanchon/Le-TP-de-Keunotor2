#!/bin/bash
#=
exec julia -O0 --compile=min "${BASH_SOURCE[0]}" "$@"
=#
using ImageView, Images
I = load("ishihara-0.png");



@info "Hello world!"