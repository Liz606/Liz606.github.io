---
title: 值得反复学习的Javascrip核心
date: 2017-01-02 15:08:20
categories: JavaScript
tags: JavaScript
---

JavaScript是一门神奇的语言，犀牛书是一本神奇的书。初学JavaScript之时，翻阅过许多人的学习经验贴，大都推荐这本书，可谓是前端人手必备，要说是前端JavaScript大词典应该还是不为过的。学习是循循渐进的，随着掌握某一领域知识总量的增多，会发现这个领域的知识层层渗透、相互交错，因此每一次的再读犀牛书都会有更加深刻的理解，甚至曾经如何也不明白的知识点竟然也豁然开朗甚至颇有醍醐灌顶之感。所以会有很多人会一次又一次的翻阅这部典籍，一次又一次提炼精髓，让自己对JavaScript的领悟更加深刻。那种对知识融会贯通、由此及彼的感觉实在令人着迷。
<!--more-->
前前后后大概是第五次读犀牛书了，毫不夸张的，每一次都是有迹可循的。只不过并不是通读，是有选择性的跳读。这一次希望最大限度扫描全书，记下曾经让我困惑不已的问题，以达到反复学习的目的。

#### null和undefined
null表示的是一个特殊的值，含义为“非对象”，属于程序级，可预知的、正常的值空缺。
undefined则是变量的一种取值，含义为未定义，属于系统级，出乎意料的值空缺。
对于undefined，我有一个特别的理解，即Javascript是没有显式声明变量类型的

```
var a;
```

这句代码确实是声明了一个变量，可是并没有指明a是整型还一个变量。
所以我认为这里可以认为a没有指明类型即为未定义。

```
typeof null  //"object";这其实是一个历史遗留问题，不必疑惑。
typeof undefined  //"undefined";
```

他们的数字值的转换也有所不同
null => 0
undefined => NaN


#### 暂时性死区
毫不负责任的说，这个名字其实就是装比来的，什么暂时性死区，不过一个函数作用域问题和声明提前问题的合载。
```
var a = "global";
(function(){
	console.log(a);//undefined
	var a = "local";
	console.log(a);//local
})()

```
- 首先从作用域角度来理解：
调用一个函数，系统就会为他创建一个作用域链表，内部优先级高于父函数，以此类推直到全局函数。在局部访问一个变量时，系统首先在内部scope查询该变量，若没有找到，系统将查询上一级父函数scope,以此类推直到全局函数scope.而当内部声明了一个与外部变量同名的一个变量，由于函数作用域优先级的特性，系统将不会再查找作用域链。这就导致了在这个函数里，只可能访问到“local”。
- 再次从函数声明提前的角度来进一步剖析：
JavaScript具有声明提前的特性，即将函数内部所有定义的局部变量的声明都提到函数最前面，导致了变量的声明和初始化分离。

代码对比：
```
(function(){
	console.log(a);//undefined
	var a = "local";
	console.log(a);//local
})()
等价于
(function(){
	var a;
	console.log(a);//undefined
	a = "local";
	console.log(a);//local
})()
```
在声明和初始化这段代码之间，如果访问这个变量，都将返回undefined···这段代码就是相对于这个变量的暂时性死区，嗯，确实和死了差不多···

#### 浮点数精度问题，涉及比较大小
由于Javascript是基于IEEE754标准定义的浮点格式，即是以1/2,1/4,1/8划分的精度，与我们常用的0.1,0.01,0.001有所不同。

```
var a=3.2-2.2;
var b=2.2-1.2;
console.log(a==b);//false
```
这时候我们可以采用判断他们的差值是否小于一个足够小的数来判断他们是否相等。

#### new操作究竟发生了什么？
- 创建一个空对象，并且 this 变量引用该对象，同时还继承了该函数的原型。
- 属性和方法被加入到 this 引用的对象中。
- 新创建的对象由 this 所引用，最后隐式的返回 this 。

```
function Person(){
	this.name="Liz";
	this.sayName=function(){
		console.log(this.name);	
	}
}
Person.prototype.age=22;
Person.prototype.sayAge=function(){
	console.log(this.age);
};
var P=new Person();
```
![Person](/images/Person.png)

#### 深度拷贝问题
首先明确以下几点
- 基本数据类型，如“number，string，boolean”可直接赋值。
- 引用类型（对象），这里需要特别处理Array。
- 是否是原对象的自有原型方法

```
function extendDeep(sup,sub){
    var i,
    toStr=Object.prototype.toString;
    aStr="[object Array]";
    sub=sub||{};
    for(i in sup){
        if (sup.hasOwnProperty(i)) {
            if (typeof sup[i]==='object') {//如果是对象需进一步区别是数组还是Object
                sub[i]=toStr.call(sup[i])===aStr?[]:{};
                extendDeep(sup[i],sub[i]);
            }else{//不是对象则直接复制
                sub[i]=sup[i];
            }
        }
    }
    return sub;
}
```

#### 序列化对象

引用原文：

```
o={x:1,y:{z:[false,null,""]}};//定义一个测试对象
s=JSON.stringify(o);//s是'{"x":1,"y":{"z":[false,null,""]}}'
p=JSON.parse(s);//p是o的深拷贝
```
同样一道高频考点，解析url所带参数，以JSON格式返回。
```
function getData(url){
        var result ={};
        var temp = url.split('?')[1].split('&');
        for(i in temp){
            var s = temp[i].split('=');
            result[s[0]] = s[1];
        }
        return result;
    }
```

#### 函数调用，this剑指何方

首先明白什么是函数，什么是方法。
一般情况下，独立实现某种功能的一段代码，当这段代码以一般函数形式调用时我们称之为函数，当这段代码依赖于某个对象，在某个对象上调用时，我们称之为方法。
如：
```
func();//函数
O.func();//O的一个名为func的方法
```

嵌套函数的this不是指向全局对象（非严格模式）就是undefined（严格模式），嵌套的函数不会从调用它的函数中继承this。
如果嵌套函数作为方法调用，其this的值指向调用它的对象。
顺便多一句嘴，如果函数没有指明return的值，将会默认返回undefined。
JQuery里经常返回this实现链式调用。

#### 理解闭包
首先要知道**函数的执行依赖于变量作用域，这个作用域是在函数定义时决定的，而不是函数调用时决定的。**
闭包即为**函数定义时的作用域链到函数执行时依然有效**这种特性。
这或许是个难点，也困扰了我很久。但至少现在对于我已经不再困难。
我们常说的闭包其实是**当调用函数时闭包所指向的作用域链和定义函数时的作用域链不是同一个作用域链时**这种微妙情况的闭包。
引用原书代码：
```
var scope="global scope";
function checkscope(){
    var scope="local scope";
    function func(){return scope;}
    return func();
}
checkscope()//=＞"local scope"
```
当函数func被调用，系统立即为func创建一个作用域链表，这个作用域链表首先的指向位置是由他定义的时候决定的，故此时作用域链表中优先级最高的就是checkscope。当checkscope执行，func被暴露在全局环境中，但他的作用域并不会发生改变，所以查找scope的值依然先从作用域链表中优先级最高的checkscope开始查询。
进一步的通过底层的原理来理解，为什么checkscope调用结束，func还能访问到checkscope的变量？
我们知道C语言程序的内存使用分布如图所示：
![](/images/内存分布.png)
C语言编写程序在使用内存时一般分为三的段
- 正文段（常量、code）
- 数据堆段（动态分配的存储区，比如JS中new操作）
- 数据栈段（临时变量，即局部变量）

每一次函数调用，都会为该函数创建一个栈，供这次运行使用，一般就是放局部变量。当函数返回，这个栈就会被销毁。然而这里又不得不提到垃圾回收机制，一般系统就是采用引用标记法进行垃圾回收处理，原则就是该变量被引用值为0。在闭包中就打破了这个回收原则。checkscope执行，返回了func，而func内部使用了scope变量，这就使checkscope对应的数据栈不满足回收原则，不能正常被回收，所以func依然可以访问scope的值，且为“local scope”。

再看一个常见的例子
我们期望：返回一个函数组成的数组，它们的返回值是0～9
```
function constfuncs(){
    var funcs=[];
    for(var i=0;i<10;i++){
        funcs[i]=function(){return i;};
    }
    return funcs;
}
var funcs=constfuncs();
funcs[5]()//     10？！
```
但是结果居然全是10。其实由上面所描述的思路来考虑，这个结果很容易被理解。constfuncs被调用，内部有个for循环定义了10个funcs[i],这些funcs[i]的作用域是指向constfuncs的，他们内部的引用的i是同一个constfuncs的局部变量i。因此，当for循环结束，i已经变成了10。fincs[i]被调用时，在其作用域链优先级最高的constfuncs的scope里查找到i并输出，毫无争议应该全是10.

我们可以采用立即执行的方式达到理想效果(在funcs[i]内部声明一个变量x保存当前的i，使函数funcs[i]以i为参数立即执行，返回x。)
```
function constfuncs(){
    var funcs=[];
    for(var i=0;i<10;i++){
        funcs[i]=(function(){
            var x=i;
            return x;
        })(i);
    }
    return funcs;
}
var funcs=constfuncs();
funcs[5];
```

#### call()、apply()、bind()应该怎么玩
三言两语聊一聊
call、apply几乎一致，都是调用其他对象原型方法的方法，唯一不同的是第二个参数，call的第（2+）个参数是此原型方法调用所需的实参，而apply直接传入一个实参数组。
```
f.call(o,1,2);
//等价于
o.m=f;//将f存储为o的临时方法
o.m(1,2);//调用它,传入参数
delete o.m;//将临时方法删除
```
call和apply经常应用于继承原型方法。
bind的参数设置与call是一致的，只不过bind返回的是一个函数。所以调用bind后还需要再调用下返回的函数。手动实现一个bind，加深理解。
```
//返回一个函数，通过调用它来调用o中的方法f()，传递它所有的实参
function bind(f,o){
    if(f.bind){
        return f.bind(o);//如果bind()方法存在的话，使用bind()方法
    }else{ 
        return function(){//否则，这样绑定
            return f.apply(o,arguments);
        };
    }
}
```
总结一下，这三个方法都是希望将方法母体绑定到第一个参数上，即使第一个参数拥有母体的功能。