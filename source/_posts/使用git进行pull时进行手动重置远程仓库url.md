---
title: 使用git进行pull时进行手动重置远程仓库URL
date: 2017-01-15 10:25:57
categories: Tools
tags: [git,Tools]
---

在做开发时换了台电脑，将工程git clone到本地后进行开发。开发结束后想要push到远程。
这时需要先pull进行fix conflict.
此时，使用git pull命令时候遇到“No remote repository specified……”的错误···
<!--more-->
问题症状：
```
git pull
fatal: No remote repository specified.  Please, specify either a URL or a remote name from which new revisions should be fetched.

```


解决方法：

重新配置.git文件夹（属于隐藏文件夹）里面的“config”文件的url：

```
[core]
	repositoryformatversion = 0
	filemode = false
	bare = false
	logallrefupdates = true
	symlinks = false
	ignorecase = true
	hideDotFiles = dotGitOnly
[remote "origin"]
	url = SSP/repositoryName.git
	fetch = +refs/heads/*:refs/remotes/origin/*
[branch "master"]
	remote = origin
	merge = refs/heads/master
[branch "development"]
	remote = origin
	merge = refs/heads/development

```

重新配置目标项目的地址：

url = HTTP或SSP

pushurl = HTTP或SSP