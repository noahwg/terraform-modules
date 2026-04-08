#!/usr/bin/env bash

set -euo pipefail

usage() {
  echo "Usage: ./tag-module.sh <module-name> [--patch|--minor|--major]"
  echo "Bumps the version for a specific module and pushes a tag."
  echo ""
  echo "Tag format: <module-name>/v<major>.<minor>.<patch>"
  echo ""
  echo "The module name is the directory name (e.g. 'dynamo-db')."
  echo "The script searches modules/ to verify it exists."
  echo ""
  echo "Bump type:"
  echo "  (default)  patch: v1.2.3 -> v1.2.4"
  echo "  --minor    minor: v1.2.3 -> v1.3.0"
  echo "  --major    major: v1.2.3 -> v2.0.0"
  echo ""
  echo "Examples:"
  echo "  ./tag-module.sh dynamo-db           # patch bump"
  echo "  ./tag-module.sh dynamo-db --minor"
  echo "  ./tag-module.sh dynamo-db --major"
}

if [[ $# -lt 1 ]]; then
  usage
  exit 1
fi

module_name="$1"
shift

# Search for module in modules/ directory
matches=()
while IFS= read -r -d '' dir; do
  if [[ "$(basename "$dir")" == "$module_name" ]]; then
    matches+=("$dir")
  fi
done < <(find modules -type d -print0)

if [[ ${#matches[@]} -eq 0 ]]; then
  echo "Error: no module named '${module_name}' found under modules/" >&2
  exit 1
fi

if [[ ${#matches[@]} -gt 1 ]]; then
  echo "Error: multiple modules named '${module_name}' found:" >&2
  for m in "${matches[@]}"; do
    echo "  ${m}" >&2
  done
  echo "Use a more specific path to disambiguate." >&2
  exit 1
fi

echo "Found module: ${matches[0]}"

bump_mode="patch"

while [[ $# -gt 0 ]]; do
  case "$1" in
    --patch)
      bump_mode="patch"
      shift
      ;;
    --minor)
      bump_mode="minor"
      shift
      ;;
    --major)
      bump_mode="major"
      shift
      ;;
    -h|--help)
      usage
      exit 0
      ;;
    -*)
      echo "Unknown flag: $1" >&2
      usage
      exit 1
      ;;
    *)
      echo "Unexpected argument: $1" >&2
      usage
      exit 1
      ;;
  esac
done

git fetch --tags --quiet || true

tag_prefix="${module_name}/v"

latest_major=0
latest_minor=0
latest_patch=0
latest_tag=""
found=0

while IFS= read -r tag; do
  version="${tag#"${tag_prefix}"}"
  if [[ "$version" =~ ^([0-9]+)\.([0-9]+)\.([0-9]+)$ ]]; then
    major="${BASH_REMATCH[1]}"
    minor="${BASH_REMATCH[2]}"
    patch="${BASH_REMATCH[3]}"
    if (( found == 0 )) || (( major > latest_major )) || \
      (( major == latest_major && minor > latest_minor )) || \
      (( major == latest_major && minor == latest_minor && patch > latest_patch )); then
      latest_major="$major"
      latest_minor="$minor"
      latest_patch="$patch"
      latest_tag="$tag"
      found=1
    fi
  fi
done < <(git tag -l "${tag_prefix}*" || true)

if (( found == 0 )); then
  case "$bump_mode" in
    patch) new_major=0; new_minor=0; new_patch=1 ;;
    minor) new_major=0; new_minor=1; new_patch=0 ;;
    major) new_major=1; new_minor=0; new_patch=0 ;;
  esac
  echo "No existing tags for ${module_name}; starting at v${new_major}.${new_minor}.${new_patch} (${bump_mode} bump)"
else
  case "$bump_mode" in
    patch)
      new_major="$latest_major"
      new_minor="$latest_minor"
      new_patch=$((latest_patch + 1))
      ;;
    minor)
      new_major="$latest_major"
      new_minor=$((latest_minor + 1))
      new_patch=0
      ;;
    major)
      new_major=$((latest_major + 1))
      new_minor=0
      new_patch=0
      ;;
  esac
  echo "Latest tag: ${latest_tag}"
fi

new_tag="${tag_prefix}${new_major}.${new_minor}.${new_patch}"

if git rev-parse -q --verify "refs/tags/${new_tag}" >/dev/null; then
  echo "Tag already exists: ${new_tag}" >&2
  exit 1
fi

git tag "${new_tag}"
git push origin "${new_tag}"

echo "Created and pushed tag: ${new_tag}"
