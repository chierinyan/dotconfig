#!/bin/bash

completed_dir="`dirname "$3"`/completed"

mkdir -p "$completed_dir"
mv "$3" "$completed_dir"
