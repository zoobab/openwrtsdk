#!/bin/sh
for i in `cat targets.txt`; do
  arch=$(echo $i | cut -d "_" -f1)
  subarch=$(echo $i | cut -d "_" -f2)
  ./build.sh $arch $subarch 21.02.0-rc4
done
