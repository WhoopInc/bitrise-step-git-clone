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

echo "git fetch --no-tags origin $branch"
git fetch --depth=1 --no-tags origin $branch

echo "git checkout $branch"
git checkout $branch

echo "git fetch --no-tags origin main"
git fetch --no-tags origin main

echo "git log -n 1 main"
git log -n 1 main

echo "git merge $(git log -n 1 main) --allow-unrelated-histories"
git merge $(git log -n 1 main) --allow-unrelated-histories

envman add --key "GIT_CLONE_COMMIT_AUTHOR_NAME" --value "$(git "log" "-1" "--format=%an" $commit)"
echo "GIT_CLONE_COMMIT_AUTHOR_NAME: ${GIT_CLONE_COMMIT_AUTHOR_NAME}"

envman add --key "GIT_CLONE_COMMIT_AUTHOR_EMAIL" --value "$(git "log" "-1" "--format=%ae" $commit)"
echo "GIT_CLONE_COMMIT_AUTHOR_EMAIL: ${GIT_CLONE_COMMIT_AUTHOR_EMAIL}"

envman add --key "GIT_CLONE_COMMIT_HASH" --value "$(git "log" "-1" "--format=%H" $commit)"
echo "GIT_CLONE_COMMIT_HASH: ${GIT_CLONE_COMMIT_HASH}"

envman add --key "GIT_CLONE_COMMIT_MESSAGE_SUBJECT" --value "$(git "log" "-1" "--format=%s" $commit)"
echo "GIT_CLONE_COMMIT_MESSAGE_SUBJECT: ${GIT_CLONE_COMMIT_MESSAGE_SUBJECT}"

envman add --key "GIT_CLONE_COMMIT_MESSAGE_BODY" --value "$(git "log" "-1" "--format=%b" $commit)"
echo "GIT_CLONE_COMMIT_MESSAGE_BODY: ${GIT_CLONE_COMMIT_MESSAGE_BODY}"