#!/usr/bin/env bash

BASEDIR=$(cd -P -- "$(dirname -- "$0")" && pwd -P)

# resolve symlinks
while [ -h "$BASEDIR/$0" ]; do
    DIR=$(dirname -- "$BASEDIR/$0")
    SYM=$(readlink $BASEDIR/$0)
    BASEDIR=$(cd $DIR && cd $(dirname -- "$SYM") && pwd)
done
cd ${BASEDIR}

if [ -z ${1} ] || [ -z ${2} ]; then
  echo "Usage: ${0} <env> <version>"
  exit 1
fi

app=cake-redux
env=${1}
version=${2}

echo "> Assembling files"
secret_properties_file="application.properties"

ansible-vault decrypt "secretconfig/application-${env}.properties.encrypted" --output=${secret_properties_file}
if [ ! -f ${secret_properties_file} ]; then
    echo "Something went wrong with decrypting secret properties. File ${secret_properties_file} is missing. Can't deploy..."
    exit 1
fi

cp ~/.m2/repository/no/javazone/${app}/${version}/${app}-${version}.jar ./app.jar
if [ $? -ne 0 ]; then
  rm -f ${secret_properties_file}
  exit 1
fi

echo "> Packaging app"
zip -r app.zip app.jar .ebextensions Procfile ${secret_properties_file}
if [ $? -ne 0 ]; then
  rm -f app.jar ${secret_properties_file}
  echo "> Package failed!"
  exit 1
fi
rm -f app.jar ${secret_properties_file}
echo "> Done packaging app"
