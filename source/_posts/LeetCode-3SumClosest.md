---
title: 3 Sum Closest
date: 2017-01-05 09:46:03
categories: 算法
tags: [LeetCode,算法,数组]
---

Given an array S of n integers, find three integers in S such that the sum is closest to a given number,target. Return the sum of the three integers. You may assume that each input would have exactly one solution. For example, given array S = {-1 2 1 -4}, and target = 1.the sum that is closest to the target is 2. (-1 + 2 + 1 = 2);
在一个有n个整数的数组S中寻找3个整数，使三个之和最接近于指定整数。
<!--more-->
分析：3Sum是在数组中寻找三元之和等于sum,3SumClosest是求其和最接近于target。功能非常相近，因此还是应该先排序。

```
vector<int>  threeSumClosest(vector<int>& num, int target) {
	vector<int>  result;
	int len=num.size(),a,b,c,Dvalue=abs(target-(num[0]+num[1]+num[2]));
	sort(num.begin(), num.end());
	for (int i = 0; i < len; ++i){
		a=num[i];
		for (int j = i+1; j < len; ++j){
			b=num[j];
			for (int k = j+1; k < len; ++k){
				c=num[k];
				if (abs(target-(a+b+c))<Dvalue){
					Dvalue=abs(target-(a+b+c));
					if (result.size()>0){
						result.pop_back();
						result.pop_back();
						result.pop_back();
					}
					result.push_back(a);
					result.push_back(b);
					result.push_back(c);
				}
			}
		}
	}
	return result;
}
```

调用实例：
```
int arr[] = {-1, 2, 1 -4};
int len=sizeof(arr)/sizeof(int);
int Sum=1;
vector<int> triplets(arr,arr+len);
vector<int> result=threeSumClosest(triplets,Sum);
```