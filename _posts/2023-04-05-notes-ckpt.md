---
layout: post
title: "Using Checkpoint Recovery in Large-Scale ML Training"
categories: tech
author: "Yizheng Huang"
---

### Table of Contents

- [Introduction](#introduction)
- [Checkpoint Recovery](#checkpoint-recovery)
- [Checkpoint Mechanism and Frequency](#checkpoint-mechanism-and-frequency)
- [Consistency Issues with Checkpoints](#consistency-issues-with-checkpoints)
- [Reducing Checkpoint System Overhead](#reducing-checkpoint-system-overhead)
- [Reference](#reference)

### Introduction

When training LLMs or larger deep learning models, distributed GPU clusters and massive amounts of training and testing data are often used. The duration of the training process is also usually quite long. In such cases, if issues like network interruptions or machine failures occur during training, they can cause training interruptions, resulting in significant time and financial losses.

Common causes of training interruptions include:

- Hardware failures (such as GPU crashes or breakpoints)
- System-level issues (like memory overflow, virtual service preemption, etc.)
- Software-level issues (like code bugs, data corruption, etc.)

Therefore, in a large-scale machine learning training task, to increase the system's fault tolerance, we need to introduce mechanisms to ensure the reliability of the training process. One important mechanism among these is **checkpoint recovery**.

### Checkpoint Recovery

A checkpoint refers to periodically saving the model's parameters, the state of the optimizer, and other status information during the training process. This way, if training is interrupted, the process can be resumed by loading the checkpoint, rather than starting from scratch.

Common checkpoint APIs include TensorFlow’s `tf.train.Checkpoint` and PyTorch’s `torch.save`. To implement checkpoint recovery, we not only need a high-level API but also a low-level storage system to store the checkpoint. This storage system needs to have the following features:

- **High performance**: The storage system should ensure efficient writing and reading of checkpoints.
- **High reliability**: The storage system should ensure the checkpoint's reliability, meaning that once written, the checkpoint will not be lost. Additionally, if the storage system fails, mechanisms like backups should be in place to recover the checkpoint.

### Checkpoint Mechanism and Frequency

When designing and implementing a checkpoint recovery system, the most important considerations are the **checkpoint mechanism and frequency** —these depend on the nature of the training task, such as the task’s duration, the size of the training data, and the complexity of the task.

Common checkpointing mechanisms include:

- Periodically saving checkpoints based on the number of training steps
- Periodically saving checkpoints based on training time
- Periodically saving checkpoints based on the number of epochs

![recover time](https://s2.loli.net/2024/11/02/j5nzSJ7TBri8wCp.png)

If the training task involves a large amount of data but relatively few model computations (memory-bound models), we can periodically save checkpoints based on the number of training steps. This ensures a relatively high checkpoint frequency during training. Conversely, if the training task involves substantial model computations but relatively little data (compute-bound models), we can save checkpoints based on training time to ensure sufficient checkpoints are available for recovery.

### Consistency Issues with Checkpoints

Checkpointing introduces some consistency challenges, such as:

- Consistency issues between checkpoints across different workers in a distributed training system
- Consistency between checkpoints and the training process

In distributed systems, the checkpoint recovery approach will vary depending on the training method. Generally, each compute node needs to save checkpoints (whether in data parallelism or model parallelism). However, during recovery, we must consider how to maintain checkpoint consistency across nodes. How can we resume normal training when the number of workers changes? How can we quickly verify the validity of checkpoints? How can we synchronize checkpoints across workers?

The checkpoint recovery process must ensure the atomicity of checkpoints. Assuming the training process is uninterrupted and checkpoint saving is asynchronous, the training process may continue while the checkpoint is being saved, leading to inconsistencies between the checkpoint and the model in the training process. To address this issue, we can adopt the following strategies:

- Use synchronous checkpoint saving, where training is paused (**stall training**) while the checkpoint is saved, and resume training only after the checkpoint save is complete.
- Use asynchronous checkpoint saving (**snapshot and persist**), where the training process continues while a snapshot of the model is taken and the model is localized (persist) asynchronously. During recovery, verification is required to ensure checkpoint consistency.

### Reducing Checkpoint System Overhead

The checkpoint mechanism introduces some additional overhead, such as I/O overhead and CPU overhead. For example, if a synchronous checkpoint save is used (stall training), the training process is paused while saving the checkpoint, reducing training efficiency. If asynchronous checkpoint saving is used, additional I/O overhead is introduced, which can also decrease training efficiency.

In summary, while checkpoint recovery increases system stability, it also reduces system efficiency—this is a clear trade-off. To reduce the checkpoint system overhead, we can adopt the following strategies:

- Predict potential system failures and save checkpoints dynamically: for example, increase checkpoint frequency when the network is unstable or monitor the hard drive's status, using a DNN-based predictive model to anticipate drive failures.
- Use a high-performance storage system: for example, use SSDs instead of HDDs to save checkpoints, or use a KV storage system rather than a file system to save checkpoints, and so on.

### Reference

- CheckFreq: Frequent, Fine-Grained DNN Checkpointing (FAST '21)
- Check-N-Run: a Checkpointing System for Training Deep Learning Recommendation Models (NSDI '22)
