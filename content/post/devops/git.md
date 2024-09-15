---
title: "Git 命令大全"
description: command
keywords: "git"

date: 2024-09-15T18:29:50+08:00
lastmod: 2024-09-15T18:29:50+08:00

categories:
  - git
tags:
  - git
---
## 基础
```bash
git config --global http.proxy http://127.0.0.1:1081           #设置http代理
git config --global https.proxy https://127.0.0.1:1081         #设置https代理
git config --global http.proxy 'socks5://127.0.0.1:1081'       #设置socks代理
git config --global https.proxy 'socks5://127.0.0.1:1081'      #设置socks代理
git config --global core.autocrlf false                        #去除warning：LF will be replaced by CRLF警告
git rm -r --cached .                                           #忽略文件不生效时使用并再次提交即可
git config --global user.name "<name>"                         #配置用户名
git config --global user.email "<email>"                       #配置邮箱
git config --system core.longpaths true                        # 允许长文件名

git checkout -b test <name of remote>/test                    # 创建本地分支并切换到远程分支
git daemon --reuseaddr --base-path=. --export-all --verbose --enable=receive-pack # 开启局域网访问 需cd到git工程根目录
git rev-list --all | xargs -rL1 git ls-tree -r --long | awk '{ size=$4/1024/1024; if (size >= 80) {print size" "$0}}' # 查找历史记录的文件大小大于80MB
```
## 删除指定文件所有历史记录
```bash
git filter-branch --force --index-filter "git rm --cached --ignore-unmatch <filepath>" --prune-empty --tag-name-filter cat -- --all
git add .
git commit -m "<message>"
git push origin --all --force
```
## 替换敏感记录内容
```bash
# https://docs.github.com/zh/authentication/keeping-your-account-and-data-secure/removing-sensitive-data-from-a-repository#purging-a-file-from-your-repositorys-history
bfg --replace-text passwords.txt
git add .
git commit -m "<message>"
git push origin --all --force
```