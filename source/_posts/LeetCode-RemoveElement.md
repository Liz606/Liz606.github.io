---
title: Remove Element
date: 2017-01-8 09:36:41
categories: 算法
tags:  [LeetCode,数组]

---
 Given an array and a value, remove all instances of that value in place and return the new length. the order of elements can be changed. It doesn’t matter what you leave beyond the new length.给定一个数组和一个值，删除数组中与这个值相等的元素。元素的顺序可以被改变。
<!--more-->
法一：
```
int removeElement(int A[], int n, int elem) {
	int index = 0;
	for (int i = 0; i < n; ++i) {
		if (A[i] != elem) {
			A[index++] = A[i];
		}
	}
	return index;
}
```

调用实例：
```
int arr[] = {-1, 0, 1, 2, -1, -4};
int len=sizeof(arr)/sizeof(int);
int value=0;
int index = removeElement(arr, 6, value);//5
```

法二：
此题也可以先排序，再删除元素。