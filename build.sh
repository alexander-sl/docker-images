#!/bin/bash

USAGE_STRING="Usage: ./build.sh PREFIX DOCKERFILE_PATH [TAG] [UID] [GID]\n  \
    PREFIX: some prefix for resulted image (e.g. ci)\n  \
    DOCKERFILE_PATH: relative path to Dockerfile (e.g. xenial/ops/Dockerfile.in)\n  \
    resulted image name will look like ci/xenial/ops\n  \
    TAG: tag to mark resulted image ('latest' will be used by default)\n  \
    UID: uid to be specified for 'developer' account inside image - current user uid by default\n  \
    GID: gid to be specified for 'developer' account inside image - current user gid by default"


IMAGE_PREFIX="$1"
shift
if [ -z $IMAGE_PREFIX ]; then
    echo "Error. Image prefix isn\'t specified"
    echo -e $USAGE_STRING
    exit 1
fi

DOCKERFILE_PATH="$1"
shift
if [ -z $DOCKERFILE_PATH ]; then
    echo Error. Dockerfile path isn\'t specified
    echo -e $USAGE_STRING
    exit 1
fi

if ! [ -f $DOCKERFILE_PATH ]; then
    echo "File ${DOCKERFILE_PATH} doesn't exists"
    exit 1
fi

TAG="$1"
shift
if [ -z $TAG ]; then
    TAG=latest
fi

USERID="$1"
shift
if [ -z $USERID ]; then
    USERID=`whoami | xargs id -u`
fi

GROUPID="$1"
shift
if [ -z $GROUPID ]; then
    GROUPID=`whoami | xargs id -g`
fi

DOCKER_GROUP=`cat /etc/group | grep docker | cut -d: -f 3`
if [ -z $DOCKER_GROUP ]; then
    DOCKER_GROUP=999
fi

build_image() {
    dockerfile_path=$1
    dockerfile_dir=`dirname ${dockerfile_path}`
    docker_image="${IMAGE_PREFIX}/${dockerfile_dir}"
    if ! [ -z $2 ]; then
        base_image_name=`dirname $2`
        base_image_name=${IMAGE_PREFIX}/${base_image_name}
        base_image_name=`echo $base_image_name | sed 's=/=\\\/=g'`
        `sed -e "s/##base_image/${base_image_name}:${TAG}/g" $dockerfile_path > $dockerfile_dir/Dockerfile`
        dockerfile_path=$dockerfile_dir/Dockerfile
    fi

    echo "... building $docker_image $base_image ..."

    docker build --build-arg DOCKER_GROUP=${DOCKER_GROUP} --build-arg USERID=${USERID} --build-arg GROUPID=${GROUPID} -f ${dockerfile_path} -t ${docker_image}:${TAG} ${dockerfile_dir}
}

build_dep() {
    local dockerfile_path=$1
    local base_image=$2
    local dockerfile_dir=`dirname ${dockerfile_path}`
    local deps_suffix=`echo ${dockerfile_dir} | sed 's/\//_/g'`
    local deps_var="DEPS_${deps_suffix}"
    local docker_image="${IMAGE_PREFIX}/${dockerfile_dir}"
    echo "== Processing $dockerfile_path image $docker_image..."

    if [ -f $dockerfile_path ]; then
        # Dockerfile exists
        # Check image exists...
#        image_built=`docker images | grep $docker_image | awk '{ print $1 }'`
#        if [ -z $image_built ]; then
#            echo "No built image $docker_image found."

            if [ -f $dockerfile_dir/deps ]; then
                #Image has dependencies
                echo "=== Image $docker_image has dependencies"
                source $dockerfile_dir/deps
                local deps=${!deps_var}
                if ! [ -z $deps ]; then
                    echo "==== Processing dependency $deps for $docker_image"
                    build_dep $deps
                fi
                build_image $dockerfile_path $deps
            else
                build_image $dockerfile_path
            fi
#        else
#            echo "Image $docker_image is already built"
#        fi
    fi
}


DOCKERFILE_DIR=`dirname ${DOCKERFILE_PATH}`
DOCKER_IMAGE="${IMAGE_PREFIX}/${DOCKERFILE_DIR}"
echo = Building image \'${DOCKER_IMAGE}\' from ${DOCKERFILE_PATH}, docker groupid is \'${DOCKER_GROUP}\'

build_dep $DOCKERFILE_PATH

