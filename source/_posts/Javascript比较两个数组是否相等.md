---
title: Javascript比较两个数组是否相等
date: 2017-4-24 19:21:06
categories: JavaScript
tags: JavaScript
---
使用Javascript比较两个数组是否相等，我们可以怎么做呢？我暂时使用···
<!--more-->

- 首先判断长度
- 再排序
- 转化为字符串
- 做比较
```
if (Arr1.length!=Arr2.length) {
     return true;
 }else{
     if (Arr1.sort().toString()!= Arr2.sort().toString()) {
         return true;
     };
 }
```