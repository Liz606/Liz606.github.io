有些用户在使用git pull命令更新本地项目的时候会遇到“No remote repository specified……”的错误，那么要如何解决呢？

git pull

fatal: No remote repository specified.  Please, specify either a URL or a

remote name from which new revisions should be fetched.

其实出问题的原因是.git/config的配置出问题了。

解决方法：

修改“.git”文件夹里面的“config”文件的url就可以了：

[core]

        repositoryformatversion = 0

        filemode = true

        bare = false

        logallrefupdates = true

        ignorecase = true

        precomposeunicode = false

[remote "origin"]

        url = https://github.com/checkfrank/checkfrank.github.io.git

        fetch = +refs/heads/*:refs/remotes/origin/*

        pushurl = https://github.com/checkfrank/checkfrank.github.io.git

[branch "master"]

        remote = origin

        merge = refs/heads/master

把其中换成你项目的地址就可以了：

url = https://github.com/CrossLee/xxx.git

pushurl = https://github.com/CrossLee/xxx.git