---
title: Next Permutation
date: 2017-01-10 11:58:11
categories: 算法
tags: [LeetCode,数组]

---
 Implement next permutation, which rearranges numbers into the lexicographicalally next greater permutation of numbers. If such arrangement is not possible, it must rearrange it as the lowest possible order (ie, sorted in ascending order).the replacement must be in-place, do not allocate extra memory.在不分配额外内存的条件下，寻找比当前排序顺序大的下一个排序。若当前排序已经最大，就寻找最小排列。
<!--more-->
> Here are some examples. Inputs are in the left-hand column and its corresponding outputs are in theright-hand column.
1,2,3 → 1,3,2
3,2,1 → 1,2,3
1,1,5 → 1,5,1

分析：
首先分析什么时候排列顺序最大，即数组越大的元素排在最前（最高位）。同，当排序顺序呈广义递减时，排序顺序最大。
比当前排序顺序大的下一个排序又是什么情况呢？借助排列顺序最大的情况来考虑，从排序数列尾部向前遍历，找到第一个逆序数对（如[3,4,1,4,3,2,1]中，[1,4]即为第一个逆序数对），将逆序数对及其后的所有排序数（[1,4,3,2,1]）进行重排，得到比当前排序顺序大的下一个排序。
重排规则：
例：[1,4,3,2,1]->[2,1,1,3,4]
- 也是从排序数列尾部向前遍历找到第一个比逆序数大的数字(找到第一个比1大的数字，即2)。
- 交换两个数字顺序（[1,4,3,2,1]->[2,4,3,1,1]）。
- 再对除第一个数字外的新数列进行反转即可（[1,4,3,2,1]->[2,1,1,3,4]）。

```
vector<int> NextPermutation(vector<int> &A, int len) {
    int i,j;
    int flag = 0;
    for (i = len-1; i > 0 ; --i) {
        if (A[i]-A[i-1]<=0){
            flag++;
        }else{
            for (int j = len-1; j >= i; --j){
                if (A[j]>A[i-1]){//找到第一个比A[i-1]大的数字
                    swap(A[j],A[i-1]);
                    reverse(A.begin()+i, A.end());
                    return A;
                }
            }
        }
        if (flag==len-1){//如果广义递减，则反转数组
            reverse(A.begin(), A.end());
            return A;
        }      
    }
}

```
调用实例：
```
int arr[] = {1,4,3,2,1};
int len=sizeof(arr)/sizeof(int);
vector<int> A(arr,arr+len);
vector<int> result = NextPermutation(A, len);
```