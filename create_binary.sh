#!/bin/bash

IMAGE_PREFIX=$1
DOCKERFILE_DIR=$2
IMAGE_UPPER_LAYER=$(echo "${DOCKERFILE_DIR#*/}")
BIN_DIR=${HOME}/bin
RUN_SCRIPT="eclipse-${IMAGE_UPPER_LAYER}-${IMAGE_PREFIX}.sh"

if ! [ -d ${BIN_DIR} ]; then
    mkdir -p ${BIN_DIR}
fi

cd ${BIN_DIR}

if ! [ -f ${RUN_SCRIPT} ]; then
    touch ${RUN_SCRIPT}
    chmod 775 ${RUN_SCRIPT}
fi

cat << EOF > ${RUN_SCRIPT}
#!/bin/bash

C_HOME=/home/developer
HOST_WORKSPACE_DIR=\${HOME}/eclipse/workspace
ECLIPSE_SETTINGS_DIR=\${HOME}/eclipse/settings
IPI_DIR=\${HOME}/src
IMAGE_NAME="${IMAGE_PREFIX}/${DOCKERFILE_DIR}"

if ! [ -d \$IPI_DIR ]; then
   mkdir -p \$IPI_DIR
fi

MOUNT_PARAMS="\
    --privileged \
    -v \${IPI_DIR}:\${C_HOME}/src \
    -v /var/run/docker.sock:/var/run/docker.sock \
    --name eclipse-${IMAGE_UPPER_LAYER}-${IMAGE_PREFIX}"

if ! [ -d \$HOST_WORKSPACE_DIR ]; then
    mkdir -p \$HOST_WORKSPACE_DIR
fi

if ! [ -d \$ECLIPSE_SETTINGS_DIR ]; then
    mkdir -p \$ECLIPSE_SETTINGS_DIR
fi

docker run -ti --rm --net=host --env="DISPLAY" \\
    -v \$HOME/.Xauthority:\$C_HOME/.Xauthority \\
    -v \$ECLIPSE_SETTINGS_DIR:\$C_HOME/.eclipse \\
    -v \$HOST_WORKSPACE_DIR:\$C_HOME/eclipse-workspace \\
    -v \$HOME/.ssh:\$C_HOME/.ssh \\
    \$MOUNT_PARAMS \\
    \$IMAGE_NAME \\
    bash
EOF

