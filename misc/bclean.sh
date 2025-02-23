#!/bin/bash

# small script to clean up branches once PR's are done

BRANCH=$(git branch | grep "*" | cut -d' ' -f2)


if [ "$BRANCH" != "master" ]; then
  echo "---------------------"
  echo "| Cleaning $BRANCH. |"
  echo "---------------------"
  git checkout master
  git pull --rebase upstream master
  git branch -D $BRANCH
  git push -d origin $BRANCH
  git push
  echo "-------------------"
  echo "| Branch cleaned. |"
  echo "-------------------"
else
  echo "--------------------"
  echo "| Updating master! |"
  echo "--------------------"
  git pull upstream master
  git push -u origin master
  echo "-------------------"
  echo "| Master updated. |"
  echo "-------------------"
fi
