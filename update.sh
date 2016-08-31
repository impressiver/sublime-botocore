#!/usr/bin/env bash
set -e    # Exit on first failure

################################################################################
#       Update dependency package from a Github project release tarball        #
# ---------------------------------------------------------------------------- #

# DEPENDENCY CONFIGURATION
# ------------------------
PKG_NAME='sublime-botocore'

DEP_REPO='boto/botocore'
DEP_RELEASE="${1:-1.4.50}"
# ----- #

echo "${PURPLE}Update ${DEP_REPO} to ${DEP_RELEASE}${RESET}"

# Confirmation
echo ''
echo 'Continuing will download a new release and replace the entire "all" directory.'

read -p "${RED}Are you sure? [y/N]:${RESET} " confirm
[[ ! "$confirm" =~ ^[Yy]$ ]] && exit 1

tarfile="${PKG_NAME}-${DEP_RELEASE}.tar.gz"

# Download a release tarball
curl -v --output "/tmp/${tarfile}" --location -- "https://github.com/${DEP_REPO}/archive/${DEP_RELEASE}.tar.gz"

## ALT: Clone a detached head from a Github tagged release
#git clone --branch="$DEP_RELEASE" --single-branch --depth 1 "${DEP_REPO_URL}" all
#rm -rf 'all/.git'

# Delete existing files
[ -d 'all' ] && rm -r 'all/'

# Create "all" dir and extract tarball contents
mkdir 'all'
tar -zxvf "/tmp/${tarfile}" -C 'all' --strip-components 1

# Cleanup
rm "/tmp/${tarfile}"
