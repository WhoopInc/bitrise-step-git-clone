# bitrise-step-git-clone

Bitrise step to checkout code. This step checks out branches/tags for builds and optionally merges with the main branch
in the case of PR builds.

## Example usage  
  
Using defaults
- Merges PRs with main branch
- Uses Bitrise env vars to specify repo url, clone dir, commit id, etc
```yaml
- git::https://github.com/WhoopInc/bitrise-step-git-clone.git@add-git-clone-step: {}
```

Overriding defaults
```yaml
- git::https://github.com/WhoopInc/bitrise-step-git-clone.git@add-git-clone-step:
    inputs:
      - merge: "no"
      - branch: "master"
```

See [`step.yml`](step.yml)