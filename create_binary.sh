#!/bin/bash

IMAGE_PREFIX=$1
DOCKERFILE_DIR=$2
IMAGE_UPPER_LAYER=$(echo "${DOCKERFILE_DIR#*/}")
BIN_DIR="bin"
RUN_SCRIPT="eclipse-${IMAGE_UPPER_LAYER}-${IMAGE_PREFIX}.sh"

cd ~
if ! [ -d $BIN_DIR ]; then
    mkdir -p $BIN_DIR
fi

cd $BIN_DIR

if ! [ -f $RUN_SCRIPT ]; then
    touch $RUN_SCRIPT
    chmod 775 $RUN_SCRIPT
fi

echo "#!/bin/bash" > $RUN_SCRIPT
echo "" >> $RUN_SCRIPT
echo "C_HOME=/home/developer" >> $RUN_SCRIPT
echo "HOST_WORKSPACE_DIR=\${HOME}/eclipse/workspace" >> $RUN_SCRIPT
echo "ECLIPSE_SETTINGS_DIR=\${HOME}/eclipse/settings" >> $RUN_SCRIPT
echo "IPI_DIR=\${HOME}/src" >> $RUN_SCRIPT
echo "IMAGE_NAME="${IMAGE_PREFIX}"/"${DOCKERFILE_DIR} >> $RUN_SCRIPT
echo "" >> $RUN_SCRIPT
echo "if ! [ -d \$IPI_DIR ]; then" >> $RUN_SCRIPT
echo "   mkdir -p \$IPI_DIR" >> $RUN_SCRIPT
echo "fi" >> $RUN_SCRIPT
echo "" >> $RUN_SCRIPT
echo "MOUNT_PARAMS=\"\\" >> $RUN_SCRIPT
echo "    --privileged \\" >> $RUN_SCRIPT
echo "    -v \${IPI_DIR}:\${C_HOME}/src \\" >> $RUN_SCRIPT
echo "    -v /var/run/docker.sock:/var/run/docker.sock \\" >> $RUN_SCRIPT
echo "    --name eclipse-${IMAGE_UPPER_LAYER}-${IMAGE_PREFIX}\"" >> $RUN_SCRIPT
echo "" >> $RUN_SCRIPT
echo "if ! [ -d \$HOST_WORKSPACE_DIR ]; then" >> $RUN_SCRIPT
echo "    mkdir -p \$HOST_WORKSPACE_DIR" >> $RUN_SCRIPT
echo "fi" >> $RUN_SCRIPT
echo "" >> $RUN_SCRIPT
echo "if ! [ -d \$ECLIPSE_SETTINGS_DIR ]; then" >> $RUN_SCRIPT
echo "    mkdir -p \$ECLIPSE_SETTINGS_DIR" >> $RUN_SCRIPT
echo "fi" >> $RUN_SCRIPT
echo "" >> $RUN_SCRIPT
echo "docker run -ti --rm --net=host --env=\"DISPLAY\" \\" >> $RUN_SCRIPT
echo "    -v \$HOME/.Xauthority:\$C_HOME/.Xauthority \\" >> $RUN_SCRIPT
echo "    -v \$ECLIPSE_SETTINGS_DIR:\$C_HOME/.eclipse \\" >> $RUN_SCRIPT
echo "    -v \$HOST_WORKSPACE_DIR:\$C_HOME/eclipse-workspace \\" >> $RUN_SCRIPT
echo "    -v \$HOME/.ssh:\$C_HOME/.ssh \\" >> $RUN_SCRIPT
echo "    \$MOUNT_PARAMS \\" >> $RUN_SCRIPT
echo "    \$IMAGE_NAME \\" >> $RUN_SCRIPT
echo "    bash" >> $RUN_SCRIPT
