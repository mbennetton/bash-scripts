#!/bin/bash
# Shell script to merge in the specific branch for the git flow task type you are working on

function getBranch {
    git branch | grep '*' | sed 's/* //'
}

# Get the current branch
BRANCH=$(getBranch)

# Remove all the text from the branch after the slash
TASK=${BRANCH%/*}
echo 'The task type is: ' $TASK

# Check type of task
case $TASK in
    'feature')
        BRANCH2MERGE='develop'
        ;;
    'hotfix')
        BRANCH2MERGE='master'
        ;;
    *)
        echo 'Not a specified branch type'
        exit 1
esac

# Go to specific branch
git checkout $BRANCH2MERGE

# Pull current branch
if ! git pull 
then
    echo 'Git pull failed'
    git checkout $BRANCH
    exit 1
fi

# Go back to task branch
git checkout $BRANCH

# Merge develop/Master
git merge $BRANCH2MERGE