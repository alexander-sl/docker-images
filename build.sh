USAGE_STRING="Usage: ./build.sh <image_prefix> <dockerfile_path>\nimageprefix: <image_prefix>/<image_name>dockerfile_path: relative path to Dockerfile (xenial/base/Dockerfile)image name would look like <prefix>/xenial/base"

IMAGE_PREFIX=$1
DOCKERFILE_PATH=$2
TAG=$3
DOCKER_GROUP=`cat /etc/group | grep docker | cut -d: -f 3`
DOCKERFILE_DIR=`dirname ${DOCKERFILE_PATH}`
DOCKER_IMAGE="${IMAGE_PREFIX}/${DOCKERFILE_DIR}"
USERID=`whoami | xargs id -u`
GROUPID=`whoami | xargs id -g`


build_image() {
    dockerfile_path=$1
    dockerfile_dir=`dirname ${dockerfile_path}`
    docker_image="${IMAGE_PREFIX}/${dockerfile_dir}"

    echo "Building $docker_image..."

    #docker build --build-arg DOCKER_GROUP=${DOCKER_GROUP} --build-arg USERID=${USERID} --build-arg GROUPID=${GROUPID} -f ${dockerfile_path} -t ${docker_image}:${TAG} ${dockerfile_dir}
}

build_dep() {
    local dockerfile_path=$1
    local dockerfile_dir=`dirname ${dockerfile_path}`
    local docker_image="${IMAGE_PREFIX}/${dockerfile_dir}"
    echo "Processing $dockerfile_path image $docker_image..."

    if [ -f $dockerfile_path ]; then
        # Dockerfile exists
        image_built=`docker images | grep $docker_image | awk '{ print $1 }'`
        if [ -z $image_built ]; then
            echo "No built image $docker_image found."
            if [ -f $dockerfile_dir/deps ]; then
                echo "Image $docker_image has dependencies"
                source $dockerfile_dir/deps
                for dep in ${DEPS[*]}
                do
                    echo "Processing dependency $dep for $docker_image"
                    build_dep $dep
                done
                build_image $dockerfile_path
            else
                build_image $dockerfile_path
            fi
        else
            echo "Image $docker_image is already built"
        fi
    fi
}

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

if [ -f $DOCKERFILE_PATH/deps ]; then
    source $DOCKERFILE_PATH/deps

fi
build_dep $DOCKERFILE_PATH
#docker build --build-arg DOCKER_GROUP=${DOCKER_GROUP} --build-arg USERID=${USERID} --build-arg GROUPID=${GROUPID} -f ${DOCKERFILE_PATH} -t ${DOCKER_IMAGE}:${TAG} ${DOCKERFILE_DIR}

