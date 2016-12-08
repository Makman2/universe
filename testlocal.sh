set -e

cp ../dcos-flink-service/service/marathon.json.mustache repo/packages/F/flink/0/
cp ../dcos-flink-service/service/package.json repo/packages/F/flink/0/
cp ../dcos-flink-service/service/resource.json repo/packages/F/flink/0/
cp ../dcos-flink-service/service/config.json repo/packages/F/flink/0/
scripts/build.sh
DOCKER_TAG=flink docker/server/build.bash
docker tag mesosphere/universe-server:flink makman2/universe-server:flink-dev
docker push makman2/universe-server:flink-dev

set +e
dcos marathon app remove universe
dcos package repo add --index=0 dev-universe http://universe.marathon.mesos:8085/repo
set -e

dcos marathon app add docker/server/marathon.json

