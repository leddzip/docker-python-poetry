set -e


#===============================
# This scripts is use to get the poetry version.
#

if [[ -z "${POETRY_VERSION}" ]]; then
  exit 1
else
  echo "$POETRY_VERSION"
fi
