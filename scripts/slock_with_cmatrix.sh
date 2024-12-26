#!/bin/bash

# Run cmatrix in the background
cmatrix -b &   # `-b` is optional, adjust cmatrix options as needed
CMATRIX_PID=$! # Get the PID of cmatrix

# Save current shell history
history -a # Append session history to the history file

# Run slock
slock

# Kill cmatrix after slock unlocks
kill $CMATRIX_PID 

# Reset the terminal to a usable state
reset

# Reload the saved history
history -r
