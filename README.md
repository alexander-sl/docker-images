# xenial-jdk

Build precedure for xenial-eclipse-nc image:

cd docker-images/xenial
docker build --tag=alexsl/xenial-base base
docker build --tag=alexsl/xenial-jdk jdk
docker build --tag=alexsl/xenial-gtk gtk
docker build --tag=alexsl/xenial-eclipse-cdt eclipse-cdt
docker build --tag=alexsl/xenial-eclipse-nc nc

