

## 开发手册
1. 添加选项卡

```
//前提。在main.js中声明全局变量
var tab;

//因为iframe 获取父容器的变量
var t =  {url: "/article/showArticle", icon: "", title: "文章管理", id: "966"}
parent.tab.tabAdd(t)
```
2. 获取当前登录用户

 CurrentUser currentUser = Principal.getCurrentUse();
 
 ```
 <@shiro.lacksRole name="admin">
    没有admin权限
 </@shiro.lacksRole>
 <@shiro.hasRole name="admin">
    有admin权限
 </@shiro.hasRole>
 ```
 
 