---
layout: post
title: 'Paper Reading - 16 July'
categories: paper
author: 'Yizheng Huang'
meta: 'Springfield'
---

### Paper

**Title**: Towards Lifelong Learning of End-to-end ASR

**Author**: Heng-Jui Chang, Hung-yi Lee, Lin-shan Lee

**Affiliation**: School of Electrical Engineering and Computer Science, National Taiwan University, Taiwan

**Publication**: Interspeech 2021

### Background

- Automatic speech recognition (ASR) technologies today are primarily optimized for given datasets; thus, any changes in the application environment (e.g., acoustic conditions or topic domains) may inevitably degrade the performance. (ASR 火，但是模型准确度会随着数据变化而下降)。

- The concept of lifelong learning (LLL) aiming to enable a machine to sequentially learn new tasks from new datasets describing the changing real world without forgetting the previously learned knowledge is thus brought to attention. （CL/LLL 火，比起 TL 可以防止知识遗忘）。

### Motivation

本文想要探究使用 LLL/CL 方法针对 ASR 模型的实际使用效果，并且对比迁移学习提出一个可行的模型持续学习思路。

### Proposed Content

LLL Workflow:

![](https://i.loli.net/2021/07/16/OBG1IPhgv268cHu.png)

- 端到端语音识别模型一开始在 $$ D_1 $$ 数据集上训练，训练完成得到模型参数 $$ \theta^{1^{*}} $$。
- 之后继续在数据集 $$ D_k $$ 上训练到 $$ k^{th} $$ 次，每一次会保留上一次训练的部分学习样本 $$ D^{+}_{k-1} $$ 进行复习用。
- 训练的目标是模型在之前所有 learning domain ($$ 1 ~ k $$) 上的语音识别准确率。

### Evaluation

#### CL/LLL 用的方法

**Regularization-based Methods:**

- Elastic Weight Consolidation (EWC)
- Synaptic Intelligence (SI)
- Knowledge Distillation (KD)

**Data-based Methods:**

- Gradient Episodic Memory (GEM)
- Minimum Perplexity (PP)
- Median Length (Len)

#### 数据集

- Wall Street Journal (WSJ).
- LibriSpeech (LS).
- Switchboard (SWB). 

#### 模型

- CTC Model
- Language Model (RNN)
- Single Task Results


#### 结论

- KD 在基于正则项的 CL/LLL 方法中表现最好
- Gem + Len 在所有尝试的 CL/LLL 方法中表现最好

![Screenshot 2021-07-16 at 12.26.58 PM.png](https://i.loli.net/2021/07/16/cpshrdT25WmO1BL.png)

探究保存复习样本数量对防止灾难性遗忘的影响：越多的复习样本对于 backward transfer 效果越好。

![Screenshot 2021-07-16 at 12.32.09 PM.png](https://i.loli.net/2021/07/16/asqw1JWA2OfjuNe.png)

Gem + Len （有进行数据选择）的效果会比随机选择复习样本的效果要好，说明数据选择在这个环节还是很有吸引力的。


### Conclusion

本文是实验导向，将传统方法 (CL/LLL) 应用于新领域的一篇文章，本身没有针对具体的应用问题提出什么新的设计，但是通过实验给出了一些 insight, 如果能够深入分析 domain specific 的 insight 是从何而来，文章的质量会得到提升。