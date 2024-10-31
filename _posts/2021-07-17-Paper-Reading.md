---
layout: post
title: 'Paper Reading - Serverless for ML'
categories: paper
author: 'Yizheng Huang'
meta: 'Springfield'
---

### Paper

**Title**: Cirrus: a Serverless Framework for End-to-end ML Workflows

**Author**: Joao Carreira, Pedro Fonseca, Alexey Tumanov, Andrew Zhang, Randy Katz

**Affiliation**: University of California, Berkeley

**Publication**: SoCC 2019

### Background

- Machine learning (ML) workflows are extremely complex, typically involving distinct stages like preprocessing, training, and tuning. These stages have heterogeneous computational requirements and are often repeatedly executed by users (ML workflows are highly complex, involving many tasks such as data preprocessing, training, and post-processing, each with different hardware requirements).

- Serverless computing is an attractive model for tackling the resource management problem (Serverless computing schedules user-submitted tasks in a cloud infrastructure, making it well-suited for resource management while providing a user-friendly interface).

### Motivation 

The motivation is to build a distributed ML training framework based on serverless computing to efficiently manage ML training workflows, make optimal use of resources, and offer an easy-to-use interface.

### Challenge

#### Major Issues of End-to-End ML Workflows

- **Over-provisioning:** Using coarse-grained virtual machine clusters for ML workflows often leads to over-provisioning of resources due to the complexity of configuration and the diversity of tasks, resulting in wasted resources.
- **Explicit resource management:** Letting users manage low-level resources like CPU, storage, and more for cluster VMs is an obstacle for deploying ML workflows, affecting both productivity and efficiency in configuring models.

#### Issues Arising from Combining Serverless with ML Workflows

**Design Principle Inconsistencies between Serverless and ML**

Serverless functions have local resource limitations (memory, CPU, storage, network), which are relatively small compared to other cloud platforms. This is part of the design philosophy of serverless—fine-grained compute units enhance scalability, flexibility, and minimize resource waste. However, ML tasks, especially deep learning, typically require substantial system resources (e.g., frameworks like Spark often load all training data into memory), which conflicts with serverless's fine-grained resource management app

The inconsistencies are mainly in the following areas:

- **Small local memory and storage** : Lambda functions generally have limited memory and storage. For instance, AWS Lambda functions are capped at 3GB RAM and 512MB of local storage, making it unrealistic to run many ML tasks on them (such as TensorFlow or Spark tasks that lack initial resource limits).

- **Low bandwidth and lack of P2P communication**: Lambda functions have lower bandwidth compared to virtual machines. For instance, AWS Lambda's maximum bandwidth is 60MB/s, smaller than that of a mid-range VM, and it doesn't support peer-to-peer communication, preventing the use of distributed algorithms like Ring AllReduce.

- **Short-lived and unpredictable launch times**: Lambda functions are short-lived and their start and stop times are unpredictable. ML training, being long-running, must tolerate frequent worker join or leave events. Runtime environments like MPI (used by frameworks such as Horovod and Multiverso) are incompatible with this characteristic.

- **Lack of fast shared storage.**: Lambda functions follow a storage-separated design, and communication between lambda functions is restricted if it violates functional programming principles. In ML tasks, workers need to share storage for training data. External storage should therefore meet specific requirements: low latency, high throughput, and support for different types of ML workloads, which is not achievable with current technology.

### Related Work 

#### End-to-End ML Workflow 

Dataset preprocessing -> Model training -> Hyperparameter tuning

#### Serverless

PyWren: Uses remote storage to make the system adaptable to data-intensive workloads, but this incurs high overhead for fine-grained operations (e.g., data communication between compute nodes) common in ML workflows (such as frequent database accesses).

### Proposed Content

This work proposes Cirrus, a distributed ML training framework that addresses these challenges by leveraging serverless computing.

Three key contributions:

- Efficient Worker Runtime: Cirrus provides a lightweight worker runtime (approximately ten times smaller than PyWren's runtime). It accommodates various lambda function granularities and helps users automatically select the most appropriate cloud configuration to achieve either cost savings or optimal speed.
- Memory and Storage Efficiency: Cirrus significantly reduces memory and storage demands—basic requirements for many ML tasks. Cirrus reads streaming training minibatches from remote storage and redesigns distributed training algorithms to achieve this.
- Stateless Architecture: By utilizing a stateless architecture (serverless lambda), Cirrus can effectively handle frequent worker starts and stops without compromising performance.

### System Design

The system consists of the (stateful) client-side (left) and the (stateless) server-side (right). The client-side contains a user-facing frontend API and supports preprocessing, training, and tuning. The client-side backend manages cloud functions and the allocation of tasks to functions. The server-side consists of the Lambda Worker and the high-performance Data Store components. The lambda worker exports the data iterator API to the client backend and contains efficient implementations for several iterative training algorithms. The data store is used for storing gradients, models, and intermediate pre-processing results.
