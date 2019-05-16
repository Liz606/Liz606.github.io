---
title: 动态创建DOM元素
date: 2017-02-10 21:51:20
categories: JavaScript
tags: JavaScript
---
在实际开发过程中，经常需要动态添加元素。
<!--more-->
#### JQuery创建DOM元素 ####

HTML
```
<div class="pc-container">
</div>
```

JQuery
```
var container = $('.pc-container');
$('<img>').attr({
            src:'images/star.png'
        }).css({
                top:'50px',
                left:'50px',
                transform:'scale(.5) rotateZ(90deg)',
                position: 'absolute'
 }).addClass('myImg').appendTo('.pc-container');
```




#### JavaScript创建DOM元素 ####

HTML
```
<div class="pc-container">
</div>
```
JavaScript
```
var container=document.getElementsByClassName('.pc-container')[0];
var div=document.createElement('div');
div.setAttribute('id','example');// div.id = "example";div.className = "slogan";
div.style.width='120px';
container.appendChild(div);
```



#### 插入元素的几种方法 ####

这里顺便总结一下插入元素的几种方法

** JavaScript：**
element1.appendChild(element2); 在element1的内部结尾追加element2.

** JQuery: **
```
$(A).append(content|fn) 在匹配的元素A内部结尾追加内容 
$(A).appendTo(B) 将A的内容追加到B内部结尾 
$(A).prepend(content) 在匹配的元素A内部的开头插入content内容 
$(A).prependTo(B) 将匹配到的A元素追加到B的开头

$(A).after(content) 在匹配的元素A之后插入内容content 
$(A).before(content) 在匹配的元素A之前插入内容content 
$(A).insertAfter(B) 将A的内容追加到B之后 
$(A).insertBefore(B) 将A的内容追加到B之前
```

