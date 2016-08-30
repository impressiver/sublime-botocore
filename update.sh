#!/usr/bin/env bash
set -e    # Exit on first failure

################################################################################
#       Update dependency package from a Github project release tarball        #
# ---------------------------------------------------------------------------- #

# DEPENDENCY CONFIGURATION
# ------------------------
PKG_NAME='sublime-botocore'

DEP_REPO='boto/botocore'
DEP_RELEASE='1.4.49'
# ----- #

tarfile="${PKG_NAME}-${DEP_RELEASE}.tar.gz"

# Download release tarball
curl -v --output "/tmp/${tarfile}" --location -- "https://github.com/${DEP_REPO}/archive/${DEP_RELEASE}.tar.gz"

## ALT: Clone detached head from a Github tagged release
#git clone --branch="$DEP_RELEASE" --single-branch --depth 1 "${DEP_REPO_URL}" all
#rm -rf 'all/.git'

# Delete existing dependency files
[ -d 'all' ] && rm -r 'all/'

# Create destination dir and extract the contents of the archive
mkdir 'all'
tar -zxvf "/tmp/${tarfile}" -C 'all' --strip-components 1

# Cleanup
rm "/tmp/${tarfile}"
