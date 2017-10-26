JEECG 微云快速开发平台
===============

当前最新版本： 3.7.1（发布日期：20170918）

前言：
-----------------------------------
随着 WEB UI 框架 ( EasyUI/Jquery UI/Ext/DWZ) 等的逐渐成熟,系统界面逐渐实现统一化，代码生成器也可以生成统一规范的界面！
代码生成+手工MERGE半智能开发将是新的趋势，单表数据模型和一对多数据模型的增删改查功能直接生成使用,可节省60%工作量，快速提高开发效率！！！


简介
-----------------------------------
JEECG（J2EE Code Generation）是一款基于代码生成器的智能开发平台。引领新的开发模式(Online Coding->代码生成器->手工MERGE智能开发)，可以帮助解决Java项目60%的重复工作，让开发更多关注业务逻辑。既能快速提高开发效率，帮助公司节省人力成本，同时又不失灵活性。

JEECG宗旨是: 简单功能由代Online Coding配置出功能;复杂功能由代码生成器生成进行手工Merge; 复杂流程业务采用表单自定义，业务流程使用工作流来实现、扩展出任务接口，供开发编写业务逻辑。实现了流程任务节点和任务接口的灵活配置，既保证了公司流程的保密行，又减少了开发人员的工作量。

适用项目
-----------------------------------
JEECG快速开发平台，可以应用在任何J2EE项目的开发中，尤其适合企业信息管理系统（MIS）、内部办公系统（OA）、企业资源计划系统（ERP）、客户关系管理系统（CRM）等，其半智能手工Merge的开发方式，可以显著提高开发效率70%以上，极大降低开发成本；JEECG尤为显著的支持SAAS企业级应用开发，插件机制更好的支持了SAAS云应用需求。

为什么选择JEECG?
-----------------------------------
* 1.采用主流框架，容易上手; 代码生成器依赖性低,很方便的扩展能力，可完全实现二次开发;
* 2.开发效率很高,采用代码生成器，单表数据模型和一对多(父子表)数据模型，增删改查功能自动生成，菜单配置直接使用；
* 3.页面校验自动生成(必须输入、数字校验、金额校验、时间空间等);
* 4.封装完善的用户基础权限、强大的数据权限、和数据字典等基础功能，直接使用无需修改
* 5.常用共通封装，各种工具类(定时任务,短信接口,邮件发送,Excel导出等),基本满足80%项目需求
* 6.集成简易报表工具，图像报表和数据导出非常方便，可极其方便的生成pdf、excel、word等报表；
* 7.集成工作流activiti，并实现了只需在页面配置流程转向，可极大的简化jbpm工作流的开发；用jbpm的流程设计器画出了流程走向，一个工作流基本就完成了，只需写很少量的java代码；
* 8.UI标签库，针对WEB UI进行标准式封装，页面统一采用自定义标签实现功能：列表数据展现、页面校验等,标签使用简单清晰且便于维护
* 9.在线流程设计，采用开源Activiti流程引擎，实现在线画流程,自定义表单,表单挂靠,业务流转
* 10.查询过滤器：查询功能自动生成，后台动态拼SQL追加查询条件；支持多种匹配方式（全匹配/模糊查询/包含查询/不匹配查询）；
* 11.多数据源：及其简易的使用方式，在线配置数据源配置，便捷的从其他数据抓取数据；
* 12.国际化：支持多语言，开发国际化项目非常方便；
* 13.数据权限（精细化数据权限控制，控制到行级，列表级，表单字段级，实现不同人看不同数据，不同人对同一个页面操作不同字段
* 14.多种首页风格切换,支持自定义首页风格。（经典风格、Shortcut风格、ACE bootstrap风格、云桌面风格）
* 15.在线配置报表（无需编码，通过在线配置方式，实现曲线图，柱状图，数据等报表）
* 16.简易Excel导入导出，支持单表导出和一对多表模式导出，生成的代码自带导入导出功能
* 17.自定义表单，支持用户自定义表单布局，支持单表，一对多表单、支持select、radio、checkbox、textarea、date、popup、列表、宏等控件


JEECG 功能特点
-----------------------------------
* 	采用SpringMVC + Hibernate + Minidao(类Mybatis) + Easyui(UI库)+ Jquery + Boostrap + Ehcache + Redis + Ztree等基础架构</br>
* 	采用面向声明的开发模式， 基于泛型编写极少代码即可实现复杂的数据展示、数据编辑、
表单处理等功能，再配合Online Coding在线开发与代码生成器的使用,将J2EE的开发效率提高6倍以上，可以将代码减少80%以上。</br>

* 	JEECG 技术点总结:

* 	<b>技术点一：</b>Online Coding在线开发(通过在线配置实现一个表模型的增删改查功能，无需一行代码，支持用户自定义表单布局) </br>
* 	<b>技术点二：</b>代码生成器，支持多种数据模型,根据表生成对应的Entity,Service,Dao,Action,JSP等,增删改查功能生成直接使用</br>
* 	<b>技术点三：</b>UI快速开发库，针对WEB UI进行标准封装，页面统一采用UI标签实现功能：数据datagrid,表单校验,Popup,Tab等，实现JSP页面零JS，开发维护非常高效</br>
* 	<b>技术点四：</b>在线流程定义，采用开源Activiti流程引擎，实现在线画流程,自定义表单,表单挂接,业务流转，流程监控，流程跟踪，流程委托等</br>
* 	<b>技术点五：</b>自定义表单,支持用户自定义表单布局，支持单表、列表、Select\Radio\Checkbox\PopUP\Date等特殊控件</br>
* 	<b>技术点六：</b>查询过滤器：查询功能自动生成，后台动态拼SQL追加查询条件；支持多种匹配方式（全匹配/模糊查询/包含查询/不匹配查询）</br>
* 	<b>技术点七：</b>移动平台支持，对Bootstrap(兼容Html5)进行标准封装 </br>
* 	<b>技术点八：</b>动态报表功能（用户输入一个sql，系统自动解析生成报表）</br>
*   <b>技术点九：</b>数据权限（精细化数据权限控制，控制到行级，列表级，表单字段级，实现不同人看不同数据，不同人对同一个页面操作不同字段）</br>
*   <b>技术点十：</b>国际化（支持多语言，国际化的封装为多语言做了便捷支持）</br>
*   <b>技术点十一：</b>多数据源（在线配置数据源，数据源工作类封装）</br>
*   <b>技术点十二：</b>多种首页风格切换,支持自定义首页风格。（经典风格、Shortcut风格、ACE bootstrap风格、云桌面风格）</br>
*   <b>技术点十三：</b>在线配置报表（无需编码，通过在线配置方式，实现曲线图，柱状图，数据等报表）</br>
*   <b>技术点十四：</b>简易Excel导入导出，支持单表导出和一对多表模式导出，生成的代码自带导入导出功能</br>
*   <b>技术点十五：</b>移动OA，移动OA审批功能，采用H5技术，实现手机移动办公，无缝对接微信、钉钉、微信企业号、也可以做APP</br>
*   <b>技术点十六：</b>移动图表，在线配置移动报表，采用H5技术，可以手机端查看</br>
*   <b>技术点十七：</b>插件开发，业务功能组件以插件方式集成平台，也可以单独部署发发布，有力支撑了SAAS云应用系统需求</br>


* 	JEECG V3.7, 经过了专业压力测试,性能测试，保证后台数据的准确性和页面访问速度</br>
* 	支持多种浏览器: IE, 火狐, Google 等</br>
* 	支持数据库: Mysql,Oracle10g,Postgre,SqlServer等</br>
* 	基础权限: 用户，角色，菜单权限，按钮权限，数据权限</br>
* 	智能报表集成: 简易的图像报表工具和Excel导入导出</br>
* 	Web容器测试通过的有Jetty和Tomcat6,Weblogic</br>
* 	即将推出功能：分布式部署，云平台，移动平台开发，规则引擎</br>
* 	要求JDK1.6+</br>


技术文档
-----------------------------------
* [JEECG_3.7新版开发工具](http://blog.csdn.net/zhangdaiscott/article/details/78072438)
* [JEECG 开发环境搭建入门](http://blog.csdn.net/zhangdaiscott/article/details/50915206)
* [JEECG maven本地仓库下载](http://git.oschina.net/jeecg/jeecg-local-maven)
* [JEECG 开发手册](http://git.oschina.net/jeecg/jeecg/attach_files)
* [JEECG 常见问题贴](http://www.jeecg.org/forum.php?mod=viewthread&tid=1830&extra=page%3D1)
* [JEECG 视频教程](http://www.jeecg.org/forum.php?mod=viewthread&tid=197&extra=page%3D1)
* [JEECG 官方百度网盘](https://pan.baidu.com/share/home?uk=2668473880#category/type=0)
* [JEECG 版本更新日志](http://www.jeecg.org/forum.php?mod=viewthread&tid=365&extra=page%3D1)
* JEECG官方Maven镜像配置 : [http://t.cn/RJCp7wO](http://t.cn/RJCp7wO)
* 在线演示地址：[http://demo.jeecg.org](http://demo.jeecg.org)
* JEECG 3.7.1 版本(非maven-myeclipse)	链接：http://pan.baidu.com/s/1kVMKWuF 密码：b8kf
    
技术交流
-----------------------------------
* 	QQ交流群： ⑤293658367、③289782002、②106838471(满)、①106259349(满)、④176031980(满)</br>
* 	官方论坛： [http://www.jeecg.org](http://www.jeecg.org)
* 	官方网站： [http://www.guojusoft.com](http://www.guojusoft.com)
* 	官方博客： [http://blog.csdn.net/zhangdaiscott](http://blog.csdn.net/zhangdaiscott)
* 	技术支持： [JEECG社区官方支持QQ群汇总](http://www.jeecg.org/forum.php?mod=viewthread&tid=1249&extra=page%3D1)



JEECG云插件中心
-----------------------------------
* JEECG从V_3.6.3版本开始，采用插件开发模式，JEECG走简化轻量级路线，后续升级和功能模块，采用插件开发模式，进行集成。
* 更多插件下载地址：[http://yun.jeecg.org/](http://yun.jeecg.org)
![github](http://img.blog.csdn.net/20160623162220022?watermark/2/text/aHR0cDovL2Jsb2cuY3Nkbi5uZXQv/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70/gravity/Center "jeecg")



社区荣誉
-----------------------------------
* 开源社区：http://www.jeecg.org

* ★2012年JEECG在Google Code上开源;
* ★2012年底开源项目JEECG被"ITeye专家访谈";
* ★2012年底开源项目JEECG被"CSDN专家访谈";
* ★2013年应邀参加"第八届开源中国开源世界高峰论坛"（该论坛由中国开源软件推进联盟主办、全球最大中文IT社区CSDN与程序员杂志协办）；
* ★2013年应邀参加"开源群英会2013”的开源英雄;
* ★2013年度中国优秀开源项目评选-公开投票,“JEECG以887票位居第九"（该项目中国开源软件推进联盟主办、全球最大中文IT社区CSDN与程序员杂志协办）；
* ★2013年度成立JEECG开源团队，创立JEECG开源社区;
* ★2013年度JEECG参加“云计算成就创业梦想”第二届阿里云开发者大赛";
* ★2013年度应邀参加了"SDCC 2013中国软件开发者大会" （大会由CSDN和《程序员》杂志倾力打造）
* ★2013年下半年推出开源项目"MiniDao(持久层解决方案）"超越了Mybatis和Hibernate；
* ★2014年5月应邀参加中国科学院大学创新创业年度论坛，探讨“创业企业发展、创新创业孵化”的主题，成为中国科学院大学创新创业和风险投资协会副会长。
* ★2014年推出当前最火的开源项目“JeeWx(捷微:敏捷微信开发平台）”，并获得CSDN举办的“2014年开发者大会”公开投票第一名
* ★2014年8月份捷微jeewx2.0与百度达成战略合作，集成百度地图，增加地图功能，附近商家团购等信息搜索。
* ★2014年12月份捷微jeewx与联通集团达成战略合作，负责联通集团微信公众账号集团化运营。
* ★2015年3月份捷微jeewx推出集团化微信运营版本，专注微信应用一体化，企业系统集成，实现公众账号上下级，类似组织机构权限模式。
* ★2015年6月份捷微jeewx推出集企业号版本，与中国移动打成战略合作，推出企业号营销新模式。
* ★2015开源中国最火开源项目,TOP5独占2位(jeewx\jeecg),TOP50占4位（jeewx\jeecg\easypoi\jeewx-api) 
* ★2016年2月JEECG推出移动能力版本，在线配置移动报表，在线配置移动表单，微信OA一体化集成
* ★2016年3月JEECG插件开发机制，采用插件方式为用户提供插件服务，目前插件：OA、微信企业号、文档云盘
* ★2016年4月捷微H5活动平台与微盟达成战略合作伙伴

系统演示
-----------------------------------
###  [1].多套首页风格，支持自定义（Bootstrap风格|云桌面风格|经典风格|Shortcut风格等）
![github](http://img.blog.csdn.net/20160428121122932?watermark/2/text/aHR0cDovL2Jsb2cuY3Nkbi5uZXQv/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70/gravity/Center "jeecg")
![github](http://img.blog.csdn.net/20150607214324659?watermark/2/text/aHR0cDovL2Jsb2cuY3Nkbi5uZXQvemhhbmdkYWlzY290dA==/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70/gravity/Center "jeecg")
![github](http://img.blog.csdn.net/20150607214353113?watermark/2/text/aHR0cDovL2Jsb2cuY3Nkbi5uZXQvemhhbmdkYWlzY290dA==/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70/gravity/Center "jeecg")

###  [2].表单自定义设计效果
![github](http://www.jeecg.org/data/attachment/forum/201512/17/175056vgzo2j2thph29jdp.jpg "jeecg")
![github](http://www.jeecg.org/data/attachment/forum/201512/17/175135xq9fwiun3pi6i4e6.jpg "jeecg")
![github](http://www.jeecg.org/data/attachment/forum/201512/17/175152r6eg2f15g58jzzej.png "jeecg")
![github](http://www.jeecg.org/data/attachment/forum/201512/17/175103v1r87337prnfr1du.jpg "jeecg")

###  [3].报表演示
![github](http://img.blog.csdn.net/20150607222027195?watermark/2/text/aHR0cDovL2Jsb2cuY3Nkbi5uZXQvemhhbmdkYWlzY290dA==/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70/gravity/Center "jeecg")
![github](http://img.blog.csdn.net/20150607214724128?watermark/2/text/aHR0cDovL2Jsb2cuY3Nkbi5uZXQvemhhbmdkYWlzY290dA==/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70/gravity/Center "jeecg")
![github](http://img.blog.csdn.net/20150607221941932?watermark/2/text/aHR0cDovL2Jsb2cuY3Nkbi5uZXQvemhhbmdkYWlzY290dA==/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70/gravity/Center "jeecg")
![github](http://img.blog.csdn.net/20150607214807402?watermark/2/text/aHR0cDovL2Jsb2cuY3Nkbi5uZXQvemhhbmdkYWlzY290dA==/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70/gravity/Center "jeecg")

###  [4].移动报表演示
![github](http://img.blog.csdn.net/20160304140805046?watermark/2/text/aHR0cDovL2Jsb2cuY3Nkbi5uZXQv/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70/gravity/Center "jeecg")
![github](http://img.blog.csdn.net/20160304140809176?watermark/2/text/aHR0cDovL2Jsb2cuY3Nkbi5uZXQv/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70/gravity/Center "jeecg")
![github](http://img.blog.csdn.net/20160304140812389?watermark/2/text/aHR0cDovL2Jsb2cuY3Nkbi5uZXQv/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70/gravity/Center "jeecg")
![github](http://img.blog.csdn.net/20160304140820202?watermark/2/text/aHR0cDovL2Jsb2cuY3Nkbi5uZXQv/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70/gravity/Center "jeecg")
![github](http://img.blog.csdn.net/20160304140823843?watermark/2/text/aHR0cDovL2Jsb2cuY3Nkbi5uZXQv/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70/gravity/Center "jeecg")

###  [5].流程组件演示
![github](http://www.jeecg.org/data/attachment/forum/201303/02/123311mf9fa22tv69b228f.jpg "jeecg")
![github](http://www.jeecg.org/data/attachment/forum/201303/02/123412x003euegeg7nb68z.jpg "jeecg")
![github](http://www.jeecg.org/data/attachment/forum/201303/02/124748gyhrgvr45vshyc82.jpg "jeecg")
![github](http://www.jeecg.org/data/attachment/forum/201303/02/123428ubcjjnuwjbkjrnrw.jpg "jeecg")
![github](http://www.jeecg.org/data/attachment/forum/201303/02/124749up2j5id7gj9kppp8.jpg "jeecg")

###  [6].移动OA演示
![github](http://img.blog.csdn.net/20160303175110494?watermark/2/text/aHR0cDovL2Jsb2cuY3Nkbi5uZXQv/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70/gravity/Center "jeecg")
![github](http://img.blog.csdn.net/20160303175124104?watermark/2/text/aHR0cDovL2Jsb2cuY3Nkbi5uZXQv/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70/gravity/Center "jeecg")
![github](http://img.blog.csdn.net/20160303175134698?watermark/2/text/aHR0cDovL2Jsb2cuY3Nkbi5uZXQv/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70/gravity/Center "jeecg")
![github](http://img.blog.csdn.net/20160303175138713?watermark/2/text/aHR0cDovL2Jsb2cuY3Nkbi5uZXQv/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70/gravity/Center "jeecg")
![github](http://img.blog.csdn.net/20160303175149042?watermark/2/text/aHR0cDovL2Jsb2cuY3Nkbi5uZXQv/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70/gravity/Center "jeecg")

###  [6].移动APP
![github](http://img.blog.csdn.net/20170727143703234?watermark/2/text/aHR0cDovL2Jsb2cuY3Nkbi5uZXQvemhhbmdkYWlzY290dA==/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70/gravity/Center "jeecg")
![github](http://img.blog.csdn.net/20170727143710317?watermark/2/text/aHR0cDovL2Jsb2cuY3Nkbi5uZXQvemhhbmdkYWlzY290dA==/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70/gravity/Center "jeecg")
![github](http://img.blog.csdn.net/20170727143717031?watermark/2/text/aHR0cDovL2Jsb2cuY3Nkbi5uZXQvemhhbmdkYWlzY290dA==/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70/gravity/Center "jeecg")
![github](http://img.blog.csdn.net/20170727143722008?watermark/2/text/aHR0cDovL2Jsb2cuY3Nkbi5uZXQvemhhbmdkYWlzY290dA==/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70/gravity/Center "jeecg")
![github](http://img.blog.csdn.net/20170727143727421?watermark/2/text/aHR0cDovL2Jsb2cuY3Nkbi5uZXQvemhhbmdkYWlzY290dA==/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70/gravity/Center "jeecg")


代码示例
-----------------------------------
    这是一个有多行的文本框  
    <%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
    <%@include file="/context/mytags.jsp"%>
    <div class="easyui-layout" fit="true">
    <div region="center" style="padding:1px;">
    <t:dategrid name="jeecgDemoList" title="开发DEMO列表" actionUrl="jeecgDemoController.do?datagrid" idField="id" fit="true">
    <t:dgCol title="编号" field="id" hidden="false"></t:dgCol>
    <t:dgCol title="用户名" field="userName" query="true"></t:dgCol>
    <t:dgCol title="电话号码" sortable="false" field="mobilePhone" width="20" query="true"></t:dgCol>
    <t:dgCol title="办公电话" field="officePhone"></t:dgCol>
    <t:dgCol title="邮箱" field="email"></t:dgCol>
    <t:dgCol title="年龄" sortable="true" field="age"></t:dgCol>
    <t:dgCol title="工资"  field="sex"></t:dgCol>
    <t:dgCol title="性别"  field="salary"></t:dgCol>
    <t:dgCol title="生日" field="birthday" formatter="yyyy/MM/dd"></t:dgCol>
    <t:dgCol title="创建日期" field="createTime" formatter="yyyy-MM-dd hh:mm:ss"></t:dgCol>
    <t:dgCol title="操作" field="opt" width="100"></t:dgCol>
    <t:dgFunOpt funname="szqm(id)" title="审核" />
    <t:dgDelOpt title="删除" url="jeecgDemoController.do?del&id={id}" />
    <t:dgToolBar title="录入" icon="icon-add"></t:dgToolBar>
    <t:dgToolBar title="编辑" icon="icon-edit"></t:dgToolBar>
    </t:dategrid>
    </div>
    </div>
    
