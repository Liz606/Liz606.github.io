---
title: Permutation Sequence
photos: /images/bg15.jpg
date: 2017-01-13 17:16:12
categories: 算法
tags: [ LeetCode, 数组]
description: the set contains a total of n! unique permutations.Given n and k, return the kth permutation sequence.Note, Given n will be between 1 and 9 inclusive.一个大小为n的集合，有n!个排序，将n!个排序按排序顺序从小到大又可以排序。给出一个1到9的n,求其第k个排序顺序是多少。
---

---
> the set [1,2,3,…,n] contains a total of n! unique permutations.
By listing and labeling all of the permutations in order, We get the following sequence (ie, for n = 3):
"123"
"132"
"213"
"231"
"312"
"321"
Given n and k, return the kth permutation sequence.
Note: Given n will be between 1 and 9 inclusive.
> 一个大小为n的集合[1,2,3,…,n]，有n！个排序，将n!个排序按排序顺序从小到大又可以排序。给出一个[1,9]的n,求其第k个排序顺序是多少。

分析：
成年人，做事暴力一点，调用k-1次NextPermutation，求出k个序列，既得。可是我们只需要第k个序列，有违写算法的初衷。额，和谐社会，暴力不可取啊···多读书。

