set -e

#===============================
# This scripts is use to get the python tag.
#

if [[ -z "${PYTHON_DOCKER_TAG}" ]]; then
  exit 1
else
  echo "$PYTHON_DOCKER_TAG"
fi
