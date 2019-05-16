---
title: 有序数组去重
date: 2016-12-29 10:22:35
categories: 算法
tags: [LeetCode,数组]
---

Follow up for ”Remove Duplicates”: What if duplicates are allowed at most twice? 

将一个有序数组去重，使重复元素最多出现两次。
<!--more-->
For example, Given sorted array A = [1,1,1,2,2,3], 
Your function should return length = 5, and A is now [1,1,2,2,3] 

法一：蜜汁算法，低级暴力。
```
int RemoveSortedArroyDuplicate(int *Arr,int len){//暴力穷举
    if(len<=0){
      return 0;
    }else{
      for (int i = 0; i < len; ++i){
        for (int j = i+1; j < len; ++j){
          if(Arr[i]==Arr[j]){
            for (int m = j; m < len; ++m){//数组元素前移
              Arr[m]=Arr[m+1];
            }
            len--;//删除多余空间
          }
        }
      }
    }
  return len;
}
```

法二：
```
int RemoveSortedArroyDuplicate(int *Arr,int len){
    if(len<=0){
      return 0;
    }else{
      int index=2;//步长
      for (int i = 0; i < len; ++i){
        for (int j = i+index; j < len && Arr[i]==Arr[j]; ++j){//因为是有序数组，故当出现不相等的元素，即停止此次循环
          if(Arr[i]==Arr[j]){
            for (int m = j; m < len; ++m){//数组元素前移
              Arr[m]=Arr[m+1];
            }
            j--;//重新比较
            len--;//删除多余空间
          }
        }
      }
    }
  return len;
}
```