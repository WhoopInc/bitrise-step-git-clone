#!/bin/sh
echo "START - $(date +"%H:%M:%S")"

set -e

cd $BITRISE_SOURCE_DIR

echo "$(date +"%H:%M:%S") - git init"
git init

echo "$(date +"%H:%M:%S") - git config --global url.'ssh://git@github.com'.insteadOf 'https://github.com' || true"
git config --global url."ssh://git@github.com".insteadOf "https://github.com" || true

echo "$(date +"%H:%M:%S") - git config --global gc.auto 0 || true"
git config --global gc.auto 0 || true

echo "$(date +"%H:%M:%S") - git remote add origin $repository_url"
git remote add origin $repository_url

echo "$(date +"%H:%M:%S") - git clone --verbose --progress --no-tags --single-branch --depth=1 --branch=$branch_dest $repository_url"
git clone --verbose --progress --no-tags --single-branch --depth=1 --branch=$branch_dest $repository_url

echo "$(date +"%H:%M:%S") - git fetch --jobs=10 --no-tags origin $branch"
git fetch --jobs=10 --no-tags origin $branch

echo "$(date +"%H:%M:%S") - git merge origin/$branch"
git merge origin/$branch

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

echo "END - $(date +"%H:%M:%S")"