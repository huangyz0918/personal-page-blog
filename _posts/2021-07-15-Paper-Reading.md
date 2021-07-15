---
layout: post
title: 'Paper Reading - 15 July'
categories: paper
author: 'Yizheng Huang'
meta: 'Springfield'
---

### Paper

**Title**: On The Marginal Benefit of Active Learning: Does Self-Supervision Eat Its Cake?

**Author**: Yao-Chun Chan, Mingchen Li, Samet Oymak

**Affiliation**: University of California, Riverside

**Publication**: ICASSP 2021

### Background

- Active learning is the set of techniques for intelligently labeling large unlabeled datasets to reduce the labeling effort.（主动学习很火）
- Recent developments in self-supervised and semi-supervised learning (S4L) provide powerful techniques, based on data-augmentation, contrastive learning, and self-training, that enable superior utilization of unlabeled data which led to a significant reduction in required labeling in the standard machine learning benchmarks. （迁移，无监督，半监督学习很火）

### Motivation

本文想探究：

AL 和 S4L 是否可以结合一起，以提升少数标签数据的学习性能？

如果可以，能不能构建一个集成的框架，使得这些 AL 和 S4L （self-supervised pretraining, active learning, and consistency-regularized self-training）的方法可以统一起来取得更好的效果。

### Related Work

- Ali Mottaghi and Serena Yeung, “Adversarial represen- tation active learning,” arXiv preprint arXiv:1912.09720, 2019. （优点：能够充分利用无标签数据，缺点：还是需要很多标签的数据进行训练）
- 绝大部分 AL 方法需要上千（大量）的标签数据来取得 fully-supervised learning 相同的 performance.
- FixMatch, UDA and BOSS 这些 semi-supervised learning 的方法，能够使用 10 到 100 倍少的随机标签数据达到很好的训练效果（类似于监督学习）

### Proposed Content

将 AL 和 S4L 结合的思路：

![](https://ftp.bmp.ovh/imgs/2021/07/722ed075b54beb5e.png)

- 将 self-supervised learning pre-trained model 作为 active learning 的 learner。
- Active learner 从 pool 中选择合适的数据进行标注。
- 以标注过的数据进行半监督学习来 fine-tune 预训练模型 （self-supervised learning）。

### Evaluation

数据集：CIFAR10 and CIFAR100

![](https://ftp.bmp.ovh/imgs/2021/07/5975855b0aca18a0.png)

表一：结合 AL 和 S4L 的准确率比较

![](https://ftp.bmp.ovh/imgs/2021/07/2d04c512ad2991d8.png)

表二：self-supervised pre-training 对 semi-supervised learning performance 的影响

实验带来的 insight:

- Self-supervised pre-training 能够很大程度提升少数标签数据下半监督学习的效果（Google TabNet 那篇文章也有提到, 并不是什么新的 insight）
- 同时使用 S4L 和 AL 时，AL 带来的好处显得不那么明显。

#### Marginal Benefit of Active Learning

究竟是 S4L 的哪个部分归并了 AL 带来的性能提升？

![](https://ftp.bmp.ovh/imgs/2021/07/df3dc6c1e44b8f99.png)

Thus we conclude that the data augmentation subsumes the benefit of active learning and the improvement due to active learning depends on the strength of data augmentation.

从表三中看出，数据增强操作影响了主动学习的效果。主动学习会在无标签数据中提取出信息不确定性高的数据进行标注（或者是趋近于判决界限的数据），而数据增强操作会修改数据本身使得某些数据更富含关键信息，这两个操作实际上是有一定冲突的。

### Conclusion

一个很值得探讨的问题是，主动学习是否值得在一个能够使用数据增强的学习场景下使用？是否能够设计出一种新的主动学习算法，它能够在兼容各种数据增强范式，并且在只有少数标签数据下能够表现得很好？
