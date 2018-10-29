#!/bin/bash

function run_test() {
	docker-compose up -d
	sleep 15
	$1 > $2
	docker-compose down
}

docker-compose down
run_test "./benchmark.sh 1 items" "tests_1_map"
run_test "./benchmark.sh 10 items" "tests_10_map"
run_test "./benchmark.sh 100 items" "tests_100_map"
run_test "./benchmark.sh 1 mongo-items" "tests_1_mongo"
run_test "./benchmark.sh 10 mongo-items" "tests_10_mongo"
run_test "./benchmark.sh 100 mongo-items" "tests_100_mongo"
