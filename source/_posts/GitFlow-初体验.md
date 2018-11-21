---
title: GitFlow 初体验
date: 2017-01-18 21:46:01
tag: 
  - Git 
categories: Technology  
clearReading: true
thumbnailImage: https://ooo.0o0.ooo/2017/01/21/58836291f0d76.png
thumbnailImagePosition: right 
autoThumbnailImage: yes
metaAlignment: center
comments: true 
summary: 论一粒种子是如何成长为参天大树的

---


<!-- more -->

### 前言
一个大型的项目，只靠一个人是很难全部完成的，只有联合众多开发者，分工明确才可以达到团队最大的产出效率。为此，计算机界就诞生了有名的分布式版本管理系统，如：Git、SVN等。在这些分布式版本管理系统的使用中，一个团队可以共享同一套代码，可以创建不同的项目分支，就像生长的树木一样，从一个节点不断衍生，最终功能不断完善成为一个成功的项目，当然，学习Git和GitFlow工作流也是一门学问，讲道理，它并不是一个交互很友好的系统，虽然它的使用让多数了解他的人觉得效率很高，但是对于初学者来说，研究Git和SVN的路上一定会踩到许多的坑。下面是我学习使用Git和GitFlow工作流的一些心得和爬坑经历。

### GitFlow工作流简介

![](http://upload-images.jianshu.io/upload_images/1123206-870557d4a3191bd7.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

上图是GitFlow官方给出了一个流程介绍图，对与这个流程图的介绍，可以参考Vincent Driessen曾经写过的一篇博文，题为“A successful Git branching model”（一个成功的Git分支模型）:

[A successful Git branching model](http://nvie.com/posts/a-successful-git-branching-model/)

GitFlow WorkFlow， 顾名思义，就是基于Git分布式版本管理系统的多人合作工作流。在具体介绍Git和GitFlow之前，我想先为GitFlow打一个比方：在所有的GitFlow WorkFlow项目里面，整个项目就像是一棵大树，而这个棵树的生长并不是一蹴而就的，从最早的一颗种子开始，这棵大树就不断地向上生长，长出绿叶，岔开分支，最终高达云霄、绿意安然。然而让一粒种子成长为参天大树是一件很困难的事情，不可能只有一个人来完成，GitFlow就是这样的一个工作模式，让所有人位于不同的分支协调工作以加速项目大树的生长，即使某一个大树的分支遭到了破坏导致了坏死，也不会让整个项目的其他部分受到影响。这个就是GitFlow工作流的核心思想，即：分支管理，支流合并。

### GitFlow的运作基础：Git

之前介绍的GitFlow工作流，顾名思义，就是基于分布式版本管理系统Git的。在熟练使用GitFlow工作流完成工作的项目之前，先得掌握这个关键的版本管理系统：Git
Git是linux的作者Linus的第二个改变计算机界的伟大作品。当时，迫于其他版本管理系统对linux开源社区的使用授权压力，linux开源社区的人在Linus带领下开始了Git的研发。相比其他版本管理系统，Git对中央服务器的负荷几乎小到可以忽略，因为每个人在本地都可以拥有属于自己的本地仓库，在没有连接到互联网的情况下，Git仍然能够让作者在本地修改自己的代码和文件，Git并不是保存具体的每一次数据修改，而是通过本地记录文件快照的方式完成对数据的版本控制。而在连接到网络的时候，Git又可以将本地的仓科和远程仓库同步，通过一系列pull、push、fetch等操作完成对本地分支和文件的拉取和更新。

####  ` Git init / Git flow init ` 初始化Git

在创建一个工程的时候，最先我们要做的就是在工程目录里面初始化Git。在这里我们可以使用`git init` 命令来初始化
终端键入这个命令以后，在工作目录下面就会生成一个`.git/ ` 隐藏的文件夹，这个文件夹就是Git的工作目录，所有以后的文件变动所产生的文件快照都会保留在这个文件目录下面。

```bash
⋊> ~/D/gittest git init                                                                                                       19:58:36
Initialized empty Git repository in /Users/mike/Desktop/gittest/.git/                                                                                                19:58:42
⋊> ~/D/gittest on master  ls -al                                                                                              19:59:11
total 0
drwxr-xr-x   3 mike  staff  102  1 28 19:58 .
drwxr-xr-x+  9 mike  staff  306  1 28 19:59 ..
drwxr-xr-x  10 mike  staff  340  1 28 19:59 .git
```

而你想直接让计算机帮助你创建一个完整的GitFlow工作流，那么你可能得现在终端里面安装` git flow `。安装好了以后，就可以直接使用` git flow init ` 来创建一个带有六个基础分支的完整项目了，关于Gitflow 里面的两个长期分支和四个短期分支，我们待会儿再介绍。

```bash
⋊> ~/D/gittest brew install git-flow                                                                                          19:59:23
Updating Homebrew...
^CWarning: git-flow-0.4.1 already installed
⋊> ~/D/gittest git flow init                                                                                                  19:59:58
Initialized empty Git repository in /Users/mike/Desktop/gittest/.git/
No branches exist yet. Base branches must be created now.
Branch name for production releases: [master]
Branch name for "next release" development: [develop]

How to name your supporting branch prefixes?
Feature branches? [feature/]
Release branches? [release/]
Hotfix branches? [hotfix/]
Support branches? [support/]
Version tag prefix? []
⋊> ~/D/gittest on develop

```

#### ` Git add & Git commit ` 添加版本控制和提交更改

在初始化完成以后，我们可以为代码工程添加相应的文件进入版本控制。使用` git add ` 加上要添加的文件名称就可以了。一般对于大型工程，我们没法逐个添加，就可以通过文件` .gitignore ` 来筛选不需要添加进入版本控制的文件内容，之后直接` git add ` 相应的工程目录即可。
我们可以先通过` git status ` 来查看当前工作目录下文件的追踪情况，如果要查看具体的修改，则可以使用` git diff` 命令：
``` bash
⋊> /V/M/F/i/MySpace on feature/NavigationController ⨯ git status                                                              20:17:18
On branch feature/NavigationController
Your branch is up-to-date with 'origin/feature/NavigationController'.
Untracked files:
  (use "git add <file>..." to include in what will be committed)

	text.txt

nothing added to commit but untracked files present (use "git add" to track)

```

添加完成以后就将修改提交到本地的Git仓库：

```bash
⋊> /V/M/F/i/MySpace on feature/NavigationController ⨯ git add text.txt                                                        20:24:45
⋊> /V/M/F/i/MySpace on feature/NavigationController ⨯ git commit -m "add file : text.txt"                                     20:24:59
[feature/NavigationController b27e389] add file : text.txt
 1 file changed, 1 insertion(+)
 create mode 100644 text.txt
⋊> /V/M/F/i/MySpace on feature/NavigationController ↑
```
这样就完成了最简单的修改和提交操作。
<!-- more -->