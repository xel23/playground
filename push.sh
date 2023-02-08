#!/bin/bash
# Скрипт для пуша, выполняющий "обезьянью" работу
# Использование:
# 1) ./push.sh - запушит текущий бранч в origin
# 2) -d - сделает патч и запушит текущий бранч вместе с тегами в origin + задеплоит статику
# 3) -t - сделает патч и запушить вместе с тегами
# 4) -v [version] - установит кастомную версию

while getopts d:t:v: flag
do
    case "${flag}" in
        d) deploy=true;;
        t) tags=true;;
        v) version=${OPTARG};;
    esac
done

current_version=$(npm pkg get version)
branch_name=$(git symbolic-ref --short HEAD)

if [[ $deploy ]]
then
  rm -rf ./node_modules
fi

if [[ $deploy ]] || [[ $tags ]]
then
  if [[ $version ]]
  then
    npm version prerelease --preid=${version}
  else
    npm version patch
  fi

  git push origin ${branch_name} --tags
fi

git push origin ${branch_name}

if [[ $deploy ]] || [[ $tags ]]
then
  git push origin ${branch_name} --tags
fi

if [[ $deploy ]]
then
  npm install
  git branch --set-upstream-to=origin/${branch_name} ${branch_name}
  ./deploy.sh
fi

if [[ $deploy ]] || [[ $tags ]] || [[ $version ]]
then
  npm version ${current_version}
  git push origin ${branch_name}
fi
