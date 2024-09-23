---
title: "Github Actions Self-Hosted Runners 自托管运行程序"
description: "github-actions"
keywords: "devops,github,actions"

date: 2023-09-02T10:47:11+08:00
lastmod: 2023-09-02T10:47:11+08:00

categories:
  - devops
tags:
  - github
  - github-actions
  - ci/cd
---

## 设置仓库
![](runners-add.png)
## Settings -> Actions -> Runners -> New self-hosted runner
  * Runner image: Linux
  * Architecture: x64
## Register Runner
```
./config.sh --name <name> --url <repo_url> --token <token>
## 后台运行并输出日志到run.log
./run.sh > run.log 2>&1 &
```
![](runners-config.png)
## 测试Github workflow
  * 创建.github/workflows/ci.yaml
  * 注: runs-on: self-hosted
```yaml
name: ci on self-hosted runners

on:
  workflow_dispatch:

defaults:
  run:
    shell: bash

jobs:
  build:
    runs-on: self-hosted
    steps:
      - name: hello world
        run: echo "hello"
```