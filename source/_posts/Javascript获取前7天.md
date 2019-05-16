---
title: JavaScript获取前7天
date: 2017-02-07 22:06:04
categories: JavaScript
tags: [JavaScript,Tips]
---
在项目中需要获取前7天的数据，需要向后台传递startDate···吼吼，因此有此Tips
<!--more-->
```
function getStandardDate(){
    var _date=new Date();
    var year=_date.getFullYear();
    var month=_date.getMonth()+1;
    var day=_date.getDate();
    if (month<10) {
        month='0'+month;
    };
    if (day<10) {
        day='0'+day;
    };
    return year+'-'+month+'-'+day;
}

function getStandardDateBeforeWeek(){
    var _date = new Date(); //获取今天日期
        _date.setDate(_date.getDate() - 7);//日期回到七天前
    var year=_date.getFullYear();
    var month=_date.getMonth()+1;
    var day=_date.getDate();
    if (month<10) {
        month='0'+month;
    };
    if (day<10) {
        day='0'+day;
    };

    var dateTemp = year+'-'+month+'-'+day;
    _date.setDate(_date.getDate() + 7);//日期重置
    return dateTemp;
}

```