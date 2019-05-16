---
title: 最长连续序列
date: 2017-01-03 17:28:42
categories: 算法
tags: [LeetCode,数组]

---
Given an unsorted array of integers, find the length of the longest consecutive elements sequence.
For example, Given [100, 4, 200, 1, 3, 2], The longest consecutive elements sequence is [ 1, 2, 3, 4]. Return its length: 4.Your algorithm should run in O(n) complexity.
<!--more-->
在时间复杂度为O(n)的条件下找到一个无序数组中最长连续序列。

分析：用一个哈希表 used 记录每个元素是否使用。对每个元素，以该元素为中心，往左右扩张查找，直到不连续为止，记录下最长的长度。

辅助哈希结构体
```
typedef struct ConsList{
  int data;
  bool status;
}ConsList;
```
功能函数1：查找当前元素的加一个步长元素
参数说明：
<pre>ConsList *used    使用情况哈希表
int i             当前中心元素下标
int len           被查找数组长度
int index         序列公差，这里要求为连续，即为1</pre>
```
int findNext(ConsList *used,int i,int len,int index){
    int Nextlength=0;
    bool flag=false;//扫描右边时是否找到
    for (int j = i + 1; j < len; ++j) {//扫描右边直到终点
        if (used[j].data==used[i].data+index){//若找到这个元素，标记被使用，flag置true标志查找成功。
            used[j].status = true;
            ++Nextlength;
            Nextlength+=findNext(used,j,len,index);//以used[j]为新中心，找比used[j]加一个步长元素
            flag=true;
            break;
        }
    }
    if (!flag){//如果在右边没找到再扫描左边
      for (int j = i - 1; j > -1; --j) {//扫描左边直到起点
          if (used[j].data==used[i].data+index){//若找到这个元素，标记被使用。
              used[j].status = true;
              ++Nextlength;
              Nextlength+=findNext(used,j,len,index);//以used[j]为新中心，找比used[j]加一个步长元素
              break;
          }
      }
    }
    return Nextlength;
}
```
功能函数2：查找当前元素的减一个步长元素
参数说明：
<pre>ConsList *used    使用情况哈希表
int i             当前中心元素下标
int len           被查找数组长度
int index         序列公差，这里要求为连续，即为1</pre>
```
//查找当前元素的前一个步长元素
int findPrev(ConsList *used,int i,int len,int index){
    int Prevlength=0;
    bool flag=false;//扫描右边时是否找到
    for (int j = i + 1; j < len; ++j) {//扫描右边直到终点
        if (used[j].data==used[i].data-index){//若找到这个元素，标记被使用，flag置true标志查找成功。
            used[j].status = true;
            ++Prevlength;
            Prevlength+=findPrev(used,j,len,index);//以used[j]为新中心，找比used[j]减一个步长元素
            flag=true;
            break;
        }
    }
    if (!flag){//如果在右边没找到再扫描左边
      for (int j = i - 1; j > -1; --j) {//扫描左边直到起点
          if (used[j].data==used[i].data-index){//若找到这个元素，标记被使用。
              used[j].status = true;
              ++Prevlength;
              Prevlength+=findPrev(used,j,len,index);//以used[j]为新中心，找比used[j]减一个步长元素
              break;
          }
      }
    }
    return Prevlength;
}
```
主体函数：查找最长连续序列长度
参数说明：
<pre>int *Arr          待查数组
int len           被查找数组长度
int index         序列公差，这里要求为连续，即为1</pre>
```
int LongestConsecutive(int *Arr,int len,int index){
    ConsList used[len];
    for (int i = 0; i < len; ++i){
       used[i].data = Arr[i];
       used[i].status = false;
    }
    int longest = 0;
    for (int i = 0; i < len; ++i){
        if (used[i].status) continue;//如果此元素已经被使用，跳出循环
        int length = 1;
        used[i].status = true;
        length+=findNext(used,i,len,index)+findPrev(used,i,len,index);
        longest = max(longest, length);
    }
    return longest;
}
```
调用实例：
```
    int arr[] = {6, 8, 100, 5, 4, 200, 1, 3, 2};
    int len=sizeof(arr)/sizeof(int);
    int index=1;//步长
    len = LongestConsecutive(arr,len,index);
    printf("%d ", len);
```