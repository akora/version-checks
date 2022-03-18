#!/usr/bin/env bash

three_columns="%-14s %-32s %-28s\n"
four_columns="%-14s %-15s %-16s %-28s\n"

printf "****************************** What's installed? ******************************\n"

# the below list is case sensitive!
packages=(ansible bash brew composer docker docker-compose exiftool fswatch g++ gcc git go java kotlin node npm packer perl php python python3 ruby terraform unison vagrant VBoxManage zsh)

if [[ $(java -version 2>&1) != *"OpenJDK"* ]]; then
  java_origin="Oracle"
else
  java_origin="OpenJDK"
fi

for package in ${packages[@]}; do
  if command -v $package >/dev/null 2>&1; then # one way of checking if package is installed or not
    path="$(echo `which $package`)"
    note=""
    # I wish the below wasn't necessary...
    case $package in
      "ansible")        version="$(echo `ansible --version` | awk '{print $3}' | cut -c1-6)";;
      "bash")           version="$($package --version | awk 'NR==1 {print $4}' | cut -c1-6)";;
      "brew")           version="$($package --version | awk 'NR==1 {print $2}' | cut -c1-6)";;
      "composer")       version="$($package -V | awk '{print $3}')";;
      "docker-compose") version="$($package --version | awk '{print $4}')";;
      "docker")         version="$($package -v | awk '{print $3}' | cut -c1-7)";;
      "exiftool")       version="$($package -ver | awk '{print $1}' | cut -c1-5)";;
      "fswatch")        version="$($package --version | awk 'NR==1 {print $2}' | cut -c1-5)";;
      "g++")            version="$($package -dumpversion)";;
      "gcc")            version="$($package -dumpversion)";;
      "git")            version="$($package --version | awk '{print $3}')";;
      "go")             version="$($package version | awk '{print $3}' | cut -c3-8)";;
      "java")           version="$($package -version 2>&1 | awk -F '"' '/version/ {print $2}')" note="($java_origin)";;
      "kotlin")         version="$($package -version | awk '{print $3}' | cut -c1-6)";;
      "packer")         version="$(echo `packer version` | awk '{print $2}' | cut -c2-)";;
      "perl")           version="$($package -v | awk 'NR==2 {print $9}' | cut -c3-8)";;
      "php")            version="$(echo `$package -v` | awk 'NR < 2' | awk '{print $25}' | cut -c1-6)";;
      "python")         version="$(echo `$package -c 'import sys; print(sys.version[:6])'`)";;
      "python3")        version="$(echo `$package -c 'import sys; print(sys.version[:6])'`)";;
      "ruby")           version="$($package -v | awk '{print $2}' | cut -c1-5)";;
      "terraform")      version="$($package -version | awk 'NR < 2' | awk '{print $2}' | cut -c1-6)";;
      "unison")         version="$($package -version | awk '{print $3}' | cut -c1-6)";;
      "vagrant")        version="$(echo `vagrant version` | awk '{print $3}')";;
      "VBoxManage")     version="$(VBoxManage -v | cut -c1-5)";;
      "zsh")            version="$(zsh --version | awk '{print $2}')";;
      *)                version="$(echo `$package -v`)";;
    esac
    if [[ "$version" =~ "v" ]]; then # remove the initial 'v' where necessary
      version="$(echo $version | cut -c2-)"
    fi
    if [[ -z "$note" ]]; then # arrange into 3 columns only if there is no note
      printf "$three_columns" $package $version $path
    else
      printf "$four_columns" $package $version $note $path
    fi
  else
    printf "$three_columns" $package "-----" "not installed"
  fi
done

printf "\n****************************** Brew leaves ************************************\n"
brew leaves

printf "\n****************************** Pip3 list **************************************\n"
pip3 list

# TODO: extend it to check the latest stable version of each package
# Is there such a service out there?
