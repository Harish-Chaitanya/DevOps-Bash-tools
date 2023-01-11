#!/usr/bin/env bash
#  vim:ts=4:sts=4:sw=4:et
#
#  Author: Hari Sekhon
#  Date: 2022-01-11 10:07:36 +0000 (Tue, 11 Jan 2022)
#
#  https://github.com/HariSekhon/DevOps-Bash-tools
#
#  License: see accompanying Hari Sekhon LICENSE file
#
#  If you're using my code you're welcome to connect with me on LinkedIn and optionally send me feedback to help steer this or other code I publish
#
#  https://www.linkedin.com/in/HariSekhon
#

set -euo pipefail
[ -n "${DEBUG:-}" ] && set -x
srcdir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# shellcheck disable=SC1090
. "$srcdir/../lib/utils.sh"

# shellcheck disable=SC2034,SC2154
usage_description="
Installs GitHub CLI

Once installed, configure authentication by creating a Personal Access Token (PAT) here:

    https://github.com/settings/tokens

and then exporting that as an environment variable - either GH_TOKEN or GITHUB_TOKEN (the former has higher precedence so is recommended):

    export GH_TOKEN=...
"

# used by usage() in lib/utils.sh
# shellcheck disable=SC2034
usage_args="[<version>]"

export PATH="$PATH:$HOME/bin"

help_usage "$@"

#version="${1:-2.4.0}"
version="${1:-latest}"

os="$(get_os)"
if [ "$os" = darwin ]; then
    os=macOS
    if [ "$(arch)" = arm64 ]; then
        echo "GitHub CLI doesn't support ARM architecture yet, skipping..."
        exit 0
    fi
fi

export RUN_VERSION_ARG=1

"$srcdir/../github_install_binary.sh" cli/cli "gh_{version}_${os}_{arch}.tar.gz" "$version" "gh_{version}_${os}_{arch}/bin/gh"
