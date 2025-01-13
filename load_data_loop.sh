
#execute with: ./load_data_loop.sh yellow 2020
#exit if any line returns error 
set -e

#bash is quite space and ''"" sensitive
#parameters to enter when execute
TAXI_TYPE=$1 #ex. "yellow"
YEAR=$2  #ex. 2020
URL_PREFIX="https://d37ci6vzurychx.cloudfront.net/trip-data"

#for loop in bash, do it for each month
for MONTH in {1..12}; do
    #formatted month with leading 0 on 1-9, but not on 10-12
    FMONTH=`printf "%02d" ${MONTH}`
    URL="${URL_PREFIX}/${TAXI_TYPE}_tripdata_${YEAR}-${FMONTH}.parquet"

    #place & name to save
    LOCAL_PREFIX="data/raw/${TAXI_TYPE}/${YEAR}/${FMONTH}"
    LOCAL_FILE="${TAXI_TYPE}_tripdata_${YEAR}-${FMONTH}.parquet"
    LOCAL_PATH="${LOCAL_PREFIX}/${LOCAL_FILE}"
    
    #print in bash
    echo "downloading ${URL}"
    #create parent folder if not exist
    mkdir -p ${LOCAL_PREFIX}
    #download the file with path&name
    wget ${URL} -O ${LOCAL_PATH}
    #optional, compress the file
    #gzip ${LOCAL_PATH}
done


