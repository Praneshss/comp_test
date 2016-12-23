if [[ -z "$1" ]] || [[ -z "$2" ]]; then
    echo "Please mention compression utility and two filenames"
    echo "decomp_calc_time.sh <comp_utility_val> <compressed filename> <expected filename> "
    echo "comp_utility values { 0 for QST , 1 for gzip , 2 for openssl zlib, 3 for zopfli } "
    exit 1;
fi
comp_util=$1
filename=$2
output=$3

START_TIME=`echo $(($(date +%s%N)/1000000))`

if [ $comp_util -eq 0 ]
then
 echo "Decompression through QST"
./dc_decomp_stateful_sample 0 $filename  $output
elif [ $comp_util -eq 1 ]
then
 echo "Decompression through GNU zip"
   gunzip --verbose -c $filename > $output
elif [ $comp_util -eq 2 ]
then
 echo "Decompression through openssl zlib"
openssl zlib -d -in $filename -out $output
elif [ $comp_util -eq 3 ]
then
 echo "Decompression through zopfli"
 ./zopfli  --deflate $filename
output="$filename.deflate"
else
   echo "None of the values met for compression utility value"
fi

END_TIME=`echo $(($(date +%s%N)/1000000))`
ELAPSED_TIME=$(($END_TIME - $START_TIME))
echo "Time taken to compress is $ELAPSED_TIME ms"
size1=`wc -c "$filename" | awk '{print $1}'`
size2=`wc -c "$output" | awk '{print $1}'`

echo ""
echo "***The size of $filename = $size1 bytes"
echo ""
echo "***The size of $output = $size2 bytes"
echo ""
