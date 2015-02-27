#!/usr/bin/env bash

printf "********************** Version checks **********************\n"

packages=(python perl ruby php bash git java VBoxManage vagrant packer node npm)

for package in ${packages[@]}; do
  if command -v $package >/dev/null 2>&1; then
    path="$(echo `which $package`)"
    case $package in
      "python")     version="$(echo `python -c 'import sys; print(sys.version[:5])'`)";;
      "perl")       version="$(perl -v | awk 'NR==2 {print $9}' | cut -c3-8)";;
      "ruby")       version="$(ruby -v | awk '{print $2}' | cut -c1-5)";;
      "php")        version="$(echo `php -v` | awk '{print $2}' | cut -c1-6)";;
      "bash")       version="$(bash --version | awk 'NR==1 {print $4}' | cut -c1-6)";;
      "git")        version="$(git --version | awk '{print $3}')";;
      "java")       version="$($package -version 2>&1 |awk 'NR==1{ gsub(/"/,""); print $3 }')";;
      "VBoxManage") version="$(VBoxManage -v | cut -c1-6)";;
      "vagrant")    version="$(echo `vagrant version` | awk '{print $3}')";;
      "packer")     version="$(echo `packer version` | awk '{print $2}' | cut -c2-)";;
      *)            version="$(echo `$package -v`)";;
    esac
    if [[ "$version" =~ "v" ]]; then
      version="$(echo $version | cut -c2-)"
    fi
    printf "%-15s %-15s %-20s\n" $package $version $path
  else
    printf "%-15s %-15s %-20s\n" $package "------" "not installed"
  fi
done
