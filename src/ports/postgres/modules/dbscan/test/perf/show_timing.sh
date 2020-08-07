#!/bin/bash
if [ -z "$1" ]
then
    echo "Usage: cat FILE | $0 [yield1|yield2|...]"
    exit -1
fi
cat |grep $1 | grep -v HDR | cut -f3 -d\| | sum.py
