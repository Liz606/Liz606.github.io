---
title: 烂熟于心的客户端JavaScript
date: 2017-01-13 17:54:04
categories: JavaScript
tags: JavaScript

---

鄙人之见，客户端JavaScript才更为全面地诠释了JS诞生的真正意义。向客户提供更为灵活的交互服务，更大限度的无作用地做数据存取，与服务端交换数据，及页面间通信。毕竟Web才是JavaScript的主战场，即为前端，何不将客户端JS烂熟于心？
<!--more-->
## JavaScript的单线程模型
客户端和服务端的JavaScript都采用了单线程的工作方式，确保两个事件处理程序不会同时进行，避免了所有多线程所要面对的诸如死锁，竞争条件等恼人的问题。这里简单阐述下，浏览器解析文档时，先创建dom树和render树，当遇到script标签时，解析将暂停，而去执行script标签中的代码。如果外部文件载入顺序不合理，这个阶段容易出现FOUC(Flash Of Unstyle Content)。

## JavaScript载入的时间线


- Web浏览器创建Document对象，并且开始解析Web页面，解析HTML。在这个阶段document.readystate属性的值是"loading"。
- 当HTML解析器遇到没有async和defer属性的＜script＞元素时，它把这些元素添加到文档中，然后执行行内或外部脚本。这些脚本会同步执行，并且**在脚本下载和执行时解析器会暂停**。如果外部文件载入顺序不合理，这个阶段容易出现FOUC(Flash Of Unstyle Content)。
- 当解析器遇到设置了async属性的＜script＞元素时，它开始下载脚本文本，并继续解析文档。脚本会在它下载完成后尽快执行，但是**解析器没有停下来**等它下载。
- 当文档完成解析，document.readyState属性变成"interactive"。
- 所有有defer属性的脚本，会按它们在文档的里的出现顺序执行。
- 当所有内容完成载入时（包括图片），并且所有异步脚本完成载入和执行，document.readyState属性改变为"complete"，Web浏览器触发Window对象上的load事件。
- 从此刻起，会调用异步事件，以异步响应用户输入事件、网络事件、计时器过期等。从事件注册阶段进入事件驱动阶段。

## 怪异模式和标准模式
Microsoft在发布IE6的时候，增加了IE5里没有的很多CSS标准特性。但为了确保与已有Web内容的后向兼容性，它定义了这两种不同的渲染模式。`＜!DOCTYPE html＞`中的DOCTYPE就是告诉浏览器以标准模式渲染文档，如果这个值被缺省，将导致文档以怪异模式进行渲染。
如需知道文档以何种模式进行渲染，只需要检查document.compatMode属性
- CSS1Compat 标准模式
- BackCompat or undefined 怪异模式

## 浏览器种类
浏览器厂商很多，所提供的浏览器类型和版本也不同，我们时常需要对浏览器类型和版本进行检测这里需要用到Navigator.

## 同源策略
同源策略是对JavaScript代码能够操作哪些Web内容的一条完整的安全限制文档的来源包含协议、主机，以及载入文档的URL端口。
- 从不同Web服务器载入的文档具有不同的来源。
- 通过同一主机的不同端口载入的文档具有不同的来源。
- 使用http:协议载入的文档和使用https:协议载入的文档具有不同的来源。

不严格同源：
- 两个二级子域想要相互访问，可设置document.domain属性为顶级域
- 跨域资源共享CORS（Cross-Origin Resource Sharing),服务器用头信息显式地列出源，或使用通配符来匹配所有的源并允许由任何地址请求文件。
- 跨文档消息（cross-document messaging），允许来自一个文档的脚本可以传递文本消息到另一个文档里的脚本，而不管脚本的来源是否不同。例如调用Window对象上的postMessage()方法，可以异步传递消息事件（可以用onmessage事件句处理程序函数来处理它）到窗口的文档里。

其他跨域通信：
- 借用`<script>`发送HTTP请求，JSONP;
- 服务器转发;

## Web安全相关，XSS及拒绝服务攻击
- XSS也就是跨站脚本（Cross-site scripting），即攻击者向目标Web站点注入HTML标签引用其他站点的恶意脚本实施攻击。如果Web页面动态地产生文档内容，且没有对嵌入的HTML标签进行安全排查，那么这个Web页面很容易遭到跨站脚本攻击。解决方案即对所有嵌入的内容进行“消毒”，采用正则匹配等方式，移除HTML标签的尖括号。
- 拒绝服务攻击，即恶意网站通过使用window.setInterval()这样的方法来占用CPU，导致系统内存不足，拒绝服务。拒绝服务最可能发生在跨站攻击的基础上，毕竟谁会傻乎乎的给自己的网站搞个拒绝服务攻击，这样谁还会再次访问这样一个问题网站？

## 解析URL
实际开发过程中，经常需要通过解析URL与服务器通信。这里就必须用到Location对象的search属性。
```
function urlArgs(){
	var args={};//定义一个空对象
	var query=location.search.substring(1);//查找到查询串，并去掉'?'
	var pairs=query.split("＆");//根据"＆"符号将查询字符串分隔为片段
	for(var i=0;i<pairs.length;i++){//对于每个片段
		var pos=pairs[i].indexOf('=');//查找"name=value"
		if(pos==-1)continue;//如果没有找到的话，就跳过
		var name=pairs[i].substring(0,pos);//提取name
		var value=pairs[i].substring(pos+1);//提取value
		value=decodeURIComponent(value);//对value进行解码
		args[name]=value;//存储为属性
	}
	return args;//返回解析后的参数
}
```

## 事件驱动
理解客服端JavaScript的事件机制是学习客户端JavaScript非常重要的一部分。其实W3C标准事件机制本身并不复杂，只是由于Microsoft对IE的“特别定制”，搞得JavaScript程序员比较痛苦。以下称使用addEventListener注册的事件为标准，使用attachEvent注册的事件为IE。
关注下事件机制运作中的重要部分：
- addEventListener及attachEvent。IE8及之前的IE版本只支持attachEvent，其作用与addEventListener一致，只是参数及运作机制部分有差异;
	- 注册次数差异。addEventListener不允许相同事件反复注册，即使变换顺序也只能注册一次，而attachEvent则允许多次注册同名事件;
	- 参数差异。addEventListener的第一个参数为传入注册事件type，attachEvent第一个参数值应为“on”+type。第二个参数都是事件处理程序。addEventListener第三个参数为bool值，默认false，规定事件处理程序在事件传播冒泡阶段执行，由于IE没有捕获阶段，故没有第三个参数;
	- 执行顺序差异。 addEventListener将会按照事件注册顺序依次执行，而attachEvent则不确定;
	- 执行目标差异。使用addEventListener注册的事件，调用的处理程序使用事件目标作为它们的this值。而attachEvent注册的事件的this值是全局对象，需要通过`handler.call(target,event)`来重新绑定this到调用处理程序使用的事件目标;

- 事件传播。事件传播分为三个阶段
	- 事件捕获（由父级向子级传播，IE没有这个阶段）;
	- 目标对象本身的事件处理程序调用;
	- 事件冒泡（由子级向父级传播）;
- 阻止事件传播
	- 标准:调用event.stopPropagation();
	- IE:event.cancelBubble属性赋值为true;
- 事件处理程序作用域。（与普通函数一样，作用域依赖于函数在哪里定义而不是在哪里调用）
- 事件取消。（阻止默认事件）
	- 标准：调用event.preventDefault();
	- IE:event.returnValue赋值为false;
	- 属性注册事件：直接返回false;
- 事件移除
	- 标准：在事件目标上调用removeEventListener();
	- IE：在事件目标上调用detachEvent()方法;