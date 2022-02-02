#!/bin/sh
set -e

cd /Users/vagrant/git

echo "git init"
git init

echo "git config --global url.'ssh://git@github.com'.insteadOf 'https://github.com' || true"
git config --global url."ssh://git@github.com".insteadOf "https://github.com" || true

echo "git config --global gc.auto 0 || true"
git config --global gc.auto 0 || true

echo "git remote add origin $repository_url"
git remote add origin $repository_url

echo "git clone --no-tags --single-branch --branch=$branch_dest $repository_url"
git clone --no-tags --single-branch --branch=$branch_dest $repository_url

echo "git fetch origin $branch"
git fetch origin $branch

echo "git checkout origin/$branch"
git checkout origin/$branch

echo "git fetch origin $branch_dest"
git fetch origin $branch_dest

echo "git merge origin/$branch_dest"
git merge origin/$branch_dest

GIT_CLONE_COMMIT_AUTHOR_NAME=$(git "log" "-1" "--format=%an" $commit)
envman add --key "GIT_CLONE_COMMIT_AUTHOR_NAME" --value "$GIT_CLONE_COMMIT_AUTHOR_NAME"
echo "GIT_CLONE_COMMIT_AUTHOR_NAME: ${GIT_CLONE_COMMIT_AUTHOR_NAME}"

GIT_CLONE_COMMIT_AUTHOR_EMAIL=$(git "log" "-1" "--format=%ae" $commit)
envman add --key "GIT_CLONE_COMMIT_AUTHOR_EMAIL" --value "$GIT_CLONE_COMMIT_AUTHOR_EMAIL"
echo "GIT_CLONE_COMMIT_AUTHOR_EMAIL: ${GIT_CLONE_COMMIT_AUTHOR_EMAIL}"

GIT_CLONE_COMMIT_HASH=$(git "log" "-1" "--format=%H" $commit)
envman add --key "GIT_CLONE_COMMIT_HASH" --value "$GIT_CLONE_COMMIT_HASH"
echo "GIT_CLONE_COMMIT_HASH: ${GIT_CLONE_COMMIT_HASH}"

GIT_CLONE_COMMIT_MESSAGE_SUBJECT=$(git "log" "-1" "--format=%s" $commit)
envman add --key "GIT_CLONE_COMMIT_MESSAGE_SUBJECT" --value "$GIT_CLONE_COMMIT_MESSAGE_SUBJECT"
echo "GIT_CLONE_COMMIT_MESSAGE_SUBJECT: ${GIT_CLONE_COMMIT_MESSAGE_SUBJECT}"

GIT_CLONE_COMMIT_MESSAGE_BODY=$(git "log" "-1" "--format=%b" $commit)
envman add --key "GIT_CLONE_COMMIT_MESSAGE_BODY" --value "$GIT_CLONE_COMMIT_MESSAGE_BODY"
echo "GIT_CLONE_COMMIT_MESSAGE_BODY: ${GIT_CLONE_COMMIT_MESSAGE_BODY}"