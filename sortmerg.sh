#!/bin/bash
usage () {
if [ $# -ne 2 ]; then
    echo "Usage: $0 file 1 file 2" 2>&1
    exit 1
    fi
  }
  
  # Default temporary directory
  : ${TEMPDIR:=/tmp}
  
  # Check argument count
  usage "$@"
  
  # Set up temporary files for sorting
  file1=$TEMPDIR/$$.file1
  file2=$TEMPDIR/$$.file2
  
  # Sort
  sort $1 > $file1
  sort $2 > $file2
  
  # Open $file 1 and $file 2 for reading. Use file descriptors 3 and 4. 
  exec 3<$file1
  exec 4<$file2
  
  # Read the first line from each file to figure out how to start.
  read Line1 <&3
  status1=$?
  read Line2 <&4
  status2=$?
  # Strategy: while there is still input left in both files:
  # Output the line that should come first.
  # Read a new line from the file that line came from.
  while [ $status1 -eq 0  -a $status2 -eq 0 ]
      do
          if [[ "$Line2" > "$Line1" ]]; then
             echo -e "1.\t$Line1"
             read -u3 Line1
             status1=$?
          else
             echo -e "2.\t$Line2"
             read -u4 Line2
             status1=$?
          fi
       done
       
    # Now one of the files is at end of file.
    # Read from each file until the end.
    # First file 1:
    while [ $status1 -eq 0 ]
        do
            echo -e "1.\t$Line1"
            read Line1 <&3
            status1=$?
        done
    #Next file 2:
    while [[ $status2 -eq 0 ]]
        do
           echo -e "2.\t$Line2"
           read Line2 <&4
           status2=$?
        done
        
     # Close and remove both input files
     exec 3<&- 4<&-
     rm -f $file1 $file2
     exit 0
