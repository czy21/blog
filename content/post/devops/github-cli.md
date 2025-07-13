---
title: "Github CLI"
description: "github cli"
keywords: "devops,github"

date: 2024-09-23T15:59:44+08:00
lastmod: 2024-09-23T15:59:44+08:00

categories:
  - devops
tags:
  - github
---

##
  * https://cli.github.com/

## Workflow
```shell
# 删除已完成的actions/runs
export GH_TOKEN=
github_user=
github_repo=
ids=$(gh api -X GET -F per_page=100 /repos/${github_user}/${github_repo}/actions/runs --jq '.workflow_runs[] | select(.status=="completed") | .id' | xargs)
for t in $ids;do
  echo "Delete: $t"
  gh api -X DELETE /repos/${github_user}/${github_repo}/actions/runs/$t --silent
done
```