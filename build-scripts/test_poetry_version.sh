set -e

#===============================
# This scripts assert that the correct poetry version is used in
# the docker image passed as first argument.
#

IMAGE_NAME=$1

if [[ -z "${POETRY_VERSION}" ]]; then
  exit 1
else
  poetry_version=$(docker run --rm "$IMAGE_NAME" poetry --version)

  if [[ "$poetry_version" == "Poetry version ${POETRY_VERSION}" ]]
  then
    echo "poetry version is correct"
    echo "expected $POETRY_VERSION, got $poetry_version"
  else
    >&2 echo "poetry version is NOT correct"
    >&2 echo "expected $POETRY_VERSION, got $poetry_version"
    exit 2
  fi
fi