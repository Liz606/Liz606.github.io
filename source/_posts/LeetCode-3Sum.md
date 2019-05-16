---
title: 3 Sum
date: 2017-01-04 12:09:37
categories: 算法
tags: [LeetCode,数组]
---
 Given an array S of n integers, are there elements a, b, c in S such that a+ b+ c = 0? Find all unique triplets in the array which gives the sum of zero.
Note:
• Elements in a triplet (a, b, c) must be in non-descending order. (ie, a ≤ b ≤ c)
• The solution set must not contain duplicate triplets.
For example, given array S = {-1 0 1 2 -1 -4}.
A solution set is:
(-1, 0, 1)
(-1, -1, 2)
<!--more-->
分析：先排序，再查找
```
vector< vector<int> > threeSum(vector<int>& num,int len,int Sum) {
   vector< vector<int> > result;
   if (num.size() < 3) return result;
   sort(num.begin(), num.end());//排序
   for (int i = 0; i < len; ++i){
      int a=num[i];
      for (int j = 0; j < len; ++j){
         int b=num[j];
         for (int k = 0; k < len; ++k){
            if(Sum==a+b+num[k]){//找到a,b,c.
               int tmp[]={a,b,num[k]};
               vector<int> triplets(tmp,tmp+3);
               sort(triplets.begin(), triplets.end());//对a,b,c排序
               int flag=0;
               for (int i = 0; i < result.size()&&flag<1; ++i){//对结果集查重
                  for (int j = 0; j < 3; ++j){
                     if(result[i][j]==triplets[j]){
                        flag++;
                     }
                  }
               }
               if (flag<1){//确保没有重复数组
                  result.push_back(triplets);
               }
            }
         }
      }
   }
   return result;
}
```

调用实例：

```
int arr[] = {-1, 0, 1, 2, -1, -4};
int len=sizeof(arr)/sizeof(int);
int Sum=0;
vector<int> triplets(arr,arr+len);
vector< vector<int> > result=threeSum(triplets,len,Sum);
```