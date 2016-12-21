#########################################################################
To create a single character file of any length ,used this below commands.

To create a file with just single letter "A" and size of nearly 4.8MB.
< /dev/urandom tr -dc "A" | head -c5000000 > file_5M.txt

To create a file with just single letter "A" and size of nearly 48MB.
< /dev/urandom tr -dc "A" | head -c50000000 > file_50M.txt

########################################################################
To create a file with random characters, use the script create_sample_file.sh

usage: 
pranesh@localhost#./create_sample_file.sh testfile 1024*1024*5

We can generate max 2.6G sample file using this script
########################################################################
