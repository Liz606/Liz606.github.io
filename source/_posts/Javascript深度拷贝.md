---
title: Javascript深度拷贝
date: 2017-03-06 09:43:04
categories: JavaScript
tags: JavaScript

---

前端面试里经常会提到对象拷贝问题，这个问题之所以重要是因为他可以很好的反映被面试者对于Javascript语言的掌握程度。对象拷贝里涉及了Javascript语言核心内容，如其6个基本类型、Object和数组的区别，如何判断是Object还是数组等~
<!--more-->
首先我们来虚构一个复制的对象，其属性包括一个对象，一个数组，一个对象方法，一个原型方法及一个原型属性。

```
 function Child(){
    this.name="Liz";
    this.favorite=['sleep','delicacy','study'];
    this.friends={
        ctt:{
            name:'Ctt',
            age:'22'
        },
        cyt:{
            name:'Cyt',
            age:'22'
        }
    };
    this.say=function() {
        console.log('Child.say');
    };
 }
 Child.prototype.age="21";
 Child.prototype.sayProto=function() {
        console.log('Child.prototype.say');
    };
```

分析该对象，我们需要对其属性类型进行差别对待。

 1. 基本数据类型，如“number，string，boolean”可直接赋值。
 2. 引用类型（对象），这里需要特别处理Array。
 3. 是否复制原对象的原型方法

由以上分析，我们拟定复制流程

 1. 创建空对象，即sub.
 2. 采用for in遍历原始对象，即sup.
 3. 遍历过程中筛选需要复制的属性，并判断sup属性类型.（筛选方法见4）
	  3.1 当为基本数据类型时直接复制
	  3.2 当为对象类型时（typeof sup[i]==='object'）,进一步判断该属性是否为数组（Object.prototype.toSting.call(arg)==="[object Array]"）.
	  3.2.1 当为一般对象类型时，将sub[i]创建为对象。回到第一步处理sup[i]与sub[i]的深度复制。
	  3.2.2 当为数组类型时，将sub[i]创建为数组。回到第一步处理sup[i]与sub[i]的深度复制。
 4. 我们可以通过object.hasOwnProperty[prop]来筛选原始对象的方法及静态属性，如果不使用filter，则会遍历所有属性，包括原型方法和属性。
	  
```
function extendDeep(sup,sub){
    var i,
    toStr=Object.prototype.toString;
    aStr="[object Array]";
    sub=sub||{};
    for(i in sup){
        if (sup.hasOwnProperty(i)) {
            if (typeof sup[i]==='object') {
                sub[i]=toStr.call(sup[i])===aStr?[]:{};
                extendDeep(sup[i],sub[i]);
            }else{
                sub[i]=sup[i];
            }
        }
    }
    return sub;
}
```
应用

```
 var child1=new Child();
 var child2=extendDeep(child1);
 console.log(child1);
 console.log(child2);
```
事件是检验真理的唯一标准
![这里写图片描述](/images/Javascript深度拷贝1.png)
注意红框部分，为了证明两个对象相互独立，给他来点好玩的···

```
 child2.favorite.push("reading");
```
看看结果如何
![这里写图片描述](/images/Javascript深度拷贝2.png)
如此完美！！！

**注意**
![这里写图片描述](/images/Javascript深度拷贝3.png)
采用hasOwnProperty()进行过滤将只会克隆静态属性，不能找到原型方法。由上图很容易看到，克隆结果的'__proto__'的constructor是指向object的