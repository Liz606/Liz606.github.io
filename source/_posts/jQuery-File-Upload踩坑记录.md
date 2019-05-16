---
title: jQuery-File-Upload踩坑记录
date: 2017-04-19 19:39:05
categories: [JavaScript]
tags: [JavaScript]
---

<!--more-->
[jQuery-File-Upload官网](https://github.com/blueimp/jQuery-File-Upload/wiki)

### 官方实例
HTML:
```
<input id="fileupload" type="file" name="files[]" data-url="server/php/" multiple>
```
依赖：
```
<script src="js/jquery.min.js"></script>
<script src="js/vendor/jquery.ui.widget.js"></script>
<script src="js/jquery.iframe-transport.js"></script>
<script src="js/jquery.fileupload.js"></script>
```
JS调用：
```
$('#fileupload').fileupload({
        dataType: 'json',
        done: function (e, data) {
            $.each(data.result.files, function (index, file) {
                $('<p/>').text(file.name).appendTo(document.body);
            });
        }
    });
```
显然以上调用在实际项目中实在太过鸡肋···来点刺激的

### options常用配置

```
$this.fileupload({
     url: url,//服务器API
     autoUpload: false,//是否自动上传
     acceptFileTypes: /(.|\/)(jpe?g|png)$/i,//文件格式限制
     maxNumberOfFiles: 1,//最大上传文件数目
     maxFileSize: 5000000,//文件不超过5M
     sequentialUploads: true,//是否队列上传
     dataType: 'json'//期望从服务器得到json类型的返回数据
})
```

### 事件Callback
- 挂载方法 
	```
	  $this.fileupload({options})
	   .bind('fileuploadadd', function (e, data) {/* ... */})
	   .bind('fileuploadsubmit', function (e, data) {/* ... */})
	   .bind('fileuploaddone', function (e, data) {/* ... */})
	   .bind('fileuploadprogressall', function (e, data) {/* ... */})
	```
- done没有回调函数的问题，有网友说是由于dataType设置为了json，把autoUpload设置为true这都是什么跟什么？！我是使用的手动触发上传，关键代码为`$handler.click(function(){data.submit(); })`看吧，是使用的submit触发的，而回调函数有fileuploadsubmit，那就对应起来啦。

- 但是后台要返回数据时，又必须响应fileuploaddone才能拿到数据，后台返回结果存在data.result里···小姐姐我也很绝望啊···还需要继续踩坑啊啊啊~~~

### 图片预览
官网的图片预览使用了canvas，对于小型开放···感觉成本太高（其实是太懒）。 在图片添加完成后会出发事件fileuploadadd，他的回掉函数有两个参数（e,data），我们上传的file就在data里。
data.files是个数组，里面存放着file,预览图片，对这里的file们做处理就是啦。
```
 function  LocalURL(file) {
            var url = null;
            if (window.createObjectURL != undefined) { 
                url = window.createObjectURL(file);
            } else if (window.URL != undefined) {
                url = window.URL.createObjectURL(file);
            } else if (window.webkitURL != undefined) { 
                url = window.webkitURL.createObjectURL(file);
            }
            return url;//     eg:     blob:http://localhost/671c3409-0047-44ec-bcba-89d63a439231
   }
```

### 取消上传
他的上传其实也就是jQuery的ajax。取消上传的关键是要保留下上传的handler。 
即：
```
$this.fileupload({options})
.bind('fileuploadadd', function (e, data) {

    $('#uploadBtn').click(function () {
        jqXHR = data.submit();
    })

    $('#cancelBtn').click(function () {
        jqXHR.abort();
    })
}) 
```
这时候要考虑响应错误信息。 
该插件无论是请求超时还是手动取消上传（jqXHR.abort()）都会响应fileuploadfail，但是可以通过data.errorThrown的值加以区分
```
$this.fileupload({options})
.bind('fileuploadfail', function (e, data) {
      if (data.errorThrown=='abort') {
             NUI.showMsg('上传取消！', 'success',3);
         }else{
             NUI.showMsg('上传失败，请稍后重试！', 'error',3);
         }
})
```

### 设置请求头
参考 [jquery-file-upload 在Header中增加header项](http://blog.csdn.net/zhouyingge1104/article/details/38316127)
- 我尝试了在options对象里添加自定义属性accessToken，并在jquery.fileupload.js里对_initXHRData函数做了进一步加工
	```
	$this.fileupload({
	     url: url,
	     autoUpload: false,
	     acceptFileTypes: /(.|\/)(jpe?g|png)$/i,
	     maxNumberOfFiles: 1,
	     maxFileSize: 5000000,
	     sequentialUploads: true,
	     accessToken:$.cookie('access_token'),
	  })
	 _initXHRData: function (options) {

	    ···
	    if (options.contentRange) {
	       options.headers['Content-Range'] = options.contentRange;

	    //我添加的代码···
	    if (options.accessToken) {
	        options.headers['Access-Token'] = options.accessToken;
	    };
	    ···

	}
	```
- 直接在options里添加属性headers，不过没有成功。我跟了很多遍源码，但依然没找到失败的原因，反而觉得这样不失为最完美的解决方法···如果哪位高人洞悉其中奥秘，还请不吝赐教。
```
	$this.fileupload({
	     url: url,
	     autoUpload: false,
	     acceptFileTypes: /(.|\/)(jpe?g|png)$/i,
	     maxNumberOfFiles: 1,
	     maxFileSize: 5000000,
	     sequentialUploads: true,
	     headers:{
	         'Access-Token':$.cookie('access_token')
	     }
	  })
	```
- 参考[Jquery-File-Upload在IE9中不发送请求头](https://stackoverflow.com/questions/22165996/jquery-file-upload-not-sending-headers-in-ie9)，我从他的问题里看到了他的解决方法，并且我成功设置了请求头。（金星完美.jpg)。
	```
	$this.fileupload({
	        url: url,
	        autoUpload: false,
	        acceptFileTypes: /(.|\/)(jpe?g|png)$/i,
	        maxNumberOfFiles: 1,
	        maxFileSize: 5000000,
	        sequentialUploads: true,
	        beforeSend: function ( xhr ) {
	          xhr.setRequestHeader('Access-Token', $.cookie('access_token'));
	       },    
	    })
	```