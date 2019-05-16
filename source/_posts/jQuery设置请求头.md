---
title: jQuery设置请求头
date: 2017-4-20 19:31:52
categories: 
tags: 
---
在项目中采用token来验证用户登录，运作机制大致如下:
1、用户首次登录成功时，server-end发送token到client，client存入cookie。
2、用户做任何请求操作时，在ajax的headers里带上token，用以server-end做登录状态验证。
这时问题就来了···
<!--more-->
请求：
```
 $.ajax({
          type: type,
          timeout: 10000, // 超时时间 10 秒
          headers: {
              'Access-Token':$.cookie('access_token')
          },
          url: url,
          data: data,
          success: function(data) {
          },
          error: function(err) {
          },
          complete: function(XMLHttpRequest, status) { //请求完成后最终执行参数　
          }
      })
```
报错：
```
Request header field Access-Token is not allowed by Access-Control-Allow-Headers in preflight response.
```
其中Access-Control-Allow-Headers 首部字段用于预检请求的响应。其指明了实际请求中允许携带的首部字段。
[参考MDN](https://developer.mozilla.org/zh-CN/docs/Web/HTTP/Access_control_CORS)
查阅了很多参考资料以及各位前辈踩坑记录，得到如下总结：
- 报错意思是请求头中的Access-Token字段在Access-Control-Allow-Headers中没有被设置为允许.

- 谁来设置？
	- 一种是font-end自己设置，在ajax在中设置beforeSend
	```
	$.ajax({
         type: type,
         timeout: 10000, 
         beforeSend: function(xhr) {
              xhr.setRequestHeader("Access-Toke");
         },
         headers: {
             'Access-Token':$.cookie('access_token')
         },
         url: url,
         data: data,
         success: function(data) {
         },
         error: function(err) {
         },
         complete: function(XMLHttpRequest, status) { //请求完成后最终执行参数　
         }
	});
	```
	- 第二种是server-end设置header参考[stackoverflow——>Request header field Access-Control-Allow-Headers is not allowed by Access-Control-Allow-Headers](https://stackoverflow.com/questions/25727306/request-header-field-access-control-allow-headers-is-not-allowed-by-access-contr)
	```
	public class SimpleCORSFilter implements Filter {

	    public void doFilter(ServletRequest req, ServletResponse res, FilterChain chain) throws IOException, ServletException {
	        HttpServletResponse response = (HttpServletResponse) res;
	        response.setHeader("Access-Control-Allow-Origin", "*");
	        response.setHeader("Access-Control-Allow-Methods", "POST, GET");
	        response.setHeader("Access-Control-Max-Age", "3600");
	        response.setHeader("Access-Control-Allow-Headers", "Content-Type, Access-Control-Allow-Headers, Authorization, Access-Toke");
	        chain.doFilter(req, res);
	    }

	    public void init(FilterConfig filterConfig) {}

	    public void destroy() {}

    }
	```