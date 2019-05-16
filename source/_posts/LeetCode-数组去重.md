---
title: 数组去重
date: 2016-12-28 16:49:08
categories: 算法
tags: [LeetCode,数组]

---
 Given a sorted array, remove the duplicates in place such that each element appear only once and return the new length.Do not allocate extra space for another array, you must do this in place with constant memory.

在不分配其他内存空间的条件下进行数组去重，并返回最终数组长度。
<!--more-->
For example, Given input array A = [1,1,2],
Your function should return length = 2, and A is now [1,2].

法一：暴力穷举

```
int RemoveArroyDuplicate(int *Arr,int len){
    if(len<=0){
      return 0;
    }else{
      for (int i = 0; i < len; ++i){
        for (int j = i+1; j < len; ++j){
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

重温C：
- 获取数组长度
  ```
  int arr[] = {8, 5, 5, 1, 7, 6, 1, 9, 11, 3};
  int len=sizeof(arr)/sizeof(int);
  ```
  这里我本想将函数进一步简化，使其只需传入数组指针，可是发现当数组名作为函数参数时退化为指针后sizeof得到的只是指针的长度。

法二：先排序，再去重，这样能大大减少比较的次数。