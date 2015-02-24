#!/bin/bash
root=`node -e "console.log(require('packageroot').sync('./'))"`
version=`$root/bin/nwversion.js`
nwgyp=$root/node_modules/.bin/nw-gyp

serialport=`$root/bin/to-serialport`
cd $serialport
$root/bin/patch-crosswalk ./

if [ "$?" != "0" ]; then
 echo "failed to patch crosswalk. node-pre-gyp in node-serial has probably been updated."
 exit 1
fi

./node_modules/.bin/node-pre-gyp rebuild --runtime=node-webkit --target=0.12.0-alpha3

mv ./build/serialport/v1.5.0/Release/node-webkit-v14-linux-x64 ./build/serialport/v1.5.0/Release/node-v43-linux-x64

cp -fr ./build/serialport/v1.5.0/Release/node-v43-linux-x64 ./build/serialport/v1.5.0/Release/node-webkit-v43-linux-x64

