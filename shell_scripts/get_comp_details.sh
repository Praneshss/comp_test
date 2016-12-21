
if [[ -z "$1" ]] || [[ -z "$2" ]]; then
    echo "Please input two filenames"
    echo "get_comp_details <uncompressed filename> <compressed filename>"
    exit 1;
fi

filename1=$1
filename2=$2

size1=`wc -c "$filename1" | awk '{print $1}'`
size2=`wc -c "$filename2" | awk '{print $1}'`

echo ""
echo "***The size of $filename1 = $size1 bytes"
echo ""
echo "***The size of $filename2 = $size2 bytes"
echo ""
compression_ratio=$(echo "$size1/$size2  " | bc -l);
space_savings=$(echo "1 - $size2/$size1  " | bc -l);

echo "***The compression ratio ($filename1 / $filename2 ) is  $compression_ratio"
echo "***The space savings of between $filename1 and  $filename2  is  $space_savings"
echo ""
