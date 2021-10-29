set -e

#===============================
# This scripts assert that the correct python version is used in
# the docker image passed as first argument.
#

IMAGE_NAME=$1

if [[ -z "${PYTHON_DOCKER_TAG}" ]]; then
  exit 1
else
  python_version=$(docker run --rm "$IMAGE_NAME" python --version)
  truncated_python_version=$(echo "$python_version" | cut -d. -f 1-2)

  if [[ "$truncated_python_version" == "Python ${PYTHON_DOCKER_TAG}" ]]
  then
    echo "python version is correct"
    echo "expected $PYTHON_DOCKER_TAG, got $truncated_python_version"
  else
    >&2 echo "python version is NOT correct"
    >&2 echo "expected $PYTHON_DOCKER_TAG, got $truncated_python_version"
    exit 2
  fi
fi
