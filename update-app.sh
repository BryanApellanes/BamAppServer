#!/bin/bash
# copies $1 to ~/.bam/content/apps/$1

echo removing ~/.bam/content/apps/$1
rm -fr ~/.bam/content/apps/$1

echo copying ./apps/$1 to ~/.bam/content/apps/$1
cp -R ./apps/$1 ~/.bam/content/apps/$1
