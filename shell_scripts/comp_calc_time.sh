if [[ -z "$1" ]] || [[ -z "$2" ]]; then
    echo "Please mention compression utility and two filenames"
    echo "comp_calc_time.sh <comp_utility_val> <uncompressed filename> <compressed filename>"
    echo "comp_utility values { 0 for QST , 1 for gzip , 2 for openssl zlib, 3 for zopfli } "
    exit 1;
fi
comp_util=$1
filename=$2
output=$3

START_TIME=`echo $(($(date +%s%N)/1000000))`

if [ $comp_util -eq 0 ]
then
 echo "Compression through QST"
./dc_stateful_sample 0 $filename  $output
elif [ $comp_util -eq 1 ]
then
 echo "Compression through GNU zip"
   gzip --verbose -c $filename > $output
elif [ $comp_util -eq 2 ]
then
 echo "Compression through openssl zlib"
openssl zlib -e -in $filename -out $output
elif [ $comp_util -eq 3 ]
then
 echo "Compression through zopfli"
 ./zopfli  --deflate $filename
output="$filename.deflate"
else
   echo "None of the values met for compression utility value"
fi

END_TIME=`echo $(($(date +%s%N)/1000000))`
ELAPSED_TIME=$(($END_TIME - $START_TIME))
echo "Time taken to compress is $ELAPSED_TIME ms"
./get_comp_details.sh $filename $output

