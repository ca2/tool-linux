#!/bin/bash

# Make a backup
BACKUP_FILE="$1.bak"

# Create a fixed file
FIXED_FILE="$1.fix"

# Check if backup exists
if [ ! -f "$BACKUP_FILE" ]; then
    cp $1 $BACKUP_FILE
fi

# Stream input file to perl and output to fixed file
cat $1 | perl -pe 'BEGIN { binmode STDIN, ":utf8"; } s/(.)/ord($1) < 128 ? $1 : sprintf("\\U%08x", ord($1))/ge;' > $FIXED_FILE

# Remove old file
rm $1

# Replace old file with fixed file
mv $FIXED_FILE $1