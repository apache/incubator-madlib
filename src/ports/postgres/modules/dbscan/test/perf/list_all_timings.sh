cat $1 | grep _time | grep -v HDR | cut -f2 -d\| |  sort | uniq -c
