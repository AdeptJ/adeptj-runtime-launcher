#!/bin/bash

###############################################################################
#                                                                             #
#    Copyright 2016, AdeptJ (http://www.adeptj.com)                           #
#                                                                             #
#    Licensed under the Apache License, Version 2.0 (the "License");          #
#    you may not use this file except in compliance with the License.         #
#    You may obtain a copy of the License at                                  #
#                                                                             #
#        http://www.apache.org/licenses/LICENSE-2.0                           #
#                                                                             #
#    Unless required by applicable law or agreed to in writing, software      #
#    distributed under the License is distributed on an "AS IS" BASIS,        #
#    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. #
#    See the License for the specific language governing permissions and      #
#    limitations under the License.                                           #
#                                                                             #
###############################################################################

# This script is used to stop running instance of AdeptJ Runtime.

BIN_PATH=$(cd $(dirname "$0") && pwd)
BASE_DIR=$(dirname "$BIN_PATH")

TARGET_DIR=$BASE_DIR"/target"

if [[ -d "$TARGET_DIR" ]]; then
  PID_FILE=$TARGET_DIR"/adeptj.pid"
else
  PID_FILE=$BASE_DIR"/adeptj.pid"
fi

if [ -e "$PID_FILE" ]; then
  kill $(cat "$PID_FILE")
  rm -f "$PID_FILE"
  echo "AdeptJ Runtime stopped!"
else
  echo -e '\033[31mCould not stop AdeptJ Runtime because adeptj.pid file not found, please stop it manually if it is still running.'
fi
exit 0