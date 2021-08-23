#!/bin/bash -

# This is the script that will be executed when the container starts.
# It is intended to build one document with name $1 from the input directory to name $2 in the output director.

# strict error handling
set -o pipefail  # trace ERR through pipes
set -o errtrace  # trace ERR through 'time command' and other functions
set -o nounset   # set -u : exit the script if you try to use an uninitialized variable
set -o errexit   # set -e : exit the script if any statement returns a non-true return value

# enter the folder where the document is expected
cd /input/

echo "Now executing the main bookbuilding process."

python3 -c "from bookbuilderpy import Build; Build.run(input_file=\"/input/$1\", output_dir=\"/output/\");"

echo "Finished, exiting container."

exit