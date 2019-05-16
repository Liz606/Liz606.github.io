---
title: 两个有序数组的中值
date: 2017-01-02 11:08:20
categories: 算法
tags: [LeetCode, 数组, 查找]
---

 There are two sorted arrays A and B of size m and n respectively. Find the median of the two sorted arrays. The overall run time complexity should be O(log(m + n)).
找两个有序数组的中值，要求时间复杂度为O(log(m + n)).
<!--more-->
第一想法是，直接合并两个数组，求k=(m+n)/2，可是显然这是个不合要求的想法，当k接近m+n，时间复杂度将变为O(m + n).

再次，可以怎样优化呢，从何入手？题目条件有**有序**，这么一个完美条件要怎么利用呢···

假设 A 和 B 的元素个数都大于 k/2，将 A 的第 k/2 个元素（即 A[k/2-1]）和 B 的第 k/2个元素（即 B[k/2-1]）进行比较，有以下三种情况
   - A[k/2-1] == B[k/2-1]；
   - A[k/2-1] > B[k/2-1]；
   - A[k/2-1] < B[k/2-1]；

如果 A[k/2-1] < B[k/2-1]，意味着 A[k/2-1] 不可能大于 A ∪ B 的第 k 大元素。因此，我们可以放心的删除 A 数组的这 k/2 个元素。
同理，当 A[k/2-1] > B[k/2-1] 时，可以删除 B 数组的 k/2 个元素。
当 A[k/2-1] == B[k/2-1] 时，说明找到了第 k 大的元素，直接返回 A[k/2-1] 或 B[k/2-1]即可。

因此，我们可以写一个递归函数。那么函数终止条件如下
   - 当 A 或 B 是空时，直接返回 B[k-1] 或 A[k-1]；
   - 当 k=1 是，返回 min(A[0], B[0])；
   - 当 A[k/2-1] == B[k/2-1] 时，返回 A[k/2-1] 或 B[k/2-1]；

```
double find_kth(int A[], int m, int B[], int n, int k) {
    if (m > n) {
        return find_kth(B, n, A, m, k);
    }
    if (m == 0) {
        return B[k - 1];
    }
    if (k == 1) {
        return min(A[0], B[0]);
    }
    int pa = min(k / 2, m), pb = k - pa;
    if (A[pa - 1] < B[pb - 1]){
        return find_kth(A + pa, m - pa, B, n, k - pa);
    }
    else if (A[pa - 1] > B[pb - 1]){
        return find_kth(A, m, B + pb, n - pb, k - pb);
    }
    else{
        return A[pa - 1];
    }
}
int MedianOfTwoSortedArrays(int *A,int m,int *B,int n){
    int total = m + n;
    if (total & 0x1){
        return find_kth(A, m, B, n, total / 2 + 1);
    }
    else{
        return (find_kth(A, m, B, n, total / 2)+ find_kth(A, m, B, n, total / 2 + 1)) / 2;
    }
}
```