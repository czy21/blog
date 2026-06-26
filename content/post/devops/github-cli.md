---
title: "Github CLI"
description: "github cli"
keywords: "devops,github"

date: 2024-09-23T15:59:44+08:00
lastmod: 2026-06-26T11:32:15+08:00

categories:
  - devops
tags:
  - github
---

##
  * https://cli.github.com/

## Workflow
- 删除已完成的actions/runs
  ```shell
  export GH_TOKEN=

  github_user=
  github_repo=

  count=1

  while true; do
    echo "=== Batch $count: Fetching runs... ==="
    
    ids=$(gh api -X GET -F per_page=100 /repos/${github_user}/${github_repo}/actions/runs --jq '.workflow_runs[] | select(.status=="completed") | .id')
    
    if [ -z "$ids" ]; then
      echo "No more completed runs found. Finished!"
      break
    fi

    for t in $ids; do
      echo "Delete: $t"
      gh api -X DELETE /repos/${github_user}/${github_repo}/actions/runs/$t --silent
    done

    echo "=== Batch $count completed. ==="
    count=$((count + 1))
  done
  ```