#!/bin/bash


for ((current=1;current<=5;current++))
do
    echo "Round: $current"

    # CPU-Test-1
    sysbench --test=cpu --cpu-max-prime=2000 run | tee cpu-test-1-$current.txt

    # CPU-Test-2
    sysbench --test=cpu --cpu-max-prime=5000 run | tee cpu-test-2-$current.txt

    # Memory-Test-1
    sysbench --test=memory --memory-block-size=1K run | tee memory-test-1-$current.txt

    # Memory-Test-2
    sysbench --test=memory --memory-block-size=1M run | tee memory-test-2-$current.txt

    # File Read
    sysbench --num-threads=1 --test=fileio --file-total-size=2G --file-test-mode=rndrd prepare && echo 3 > /proc/sys/vm/drop_caches
    sysbench --num-threads=1 --test=fileio --file-total-size=2G --file-test-mode=rndrd run | tee fileio-test-rndrd-$current.txt && echo 3 > /proc/sys/vm/drop_caches
    sysbench --num-threads=1 --test=fileio --file-total-size=2G --file-test-mode=rndrd cleanup && echo 3 > /proc/sys/vm/drop_caches


    # File Write
    sysbench --num-threads=1 --test=fileio --file-total-size=2G --file-test-mode=rndwr prepare && echo 3 > /proc/sys/vm/drop_caches
    sysbench --num-threads=1 --test=fileio --file-total-size=2G --file-test-mode=rndwr run | tee fileio-test-rndwr-$current.txt && echo 3 > /proc/sys/vm/drop_caches
    sysbench --num-threads=1 --test=fileio --file-total-size=2G --file-test-mode=rndwr cleanup && echo 3 > /proc/sys/vm/drop_caches

done
