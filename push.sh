#!/bin/bash
# Скрипт для пуша, выполняющий "обезьянью" работу
# Использование:
# 1) ./push.sh - запушит текущий бранч в origin
# 2) -d - сделает патч и запушит текущий бранч вместе с тегами в origin + задеплоит статику
# 3) -t - сделает патч и запушить вместе с тегами
# 4) -v [version] - установит кастомную версию

while getopts dtv: flag
do
    case "${flag}" in
        d) deploy=true;;
        t) tags=true;;
        v) version=${OPTARG};;
        ?)
          echo "script usage: push.sh [-d] [-t] [-v version]"
          exit 1
          ;;
    esac
done

current_version=$(npm pkg get version)
echo "current version: ${current_version}"
branch_name=$(git symbolic-ref --short HEAD)
echo "branch name: ${branch_name}"

if [[ $deploy ]]
then
  echo "removing node_modules..."
  rm -rf ./node_modules
  echo "successfully removed node_modules"
fi

if [[ $deploy ]] || [[ $tags ]]
then
  if [[ $version ]]
  then
    npm version prerelease --preid=${version}
  else
    npm version patch
  fi

  echo "push tags..."
  git push origin ${branch_name} --tags
fi

echo "push changes..."
git push origin ${branch_name}

if [[ $deploy ]]
then
  npm install
  git branch --set-upstream-to=origin/${branch_name} ${branch_name}
  echo "deploy..."
  ./deploy.sh
fi

if [[ $deploy ]] || [[ $tags ]] || [[ $version ]]
then
  echo "revert version..."
  npm version ${current_version} --no-git-tag-version
  git push origin ${branch_name}
fi
