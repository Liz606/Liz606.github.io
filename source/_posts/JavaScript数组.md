---
title: JavaScript数组
date: 2017-02-18 22:24:19
categories: JavaScript
tags: [JavaScript,数组]

---
数组在javascript中是一种特殊对象，拥有许多方法。数组在JavaScript中功能强大，非常有必要熟练掌握。

<!--more-->
### 创建数组 ###

#### []操作符
  
```
	var Arr=[];
	Arr.length;//0
	var Arr=[1,2,3,4,5];
	Arr.length;//5
```

#### 调用Array构造函数

```
var Arr=new Array(1,2,3,4,5);
console.log(Arr.length);//5
var Arr=new Array(10);
```
![这里写图片描述](http://img.blog.csdn.net/20160407105230640)


### 数组的各种方法 ###

#### split()生成数组

以某分隔符将字符串分成几部分，并将每部分作为一个元素保存于一个新建的数组中。

```
var str='nice to meet you';
var arr=str.split(" ");
for(var i=0;i<arr.length;i++){
	console.log(arr[i]);
}
```
![这里写图片描述](http://img.blog.csdn.net/20160407110758114)



#### indexOf()&lastIndexOf()索引

用来查找传进来的参数在目标数组中是否存在，并返回其第一次出现的索引，否则返回-1。**lastIndexOf()**与indexOf()类似，只是从后开始检索，返回其最后一次出现的索引。
```
var arr=['hi','hello','halo','hello'];
console.log(arr.indexOf('hello');
console.log(arr.lastIndexOf('hello'));
```
![这里写图片描述](http://img.blog.csdn.net/20160407111640493)



#### jion()&toString()数组转化字符串

在jion()没有参数的情况下， jion()、toString()都将数组转化为以逗号分隔的字符串。当jion()带参数，则数组被转化为由该参数为分隔符的字符串

```
var arr=['hi','hello','halo','hello'];
console.log(arr.join());
console.log(arr.toString());
console.log(arr.join('||'));
```
![这里写图片描述](http://img.blog.csdn.net/20160407112507949)


#### splice()&concat()由已有数组创建新数组

concat()合并多个数组，A.concat(B,C)将生成一个新数组，并且顺序由A->C;
splice(a,b,c)有三个参数，功能也由这三个参数决定，当只有一个参数时和slice只有一个参数一样从该参数为索引一直截取到最后一个元素,当只有两个参数时，则意味从索引a开始截取b个元素，当有三个参数时则意味从索引a开始截取b个元素并在此索引处插入c元素，c元素可以为多个元素。
splice会生成新的数组也会改变旧数组。



```
var arr1=['hi1','hello1','halo1','hello1'];
var arr2=['hi2','hello2','halo2','hello2'];
console.log(arr1.join());
console.log(arr2.join());
var arr3=arr1.concat(arr2);
var arr4=arr1.splice(2,1);
console.log(arr1.join());
console.log(arr2.join());
console.log(arr3.join());
console.log(arr4.join());
```
![这里写图片描述](http://img.blog.csdn.net/20160407113746642)



#### push()&unshift()为数组添加元素
 
push()将元素添加到数组末尾。
unshift()将元素添加到数组开头。

```
var arr=['b','c','d'];
console.log(arr.join());
arr.push('e');
console.log(arr.join());
arr.unshift('a');
console.log(arr.join());
```
![这里写图片描述](http://img.blog.csdn.net/20160407115105772)



#### pop()&shift()为数组删除元素
 
pop()将数组末尾元素删除。
shift()将数组开头元素删除。
```
var arr=['a','b','c','d','e'];
console.log(arr.join());
arr.pop();
console.log(arr.join());
arr.shift();
console.log(arr.join());
```
![这里写图片描述](http://img.blog.csdn.net/20160407115302069)




#### reverse()&sort()为数组排序
 
[sort详解](http://m.blog.csdn.net/article/details?id=51043357)
reverse()数组元素倒序排列。

```
var arr=['a','b','c','d','e'];
console.log(arr.join());
arr.reverse();
console.log(arr.join());
```
![这里写图片描述](http://img.blog.csdn.net/20160407115825446)





#### 不生成新数组的迭代器
    

- forEach()接受一个函数作为参数，对数组每一个元素执行该函数。该函数没有返回值。他是**只读**操作，不会改变原始数组，如果希望改变元素数组··目前我没想到使用什么方法，姑且先使用map（），将生成了新元素的数组赋值到原始数组达到目的。

```
var arr=[1,2,3,4,5,6];
function square(num){
	console.log(num+'的平方为'+num*num)
}
arr.forEach(square);
```
![这里写图片描述](http://img.blog.csdn.net/20160407123208508)

- every()接受一个返回值为bool类型的的函数，对数组每一个元素执行该函数，如果对于所有的元素该函数都返回true，则every()返回true。

- some()接受一个返回值为bool类型的的函数，对数组每一个元素执行该函数，只要有一个元素执行该函数返回true，则some()返回true。

- reduce()接受一个函数作为参数，对数组每一个元素执行该函数返回一个值，reduce会对结果进行累加，最后返回累加值。

```
var arr=[1,2,3,4,5,6,7,8,9];
function add(e,f) {
	return e+f;
}
var arrStr=arr.reduce(add);
console.log(arr.join());
console.log(arrStr);
```
![这里写图片描述](http://img.blog.csdn.net/20160407124159324)
- reduceRight()接受一个函数作为参数，倒序对数组每一个元素执行该函数返回一个值，reduce会对结果进行累加，最后返回累加值。

```
var arr=['1','2','3','4','5','6','7','8','9'];
function add(e,f) {
	return e+f;
}
var arrStr1=arr.reduce(add);
var arrStr2=arr.reduceRight(add);
console.log(arr.join());
console.log(arrStr1);
console.log(arrStr2);
```
![这里写图片描述](http://img.blog.csdn.net/20160407124317137)




#### 生成新数组的迭代器
 

map()与 forEach()类似，接受一个函数作为参数，对数组每一个元素执行该函数，但该函数有返回值。

```
var arr1=[1,2,3,4,5,6];
function square(num){
	return num*num;
}
var arr2=arr1.map(square);
console.log(arr1);
console.log(arr2);
```
![这里写图片描述](http://img.blog.csdn.net/20160407130959055)

filter与every()相似接受一个返回值为bool类型的的函数，对数组每一个元素执行该函数，filter会返回一个新数组，新数组包括执行该函数返回值为true的所有元素。

```
var arr1=[1,2,3,4,5,6];
function iseven(num){
	return num%2==0;
}
var arr2=arr1.filter(iseven);
console.log(arr1);
console.log(arr2);
```
![这里写图片描述](http://img.blog.csdn.net/20160407131410932)



#### 复制数组
 
- 浅度复制
浅度复制即将一个数组直接赋值给另一个数组，这只是为原先的数组增加了一个引用而已。

```
var arr1=[1,2,3,4,5,6];
var arr2=arr1;

console.log(arr1);
console.log(arr2);
arr1[0]=9999;
console.log(arr1);
console.log(arr2);
```
![这里写图片描述](http://img.blog.csdn.net/20160407131837309)

- 深度复制
我们可以自定义一个深度复制copy()方法

	```
	var arr1=[1,2,3,4,5,6];
	var arr2;
	copy(arr1,arr2);
	console.log(arr1.join());
	console.log(arr2.join());

	arr1[0]=9999;
	console.log(arr1.join());
	console.log(arr2.join());
	function copy (arr1,arr2) {
		for (var i = 0; i <arr1.length; i++) {
			arr2[i]=arr1[i];
		};
	}
	```
![这里写图片描述](http://img.blog.csdn.net/20160407132652062)



#### 创建二维数组
 

```
Array.matrix=function(row,col,int){
	var arr=[];
	for (var i = 0; i < row; i++) {
		var cols=[];
		for (var j = 0; j < col; j++) {
			cols[j]=int;
		};
		arr[i]=cols;
	};
	return arr;
}
var nums=Array.matrix(5,5,'Liz');
console.log(nums.join());
```
![这里写图片描述](http://img.blog.csdn.net/20160408084309336)



#### 创建参差不齐的
 
其实只要知道了行数就行了。
先创建N行1列的数组，有需要再往里面添加便是

 
#### 处理二维数组
 
一般分两种，按行遍历和按列遍历。
