---
title: 无重复元素数组的二分查找
date: 2016-12-30 09:11:42
categories: 算法
tags: [LeetCode,查找,树,数组]
---


>Suppose a sorted array is rotated at some pivot unknown to you beforehand.(i.e., 0 1 2 4 5 6 7 might become 4 5 6 7 0 1 2). You are given a target value to search. If found in the array return its index, otherwise return -1. You may assume no duplicate exists in the array.
在一个无重复元素的有序数组，查找某个目标元素，返回下标，若不存在，返回-1.
<!--more-->
分析：
这是一个线性查找问题，线性查找主要有三种方式，顺序查找、折半查找（二分查找）和分块查找。由题意可知，这里是无重复元素的数组，但由于被做了无法预知的旋转，现在已经变成无序。在无序的情况下，查找一个元素最坏就是做扫描O(n),这里可以进一步优化的就是先排序再采用折半查找，即二分查找。这里的时间复杂度为O(log(n)).

```
int biTreeSearch(int *Arr,int len,int target){
    int first = 0, last = len;
	const int mid = first+(last - first) / 2;
	while (first != last) {
		if (Arr[mid] == target){
			return mid;
		} else {
			if (Arr[mid] < target && target <= Arr[last-1]){
				first = mid + 1;
			}else{
				last = mid;
			}
		}
	}
	return -1;
}
```