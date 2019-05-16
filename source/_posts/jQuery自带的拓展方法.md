---
title: $.extend与$.fn.extend
date: 2017-02-16 23:00:06
categories: JavaScript
tags: JavaScript
---


精华： 
- $.extend 添加静态方法
- $.fn.extend 在原型链上拓展方法
<!--more-->

## $.extend ##
没错，这就是jQuery自带的拓展方法
`$.extend({funcName:function(){}})`==`$.funcName=function(){}`
直接将名为funcName的方法添加到jQuery命名空间，而不是jQuery原型链上。
在调用时，我们也需要**通过$或jQuery来调用**，而不是直接调用（隶属于window命名空间的方法才能直接调用）。
来看看例子：

**HTML**

```
<div class="testButton">点我</div>
```

**jQuery**

```
	(function ($) {
		$.tooltip = function( options ) {
			console.log('I`m tooltip');
		};
		$('.testButton').click(function(){
			$.tooltip()
		});

	})(jQuery)
```


在我们写插件的时候可以利用extend来更新参数。
what?更新参数？
对呀，我们可以为插件设置默认参数，通过插件调用的传入的参数就不再需要写冗长的一堆，只需要写自己特别的参数就行了。
在参数内部
`this._config = $.extend(defaults, _pubConfig);`
这个操作就可以将defaults, _pubConfig合并，并去重，再赋值给this._config。



## $.fn.extend ##
我们知道fn===prototype
![这里写图片描述](http://img.blog.csdn.net/20160529203937689)
所以我们通过$.fn.extend去拓展方法的话是会将方法添加到原型链上的。

```
	(function ($) {

		$.fn.tooltip = function( options ) {
			console.log('I`m tooltip');
		};
		$('.testButton').click(function(){
			$(this).tooltip()
		});

	})(jQuery)

```
点击按钮
![这里写图片描述](http://img.blog.csdn.net/20160529203521243)
怎么说呢，在创建一个jQuery实例时，这个实例就会拥有所有原型链上的方法。所以我们可以直接在$(this)上调用。
