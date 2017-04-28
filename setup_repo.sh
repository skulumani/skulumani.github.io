#!/bin/bash

# add the correct remote repositories
git_repo="git@github.com:skulumani/system_setup.git"
gitlab_repo="git@gitlab.com:skulumani/skulumani.gitlab.io.git"

printf "Setting the origin remote to point to Github and Bitbucket:\n\n"
printf "Github: $git_repo\n"
printf "Gitlab: $gitlab_repo\n\n"

git remote set-url origin --push --add $gitlab_repo
git remote set-url origin --push --add $git_repo

printf "Finished! The new remotes are listed.\n"
printf "\n"

git remote -v
