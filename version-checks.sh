#!/usr/bin/env bash

printf "********************** Version checks **********************\n"

# the below list is case sensitive!
packages=(python perl ruby php bash git java VBoxManage vagrant packer node npm)

for package in ${packages[@]}; do
  if command -v $package >/dev/null 2>&1; then # one way of checking if package is installed or not
    path="$(echo `which $package`)"
    # I wish the below wasn't necessary...
    case $package in
      "python")     version="$(echo `$package -c 'import sys; print(sys.version[:5])'`)";;
      "perl")       version="$($package -v | awk 'NR==2 {print $9}' | cut -c3-8)";;
      "ruby")       version="$($package -v | awk '{print $2}' | cut -c1-5)";;
      "php")        version="$(echo `$package -v` | awk '{print $2}' | cut -c1-6)";;
      "bash")       version="$($package --version | awk 'NR==1 {print $4}' | cut -c1-6)";;
      "git")        version="$($package --version | awk '{print $3}')";;
      "java")       version="$($package -version 2>&1 |awk 'NR==1{ gsub(/"/,""); print $3 }')";;
      "VBoxManage") version="$($package -v | cut -c1-6)";;
      "vagrant")    version="$(echo `$package version` | awk '{print $3}')";;
      "packer")     version="$(echo `$package version` | awk '{print $2}' | cut -c2-)";;
      *)            version="$(echo `$package -v`)";;
    esac
    if [[ "$version" =~ "v" ]]; then # remove the initial 'v' where necessary
      version="$(echo $version | cut -c2-)"
    fi
    printf "%-15s %-15s %-20s\n" $package $version $path
  else
    printf "%-15s %-15s %-20s\n" $package "------" "not installed"
  fi
done

# TODO: extend it to check the latest stable version of each package
# Is there such a service out there?
