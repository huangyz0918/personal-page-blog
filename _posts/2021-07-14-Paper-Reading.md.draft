---
layout: post
title: 'Paper Reading - 14 July'
categories: paper
author: 'Yizheng Huang'
meta: 'Springfield'
---

### Paper

**Title**: Collaborative Inference via Ensembles on the Edge

**Author**: Nir Shlezinger, Erez Farhan, Hai Morgenstern, and Yonina C. Eldar

**Affiliation**: Ben-Gurion University of the Negev, Beer-Sheva, Israel

**Publication**: ICASSP 2021

### Background

- The success of deep neural networks (DNNs) as an enabler of artificial intelligence (AI) is heavily dependent on high computational resources.
- The increasing demands for accessible and personalized AI giverise to the need to operate DNNs on edge devices such as smartphones, sensors, and autonomous cars, whose computational powers are limited.

### GAP

- One of the main challenges associated with implementing trained DNNs on edge devices stems from their limited computational resources.
- The need to communicate with the centralized server gives rise to the challenges such as latency, connectivity constraints, and privacy.

### Motivation

This paper want to present a framework for facilitating the application of DNNs on the edge in a manner which allows multiple users to collaborate during inference in order to improve their prediction accuracy, and latency.

### Related Work

#### Model Compression

Strategies like pruning and quantization focus on a single edge user, and thus do not exploit the fact that while each device islimited in its hardware, multiple users can collaborate to benefitfrom their joint computational resources.

#### Model Partitioning

These kind of approaches jointly form the large DNN during inference via computation offloading. The main drawback of this approach is that each user cannot infer on its own, and the complete set of devices among which the DNN is divided must be present, resulting in high dependence on connectivity and possibly increased latency.

### Proposed Content

#### System Model

For example, AI-empowered vehicleswhich may operate in areas without connectivity to some centralized cloud server while being able to communicate in a device-to-device manner. So this paper has the goal to characterize a mechanism and the corresponding DNN architecture for facilitating inference based on the samplexit, focusing on schemes which do not require connectivity with a central server, but can connect to other device.

![](https://i.loli.net/2021/07/14/L3QMiI79GjSyDdC.png)

#### Collaborative Inference Strategies

- A straight-forward design is to train a single DNN with $$ M $$ parameters and have each device use it as its local model (类似于联邦学习).
- An alternative strategy which exploits the ability of the users to collaborate during inference is based on partitioning a pre-trained highly-parameterized DNN among multiple users (模型分割+集成学习).

设计要求：

- DNN 要能够在对应的设备上 handle 该设备自己的请求 (自给自足)，不然就需要模型压缩或者是分割，或多或少影响性能。
- 因为要提升准确率，集成的模型需要是不一样的。

#### Deep Ensembles

Ensemble methods utilize multiple models whose outputs are combined to achieve improved results. Deep ensembles utilize DNNs as the individual models. Here, during inference, the input sampleis processed by each of these DNNs in parallel, and their outputsare aggregated into a single prediction.

Since these aggregation methods can be applied with different numbers of models, deep ensembles are inherently scalable, which is desirable for edge-based collaborative settings.

#### Edge Ensembles

The core idea of edge ensembles is to provide each user the ability to carry out inference on its own, while allowing to benefit from collaboration with neighboring devices by forming together anensemble of DNNs.

Workflow:

- The inference stage begins at a given time instance $$ t $$, when all deep models are pre-trained, and a user of index it observes a data sample $$ x\_{i_t} $$, to be used for inference.
- The user $$ i_t $$ then broadcasts the sample $$ x_{i_t} $$, resulting in $$ i_t $$ being available to all users in the set $$ S^{t}_{i} $$ (represents the edge ensemble model available to user $$ i $$ at time instance $$ t $$).
- Next, each user in $$ S^{t}_{i} $$ applies its local model to that sample, and conveys the resulting $$ f_{\theta_{j}}(x_{i_t}) $$back to userit, which aggregates them into the predicted $$ \hat{y}_{i_t} $$.

![](https://i.loli.net/2021/07/14/8DWQB1V5YjZG9N4.png)

#### Latency Analysis 

用理论分析 latency, 略。


### Evaluation

实验非常简单，用 MobileNet 做图像分类，数据集是 CIFAR-10。

![](https://i.loli.net/2021/07/14/wKTkaPXHdE8eRjZ.png)

左图表示模型集成的越多准确率越高，模型参数越多准确率越高；右图表示模型模型参数量阅读，推理效果越好，甚至通过集成，可以在总参数量小于所有 device 总和的情况下表现的比单个中央模型更高的准确率。


### Conclusion

- No many insights.
