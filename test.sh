#!/bin/bash
[ "$(find $JENKINS_DIR/input_icon/23030100 -name efsf00000000_lbc.nc)" ] && find $JENKINS_DIR/input_icon/23030100 -name efsf00000000_lbc.nc || (echo "No boundary file found in output folder" && exit 1) 
[ "$(find $JENKINS_DIR/input_icon/23030100 -name laf2023030100.*)" ] && find $JENKINS_DIR/input_icon/23030100 -name laf2023030100.* || (echo "No analysis file found in output folder" && exit 1) 
