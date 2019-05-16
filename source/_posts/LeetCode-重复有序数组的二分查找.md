---
title: 重复有序数组的查找
date: 2016-12-31 12:06:26
categories: 算法
tags: [LeetCode,查找,树,数组]

---
Follow up for ”Search in Rotated Sorted Array”:What if duplicates are allowed? Would this affect the run-time complexity? How and why? Write a function to determine if a given target is in the array.
若被查找有序数组允许元素重复，会对时间复杂度造成什么影响，为什么？
编写一个函数，完成在重复有序数组中查找目标元素。
<!--more-->
在{% post_link LeetCode-无重复元素数组的二分查找 %}中，时间复杂度可以优化到O(log(n))。但由于二分查找只适用于无重复元素的有序数组，所以这里没办法使用二分查找。其次的话就是直接O(n)扫描了。在这里对传统二分查找进行了优化，虽然最坏时间复杂度依然是O(n)，但在重复元素不太多的情况下也是可以优化到O(log(n))的。


```
int  DupBiTreeSearch(int *Arr,int len,int target){
    int first = 0, last = len;
	while (first != last) {
		const int mid = first+(last - first) / 2;
		if (Arr[mid] == target){
			return mid;
		} else {
			if (Arr[first] < Arr[mid]){
				if (Arr[first] <= target && target < Arr[mid]){
					last = mid;
				}
				else{
					first = mid + 1;
				}
			}else if(Arr[first] > Arr[mid]){
				if (Arr[mid] <= target && target <= Arr[last-1]){
					first = mid + 1;
				}
				else{
					last = mid;
				}
			}else{
				first++;
			}
		}
}
```



