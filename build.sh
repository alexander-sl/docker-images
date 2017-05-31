USAGE_STRING="Usage: ./build.sh <image_prefix> <dockerfile_path>\nimageprefix: <image_prefix>/<image_name>dockerfile_path: relative path to Dockerfile (xenial/base/Dockerfile)image name would look like <prefix>/xenial/base"

IMAGE_PREFIX=$1
DOCKERFILE_PATH=$2
TAG=$3
DOCKER_GROUP=`cat /etc/group | grep docker | cut -d: -f 3`
DOCKERFILE_DIR=`dirname ${DOCKERFILE_PATH}`
DOCKER_IMAGE="${IMAGE_PREFIX}/${DOCKERFILE_DIR}"
USERID=`whoami | xargs id -u`
GROUPID=`whoami | xargs id -g`


if [ -z $TAG]; then
    TAG=latest
fi
if [ -z $IMAGE_PREFIX ]; then
    echo "Error. Image prefix isn\'t specified"
    echo $USAGE_STRING
    exit 1
fi

if [ -z $DOCKERFILE_PATH ]; then
    echo Error. Dockerfile path isn\'t specified
    echo $USAGE_STRING
    exit 1
fi

if ! [ -f $DOCKERFILE_PATH ]; then
    echo "File ${DOCKERFILE_PATH} doesn't exists"
    exit 1
fi

if [ -z DOCKER_GROUP ]; then
    DOCKER_GROUP=999
fi

echo Building image \'${DOCKER_IMAGE}\' from ${DOCKERFILE_PATH}, docker groupid is \'${DOCKER_GROUP}\'


docker build --build-arg DOCKER_GROUP=${DOCKER_GROUP} --build-arg USERID=${USERID} --build-arg GROUPID=${GROUPID} -f ${DOCKERFILE_PATH} -t ${DOCKER_IMAGE}:${TAG} ${DOCKERFILE_DIR}

