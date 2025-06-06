#!/bin/bash

script_dir="$(dirname "$(readlink -f "${BASH_SOURCE[0]}")")"
shared_dir="${script_dir}/_shared"

# CLI FLAGS
create_tarball=false
while [[ $# -gt 0 ]]; do
  case "$1" in
    --create-tarball)
      create_tarball=true
      shift
      ;;
    *)
      echo "Unknown option: $1"
      exit 1
      ;;
  esac
done

cd "${script_dir}" || exit 1

function removeAllGitIgnoredFilesInDir() {
  local dir="$1"
  git -C "${dir}" clean -fdX
}

function makeLoginTheme() {
  local theme="$1"
  local theme_dir="$2"

  # Copy files
  cp -r "${shared_dir}/login/." "${theme_dir}/login"

  # Copy component library
  local component_src_dir="${shared_dir}/node_modules/@hawk-hhg/svelte-components/dist"
  local component_dest_dir="${theme_dir}/login/resources/components"
  local component_js_dir="${component_dest_dir}/js"
  local component_css_dir="${component_dest_dir}/css"
  mkdir -p "${component_dest_dir}"
  mkdir -p "${component_js_dir}"
  mkdir -p "${component_css_dir}"
  cp -r "${component_src_dir}/_custom-elements/." "${component_js_dir}"
  cp "${component_src_dir}/_themes/theme-${theme}-reset.css" "${component_css_dir}/theme.css"
}

function npmInstall() {
  local dir="$1"
  npm --prefix "${dir}" ci
}

function createTarball() {
  local theme="$1"
  local theme_dir="./${theme}"
  local tarball_name="${theme}-theme.tar.gz"

  # Create tarball
  tar -czf "${tarball_name}" -C "$(dirname "${theme_dir}")" "$(basename "${theme_dir}")"

  echo "Created tarball: ${tarball_name}"
}

function makeTheme() {
  local theme="$1"
  local theme_dir="./${theme}"

  removeAllGitIgnoredFilesInDir "${theme_dir}"
  makeLoginTheme "${theme}" "${theme_dir}"

  if [[ "${create_tarball}" == true ]]; then
    createTarball "${theme}"
  fi
}

npmInstall "${shared_dir}"
makeTheme handson
makeTheme hawk