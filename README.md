# Batch Request API Benchmark

Having 100 items stored.

Tests:

1. Getting 10000 objects
  1. 10000x `GET /items/54`
  1. 10000x `POST /bra-v0` requesting `GET /items/54`
  1. 1000x `POST /bra-v0` requesting 10x `GET /items/54`
  1. 100x `POST /bra-v0` requesting 100x `GET /items/54`
1. Getting 100000 objects
  1. 100000x `GET /items/54`
  1. 100000x `POST /bra-v0` requesting `GET /items/54`
  1. 10000x `POST /bra-v0` requesting 10x `GET /items/54`
  1. 1000x `POST /bra-v0` requesting 100x `GET /items/54`
  1. 100x `POST /bra-v0` requesting 1000x `GET /items/54`

Tests will be run:

1. Without concurrency
1. With 10 concurrent threads
1. With 100 concurrent threads

and

1. On HashMap based repository (`/items` in `SampleController`)
1. On Reactive MongoDB repository (`/mongo-items` in `SampleMongoController`)

Before each test run docker containers will be recreated.

## Running tests

To recreate tests execute `run.sh` bash script.

## Results

* [Without concurrency on HashMap repository](test_1_map)
  * 10k elements
    1. 10000x ORIG: Done in 7.320s
    1. 10000x1 BRA: Done in 12.255s
    1. 1000x10 BRA: Done in 1.558s
    1. 100x100 BRA: Done in **0.658s**
  * 100k elements
    1. 100000x ORIG: Done in 56.638s
    1. 100000x1 BRA: Done in 81.478s
    1. 10000x10 BRA: Done in 13.962s
    1. 1000x100 BRA: Done in 6.063s
    1. 100x1000 BRA: Done in **5.067s**
* [With 10 concurrent threads on HashMap repository](test_10_map)
  * 10k elements
    1. 10000x ORIG: Done in 3.841s
    1. 10000x1 BRA: Done in 8.347s
    1. 1000x10 BRA: Done in 1.134s
    1. 100x100 BRA: Done in **0.416s**
  * 100k elements
    1. 100000x ORIG: Done in 20.699s
    1. 100000x1 BRA: Done in 28.972s
    1. 10000x10 BRA: Done in 5.928s
    1. 1000x100 BRA: Done in 3.018s
    1. 100x1000 BRA: Done in **2.617s**
* [With 100 concurrent threads on HashMap repository](test_100_map)
  * 10k elements
    1. 10000x ORIG: Done in 3.018s
    1. 10000x1 BRA: Done in 6.854s
    1. 1000x10 BRA: Done in 1.230s
    1. 100x100 BRA: Done in **0.621s**
  * 100k elements
    1. 100000x ORIG: Done in 17.862s
    1. 100000x1 BRA: Done in 24.352s
    1. 10000x10 BRA: Done in 5.685s
    1. 1000x100 BRA: Done in 2.690s
    1. 100x1000 BRA: Done in **2.496s**


* [Without concurrency on MongoDB repository](test_1_mongo)
  * 10k elements
    1. 10000x ORIG: Done in 12.056s
    1. 10000x1 BRA: Done in 15.192s
    1. 1000x10 BRA: Done in 2.766s
    1. 100x100 BRA: Done in **1.571s**
  * 100k elements
    1. 100000x ORIG: Done in 100.900s
    1. 100000x1 BRA: Done in 125.835s
    1. 10000x10 BRA: Done in 25.682s
    1. 1000x100 BRA: Done in 15.231s
    1. 100x1000 BRA: Done in **14.134s**
* [With 10 concurrent threads on MongoDB repository](test_10_mongo)
  * 10k elements
    1. 10000x ORIG: Done in 5.763s
    1. 10000x1 BRA: Done in 8.559s
    1. 1000x10 BRA: Done in 2.099s
    1. 100x100 BRA: Done in **1.631s**
  * 100k elements
    1. 100000x ORIG: Done in 34.893s
    1. 100000x1 BRA: Done in 44.710s
    1. 10000x10 BRA: Done in 15.834s
    1. 1000x100 BRA: Done in **10.889s**
    1. 100x1000 BRA: Done in 11.151s
* [With 100 concurrent threads on MongoDB repository](test_100_mongo)
  * 10k elements
    1. 10000x ORIG: Done in 5.470s
    1. 10000x1 BRA: Done in 8.950s
    1. 1000x10 BRA: Done in 2.684s
    1. 100x100 BRA: Done in **1.920s**
  * 100k elements
    1. 100000x ORIG: Done in 27.902s
    1. 100000x1 BRA: Done in 37.519s
    1. 10000x10 BRA: Done in 15.109s
    1. 1000x100 BRA: Done in 11.024s
    1. 100x1000 BRA: Done in **10.889s**
