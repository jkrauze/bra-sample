#!/bin/bash
RESULT_FILE='result.md'
TEMP_BODY_FILE='body.tmp'
TEMP_OUTPUT_FILE='output.tmp'
APP_URL='http://localhost:8080'
AB_OPTS="-q"
CONCURRENT="1"
if [ ! -z $1 ]; then
	CONCURRENT="$1"
fi
API_PATH="items"
if [ ! -z $2 ]; then
	API_PATH="$2"
fi

function next() {
	echo
	echo "-----------------------------------------"
	echo "$1"
	echo "-----------------------------------------"
	echo
}

echo '{"name":"Hello World!"}' > $TEMP_BODY_FILE
echo > $RESULT_FILE

echo "Creating 100 items..."
ab $AB_OPTS -n 100 -c 1 -T application/json -p $TEMP_BODY_FILE $APP_URL/$API_PATH

echo "Warm up!"
ab $AB_OPTS -n 50000 -c 10 $APP_URL/$API_PATH

next "START!"

next "Getting single item 10000 times..."
ab $AB_OPTS -n 10000 -c $CONCURRENT $APP_URL/$API_PATH/54
cat $TEMP_OUTPUT_FILE >> $RESULT_FILE

echo "[{\"method\":\"GET\",\"path\":\"/$API_PATH/54\"}]" > $TEMP_BODY_FILE

next "Getting single item 10000 times using bra..."
ab $AB_OPTS -n 10000 -c $CONCURRENT -T application/json -p $TEMP_BODY_FILE $APP_URL/bra-v0
cat $TEMP_OUTPUT_FILE >> $RESULT_FILE

SINGLE_ITEM="{\"method\":\"GET\",\"path\":\"/$API_PATH/54\"}"
tmp_str='['
for i in `seq 9`; do tmp_str+="$SINGLE_ITEM,"; done
tmp_str+="$SINGLE_ITEM]"
echo "$tmp_str" > $TEMP_BODY_FILE

next "Getting 10 items 1000 times using bra..."
ab $AB_OPTS -n 1000 -c $CONCURRENT -T application/json -p $TEMP_BODY_FILE $APP_URL/bra-v0

tmp_str='['
for i in `seq 99`; do tmp_str+="$SINGLE_ITEM,"; done
tmp_str+="$SINGLE_ITEM]"
echo "$tmp_str" > $TEMP_BODY_FILE

next "Getting 100 items 100 times using bra..."
ab $AB_OPTS -n 100 -c $CONCURRENT -T application/json -p $TEMP_BODY_FILE $APP_URL/bra-v0
cat $TEMP_OUTPUT_FILE >> $RESULT_FILE

next "Getting single item 100000 times..."
ab $AB_OPTS -n 100000 -c $CONCURRENT $APP_URL/$API_PATH/54
cat $TEMP_OUTPUT_FILE >> $RESULT_FILE

echo "[{\"method\":\"GET\",\"path\":\"/$API_PATH/54\"}]" > $TEMP_BODY_FILE

next "Getting single item 100000 times using bra..."
ab $AB_OPTS -n 100000 -c $CONCURRENT -T application/json -p $TEMP_BODY_FILE $APP_URL/bra-v0
cat $TEMP_OUTPUT_FILE >> $RESULT_FILE

SINGLE_ITEM="{\"method\":\"GET\",\"path\":\"/$API_PATH/54\"}"
tmp_str='['
for i in `seq 9`; do tmp_str+="$SINGLE_ITEM,"; done
tmp_str+="$SINGLE_ITEM]"
echo "$tmp_str" > $TEMP_BODY_FILE

next "Getting 10 items 10000 times using bra..."
ab $AB_OPTS -n 10000 -c $CONCURRENT -T application/json -p $TEMP_BODY_FILE $APP_URL/bra-v0

tmp_str='['
for i in `seq 99`; do tmp_str+="$SINGLE_ITEM,"; done
tmp_str+="$SINGLE_ITEM]"
echo "$tmp_str" > $TEMP_BODY_FILE

next "Getting 100 items 1000 times using bra..."
ab $AB_OPTS -n 1000 -c $CONCURRENT -T application/json -p $TEMP_BODY_FILE $APP_URL/bra-v0
cat $TEMP_OUTPUT_FILE >> $RESULT_FILE

tmp_str='['
for i in `seq 999`; do tmp_str+="$SINGLE_ITEM,"; done
tmp_str+="$SINGLE_ITEM]"
echo "$tmp_str" > $TEMP_BODY_FILE

next "Getting 1000 items 100 times using bra..."
ab $AB_OPTS -n 100 -c $CONCURRENT -T application/json -p $TEMP_BODY_FILE $APP_URL/bra-v0
cat $TEMP_OUTPUT_FILE >> $RESULT_FILE
