ALTER TABLE [dbo].[t_s_log] ALTER COLUMN [username] nvarchar(50) COLLATE Chinese_PRC_CI_AS 
GO


CREATE INDEX [index_group_url_type] ON [dbo].[t_s_function]
([functionurl] ASC, [functiontype] ASC) 
GO
update [dbo].[cgform_head] set sub_table_str = null where id = '4028b881535b12bd01535b1ae3680001';


CREATE TABLE [dbo].[jeecg_demo_excel] (
[id] nvarchar(36) NOT NULL ,
[name] nvarchar(100) NULL ,
[sex] nvarchar(3) NULL ,
[birthday] datetime2(7) NULL ,
[depart] nvarchar(36) NULL ,
[fd_replace] nvarchar(255) NULL ,
[fd_convert] nvarchar(255) NULL 
)


GO
IF ((SELECT COUNT(*) from fn_listextendedproperty('MS_Description', 
'SCHEMA', N'dbo', 
'TABLE', N'jeecg_demo_excel', 
NULL, NULL)) > 0) 
EXEC sp_updateextendedproperty @name = N'MS_Description', @value = N'excel导入导出示例'
, @level0type = 'SCHEMA', @level0name = N'dbo'
, @level1type = 'TABLE', @level1name = N'jeecg_demo_excel'
ELSE
EXEC sp_addextendedproperty @name = N'MS_Description', @value = N'excel导入导出示例'
, @level0type = 'SCHEMA', @level0name = N'dbo'
, @level1type = 'TABLE', @level1name = N'jeecg_demo_excel'
GO
IF ((SELECT COUNT(*) from fn_listextendedproperty('MS_Description', 
'SCHEMA', N'dbo', 
'TABLE', N'jeecg_demo_excel', 
'COLUMN', N'id')) > 0) 
EXEC sp_updateextendedproperty @name = N'MS_Description', @value = N'id'
, @level0type = 'SCHEMA', @level0name = N'dbo'
, @level1type = 'TABLE', @level1name = N'jeecg_demo_excel'
, @level2type = 'COLUMN', @level2name = N'id'
ELSE
EXEC sp_addextendedproperty @name = N'MS_Description', @value = N'id'
, @level0type = 'SCHEMA', @level0name = N'dbo'
, @level1type = 'TABLE', @level1name = N'jeecg_demo_excel'
, @level2type = 'COLUMN', @level2name = N'id'
GO
IF ((SELECT COUNT(*) from fn_listextendedproperty('MS_Description', 
'SCHEMA', N'dbo', 
'TABLE', N'jeecg_demo_excel', 
'COLUMN', N'name')) > 0) 
EXEC sp_updateextendedproperty @name = N'MS_Description', @value = N'姓名'
, @level0type = 'SCHEMA', @level0name = N'dbo'
, @level1type = 'TABLE', @level1name = N'jeecg_demo_excel'
, @level2type = 'COLUMN', @level2name = N'name'
ELSE
EXEC sp_addextendedproperty @name = N'MS_Description', @value = N'姓名'
, @level0type = 'SCHEMA', @level0name = N'dbo'
, @level1type = 'TABLE', @level1name = N'jeecg_demo_excel'
, @level2type = 'COLUMN', @level2name = N'name'
GO
IF ((SELECT COUNT(*) from fn_listextendedproperty('MS_Description', 
'SCHEMA', N'dbo', 
'TABLE', N'jeecg_demo_excel', 
'COLUMN', N'sex')) > 0) 
EXEC sp_updateextendedproperty @name = N'MS_Description', @value = N'性别'
, @level0type = 'SCHEMA', @level0name = N'dbo'
, @level1type = 'TABLE', @level1name = N'jeecg_demo_excel'
, @level2type = 'COLUMN', @level2name = N'sex'
ELSE
EXEC sp_addextendedproperty @name = N'MS_Description', @value = N'性别'
, @level0type = 'SCHEMA', @level0name = N'dbo'
, @level1type = 'TABLE', @level1name = N'jeecg_demo_excel'
, @level2type = 'COLUMN', @level2name = N'sex'
GO
IF ((SELECT COUNT(*) from fn_listextendedproperty('MS_Description', 
'SCHEMA', N'dbo', 
'TABLE', N'jeecg_demo_excel', 
'COLUMN', N'birthday')) > 0) 
EXEC sp_updateextendedproperty @name = N'MS_Description', @value = N'生日'
, @level0type = 'SCHEMA', @level0name = N'dbo'
, @level1type = 'TABLE', @level1name = N'jeecg_demo_excel'
, @level2type = 'COLUMN', @level2name = N'birthday'
ELSE
EXEC sp_addextendedproperty @name = N'MS_Description', @value = N'生日'
, @level0type = 'SCHEMA', @level0name = N'dbo'
, @level1type = 'TABLE', @level1name = N'jeecg_demo_excel'
, @level2type = 'COLUMN', @level2name = N'birthday'
GO
IF ((SELECT COUNT(*) from fn_listextendedproperty('MS_Description', 
'SCHEMA', N'dbo', 
'TABLE', N'jeecg_demo_excel', 
'COLUMN', N'depart')) > 0) 
EXEC sp_updateextendedproperty @name = N'MS_Description', @value = N'关联部门'
, @level0type = 'SCHEMA', @level0name = N'dbo'
, @level1type = 'TABLE', @level1name = N'jeecg_demo_excel'
, @level2type = 'COLUMN', @level2name = N'depart'
ELSE
EXEC sp_addextendedproperty @name = N'MS_Description', @value = N'关联部门'
, @level0type = 'SCHEMA', @level0name = N'dbo'
, @level1type = 'TABLE', @level1name = N'jeecg_demo_excel'
, @level2type = 'COLUMN', @level2name = N'depart'
GO
IF ((SELECT COUNT(*) from fn_listextendedproperty('MS_Description', 
'SCHEMA', N'dbo', 
'TABLE', N'jeecg_demo_excel', 
'COLUMN', N'fd_replace')) > 0) 
EXEC sp_updateextendedproperty @name = N'MS_Description', @value = N'测试替换'
, @level0type = 'SCHEMA', @level0name = N'dbo'
, @level1type = 'TABLE', @level1name = N'jeecg_demo_excel'
, @level2type = 'COLUMN', @level2name = N'fd_replace'
ELSE
EXEC sp_addextendedproperty @name = N'MS_Description', @value = N'测试替换'
, @level0type = 'SCHEMA', @level0name = N'dbo'
, @level1type = 'TABLE', @level1name = N'jeecg_demo_excel'
, @level2type = 'COLUMN', @level2name = N'fd_replace'
GO
IF ((SELECT COUNT(*) from fn_listextendedproperty('MS_Description', 
'SCHEMA', N'dbo', 
'TABLE', N'jeecg_demo_excel', 
'COLUMN', N'fd_convert')) > 0) 
EXEC sp_updateextendedproperty @name = N'MS_Description', @value = N'测试转换'
, @level0type = 'SCHEMA', @level0name = N'dbo'
, @level1type = 'TABLE', @level1name = N'jeecg_demo_excel'
, @level2type = 'COLUMN', @level2name = N'fd_convert'
ELSE
EXEC sp_addextendedproperty @name = N'MS_Description', @value = N'测试转换'
, @level0type = 'SCHEMA', @level0name = N'dbo'
, @level1type = 'TABLE', @level1name = N'jeecg_demo_excel'
, @level2type = 'COLUMN', @level2name = N'fd_convert'
GO

ALTER TABLE [dbo].[jeecg_demo_excel] ADD PRIMARY KEY ([id])
GO

-- ----------------------------
-- Records of jeecg_demo_excel
-- ----------------------------
INSERT INTO [dbo].[jeecg_demo_excel] ([id], [name], [sex], [birthday], [depart], [fd_replace], [fd_convert]) VALUES (N'4028f6816402f8e30164032b767c0001', N'威震天', N'0', N'2014-06-10 00:00:00.0000000', N'402880e447e99cf10147e9a03b320003', N'1', N'200')
GO
GO
INSERT INTO [dbo].[jeecg_demo_excel] ([id], [name], [sex], [birthday], [depart], [fd_replace], [fd_convert]) VALUES (N'4028f6816402f8e30164032c00ab0005', N'白居易', N'0', N'2014-06-10 00:00:00.0000000', N'402880e447e9a9570147e9b677320003', N'1', N'600')
GO
GO
INSERT INTO [dbo].[jeecg_demo_excel] ([id], [name], [sex], [birthday], [depart], [fd_replace], [fd_convert]) VALUES (N'4028f6816402f8e30164032d7d010007', N'刘诗诗', N'1', N'1993-06-01 00:00:00.0000000', N'8a8ab0b246dc81120146dc8180bd0018', N'0', N'1000')
GO
GO

INSERT INTO [dbo].[t_s_function] ([ID], [functioniframe], [functionlevel], [functionname], [functionorder], [functionurl], [parentfunctionid], [iconid], [desk_iconid], [functiontype], [function_icon_style], [create_by], [create_name], [update_by], [update_date], [create_date], [update_name]) VALUES (N'402881f263dd1d8f0163de06421c0067', NULL, '1', N'下拉列表控件', N'36', N'jeecgFormDemoController.do?dropDownDatagrid', N'4028f6815af3ce54015af3d1ad610001', N'8a8ab0b246dc81120146dc8180460000', N'8a8ab0b246dc81120146dc8180dd001e', '0', N'fa-angle-down', N'admin', N'管理员', N'admin', '2018-06-28 11:05:22.0000000', '2018-06-08 14:12:22.0000000', N'管理员');

INSERT INTO [dbo].[t_s_function] ([ID], [functioniframe], [functionlevel], [functionname], [functionorder], [functionurl], [parentfunctionid], [iconid], [desk_iconid], [functiontype], [function_icon_style], [create_by], [create_name], [update_by], [update_date], [create_date], [update_name]) VALUES (N'4028f6816402785c0164027969d20001', NULL, '1', N'excel导入导出示例', N'99', N'jeecgDemoExcelController.do?list', N'4028f6815af3ce54015af3d1ad610001', N'8a8ab0b246dc81120146dc8180460000', N'8a8ab0b246dc81120146dc8180dd001e', '0', N'fa-arrows-v', N'admin', N'管理员', N'admin', '2018-06-28 10:57:42.0000000', '2018-06-15 16:04:28.0000000', N'管理员');
INSERT INTO [dbo].[t_s_muti_lang] ([id], [lang_key], [lang_context], [lang_code], [create_date], [create_by], [create_name], [update_date], [update_by], [update_name]) VALUES (N'402881026416bfa8016416c774de0001', N'common.range1to50', N'类型范围在1~50位字符', N'zh-cn', '2018-06-19 14:42:08.0000000', N'admin', N'管理员', NULL, NULL, NULL);
INSERT INTO [dbo].[t_s_muti_lang] ([id], [lang_key], [lang_context], [lang_code], [create_date], [create_by], [create_name], [update_date], [update_by], [update_name]) VALUES (N'402881026416bfa8016416c82a160003', N'common.range1to50', N'The type in the range of 1~50 characters', N'en', '2018-06-19 14:42:54.0000000', N'admin', N'管理员', NULL, NULL, NULL);
INSERT INTO [dbo].[t_s_muti_lang] ([id], [lang_key], [lang_context], [lang_code], [create_date], [create_by], [create_name], [update_date], [update_by], [update_name]) VALUES (N'402881026416bfa8016416cb5fc20005', N'common.range1to10', N'类型编码在1~10位字符', N'zh-cn', '2018-06-19 14:46:24.0000000', N'admin', N'管理员', NULL, NULL, NULL);
INSERT INTO [dbo].[t_s_muti_lang] ([id], [lang_key], [lang_context], [lang_code], [create_date], [create_by], [create_name], [update_date], [update_by], [update_name]) VALUES (N'402881026416bfa8016416cb9ed60007', N'common.range1to10', N'The type in the range of 1~10 characters', N'en', '2018-06-19 14:46:41.0000000', N'admin', N'管理员', NULL, NULL, NULL);

ALTER TABLE [dbo].[t_s_type]
ADD [order_num] int NULL 
GO
IF ((SELECT COUNT(*) from fn_listextendedproperty('MS_Description', 
'SCHEMA', N'dbo', 
'TABLE', N't_s_type', 
'COLUMN', N'order_num')) > 0) 
EXEC sp_updateextendedproperty @name = N'MS_Description', @value = N'序号'
, @level0type = 'SCHEMA', @level0name = N'dbo'
, @level1type = 'TABLE', @level1name = N't_s_type'
, @level2type = 'COLUMN', @level2name = N'order_num'
ELSE
EXEC sp_addextendedproperty @name = N'MS_Description', @value = N'序号'
, @level0type = 'SCHEMA', @level0name = N'dbo'
, @level1type = 'TABLE', @level1name = N't_s_type'
, @level2type = 'COLUMN', @level2name = N'order_num'
GO


INSERT INTO [dbo].[t_s_muti_lang] ([id], [lang_key], [lang_context], [lang_code], [create_date], [create_by], [create_name], [update_date], [update_by], [update_name]) VALUES (N'4028f681641bf52b01641c2802030009', N'dict.order', N'序号', N'zh-cn', '2018-06-20 15:45:41.0000000', N'admin', N'管理员', NULL, NULL, NULL);
INSERT INTO [dbo].[t_s_muti_lang] ([id], [lang_key], [lang_context], [lang_code], [create_date], [create_by], [create_name], [update_date], [update_by], [update_name]) VALUES (N'4028f681641bf52b01641c28c724000b', N'dict.order', N'Serial number', N'en', '2018-06-20 15:46:31.0000000', N'admin', N'管理员', NULL, NULL, NULL);

INSERT INTO [dbo].[t_s_function] ([ID], [functioniframe], [functionlevel], [functionname], [functionorder], [functionurl], [parentfunctionid], [iconid], [desk_iconid], [functiontype], [function_icon_style], [create_by], [create_name], [update_by], [update_date], [create_date], [update_name]) VALUES (N'4028f681643b2e6401643b3aeba50001', NULL, '1', N'按钮折叠demo', N'99', N'jeecgListDemoController.do?collapseDemo', N'4028f6815af3ce54015af3d1ad610001', N'8a8ab0b246dc81120146dc8180460000', N'8a8ab0b246dc81120146dc8180dd001e', '0', N'fa-arrow-circle-down', N'admin', N'管理员', N'admin', '2018-06-28 11:05:51.0000000', '2018-06-26 16:34:34.0000000', N'管理员');

ALTER TABLE [dbo].[t_s_operation]
ADD [processnode_id] nvarchar(32) COLLATE Chinese_PRC_CI_AS NULL 
GO
IF ((SELECT COUNT(*) from fn_listextendedproperty('MS_Description', 
'SCHEMA', N'dbo', 
'TABLE', N't_s_operation', 
'COLUMN', N'processnode_id')) > 0) 
EXEC sp_updateextendedproperty @name = N'MS_Description', @value = N'流程节点id'
, @level0type = 'SCHEMA', @level0name = N'dbo'
, @level1type = 'TABLE', @level1name = N't_s_operation'
, @level2type = 'COLUMN', @level2name = N'processnode_id'
ELSE
EXEC sp_addextendedproperty @name = N'MS_Description', @value = N'流程节点id'
, @level0type = 'SCHEMA', @level0name = N'dbo'
, @level1type = 'TABLE', @level1name = N't_s_operation'
, @level2type = 'COLUMN', @level2name = N'processnode_id'
GO


UPDATE TOP(1) [dbo].[t_s_function] SET [ID]=N'402881f263dd1d8f0163de06421c0067', [functioniframe]=NULL, [functionlevel]='1', [functionname]=N'下拉列表控件', [functionorder]=N'36', [functionurl]=N'jeecgFormDemoController.do?dropDownDatagrid', [parentfunctionid]=N'4028f6815af3ce54015af3d1ad610001', [iconid]=N'8a8ab0b246dc81120146dc8180460000', [desk_iconid]=N'8a8ab0b246dc81120146dc8180dd001e', [functiontype]='0', [function_icon_style]=N'fa-angle-down', [create_by]=N'admin', [create_name]=N'管理员', [update_by]=N'admin', [update_date]='2018-06-28 11:05:22.0000000', [create_date]='2018-06-08 14:12:22.0000000', [update_name]=N'管理员' WHERE ([ID]=N'402881f263dd1d8f0163de06421c0067');
UPDATE TOP(1) [dbo].[t_s_function] SET [ID]=N'4028f6816402785c0164027969d20001', [functioniframe]=NULL, [functionlevel]='1', [functionname]=N'excel导入导出示例', [functionorder]=N'99', [functionurl]=N'jeecgDemoExcelController.do?list', [parentfunctionid]=N'4028f6815af3ce54015af3d1ad610001', [iconid]=N'8a8ab0b246dc81120146dc8180460000', [desk_iconid]=N'8a8ab0b246dc81120146dc8180dd001e', [functiontype]='0', [function_icon_style]=N'fa-arrows-v', [create_by]=N'admin', [create_name]=N'管理员', [update_by]=N'admin', [update_date]='2018-06-28 10:57:42.0000000', [create_date]='2018-06-15 16:04:28.0000000', [update_name]=N'管理员' WHERE ([ID]=N'4028f6816402785c0164027969d20001');
UPDATE TOP(1) [dbo].[t_s_function] SET [ID]=N'4028f681643b2e6401643b3aeba50001', [functioniframe]=NULL, [functionlevel]='1', [functionname]=N'按钮折叠demo', [functionorder]=N'99', [functionurl]=N'jeecgListDemoController.do?collapseDemo', [parentfunctionid]=N'4028f6815af3ce54015af3d1ad610001', [iconid]=N'8a8ab0b246dc81120146dc8180460000', [desk_iconid]=N'8a8ab0b246dc81120146dc8180dd001e', [functiontype]='0', [function_icon_style]=N'fa-arrow-circle-down', [create_by]=N'admin', [create_name]=N'管理员', [update_by]=N'admin', [update_date]='2018-06-28 11:05:51.0000000', [create_date]='2018-06-26 16:34:34.0000000', [update_name]=N'管理员' WHERE ([ID]=N'4028f681643b2e6401643b3aeba50001');



INSERT INTO [dbo].[t_s_muti_lang] ([id], [lang_key], [lang_context], [lang_code], [create_date], [create_by], [create_name], [update_date], [update_by], [update_name]) VALUES (N'4028918164456ce001644580c16e0007', N'common.user.interfaceUser', N'接口用户不允许登录', N'zh-cn', '2018-06-28 16:27:03.0000000', N'admin', N'管理员', NULL, NULL, NULL);
INSERT INTO [dbo].[t_s_muti_lang] ([id], [lang_key], [lang_context], [lang_code], [create_date], [create_by], [create_name], [update_date], [update_by], [update_name]) VALUES (N'4028918164456ce00164458189cf0009', N'common.user.interfaceUser', N'Interface user does not allow login', N'en', '2018-06-28 16:27:55.0000000', N'admin', N'管理员', NULL, NULL, NULL);

update [dbo].[cgform_ftl] set FTL_CONTENT = REPLACE(FTL_CONTENT, '/curdtools_zh-cn.js', '/curdtools.js');
update [dbo].[cgform_ftl] set FTL_CONTENT = REPLACE(FTL_CONTENT, '/jquery-1.8.3.js"></script>', '/jquery-1.8.3.js"></script><script type="text/javascript" src="plug-in/jquery-plugs/i18n/jquery.i18n.properties.js"></script>');

ALTER TABLE [dbo].[t_s_sms_template]
ADD [template_code] nvarchar(32) COLLATE Chinese_PRC_CI_AS NULL 
GO
IF ((SELECT COUNT(*) from fn_listextendedproperty('MS_Description', 
'SCHEMA', N'dbo', 
'TABLE', N't_s_sms_template', 
'COLUMN', N'template_code')) > 0) 
EXEC sp_updateextendedproperty @name = N'MS_Description', @value = N'模板CODE'
, @level0type = 'SCHEMA', @level0name = N'dbo'
, @level1type = 'TABLE', @level1name = N't_s_sms_template'
, @level2type = 'COLUMN', @level2name = N'template_code'
ELSE
EXEC sp_addextendedproperty @name = N'MS_Description', @value = N'模板CODE'
, @level0type = 'SCHEMA', @level0name = N'dbo'
, @level1type = 'TABLE', @level1name = N't_s_sms_template'
, @level2type = 'COLUMN', @level2name = N'template_code'
GO

CREATE UNIQUE INDEX [uniq_templatecode] ON [dbo].[t_s_sms_template]
([template_code] ASC) 
WITH (IGNORE_DUP_KEY = ON)
GO

ALTER TABLE [dbo].[t_s_sms_template]
ADD [template_test_json] nvarchar(1000) COLLATE Chinese_PRC_CI_AS NULL 
GO
IF ((SELECT COUNT(*) from fn_listextendedproperty('MS_Description', 
'SCHEMA', N'dbo', 
'TABLE', N't_s_sms_template', 
'COLUMN', N'template_test_json')) > 0) 
EXEC sp_updateextendedproperty @name = N'MS_Description', @value = N'模板测试json'
, @level0type = 'SCHEMA', @level0name = N'dbo'
, @level1type = 'TABLE', @level1name = N't_s_sms_template'
, @level2type = 'COLUMN', @level2name = N'template_test_json'
ELSE
EXEC sp_addextendedproperty @name = N'MS_Description', @value = N'模板测试json'
, @level0type = 'SCHEMA', @level0name = N'dbo'
, @level1type = 'TABLE', @level1name = N't_s_sms_template'
, @level2type = 'COLUMN', @level2name = N'template_test_json'
GO

ALTER TABLE [dbo].[t_s_sms]
ADD [is_read] smallint NOT NULL DEFAULT 0 
GO

IF ((SELECT COUNT(*) from fn_listextendedproperty('MS_Description', 
'SCHEMA', N'dbo', 
'TABLE', N't_s_sms', 
'COLUMN', N'is_read')) > 0) 
EXEC sp_updateextendedproperty @name = N'MS_Description', @value = N'是否已阅读'
, @level0type = 'SCHEMA', @level0name = N'dbo'
, @level1type = 'TABLE', @level1name = N't_s_sms'
, @level2type = 'COLUMN', @level2name = N'is_read'
ELSE
EXEC sp_addextendedproperty @name = N'MS_Description', @value = N'是否已阅读'
, @level0type = 'SCHEMA', @level0name = N'dbo'
, @level1type = 'TABLE', @level1name = N't_s_sms'
, @level2type = 'COLUMN', @level2name = N'is_read'
GO


INSERT INTO [dbo].[t_s_muti_lang] ([id], [lang_key], [lang_context], [lang_code], [create_date], [create_by], [create_name], [update_date], [update_by], [update_name]) VALUES (N'40286081646932eb01646935152c0005', N'common.templateCode', N'模板CODE', N'zh-cn', '2018-07-05 14:50:43.0000000', N'admin', N'管理员', NULL, NULL, NULL);
INSERT INTO [dbo].[t_s_muti_lang] ([id], [lang_key], [lang_context], [lang_code], [create_date], [create_by], [create_name], [update_date], [update_by], [update_name]) VALUES (N'40286081646932eb01646935698d0007', N'common.templateCode', N'Template Code', N'en', '2018-07-05 14:51:05.0000000', N'admin', N'管理员', NULL, NULL, NULL);
INSERT INTO [dbo].[t_s_muti_lang] ([id], [lang_key], [lang_context], [lang_code], [create_date], [create_by], [create_name], [update_date], [update_by], [update_name]) VALUES (N'402860816469f4aa01646a2da0cc0026', N'common.isRead', N'状态', N'zh-cn', '2018-07-05 19:22:12.0000000', N'admin', N'管理员', NULL, NULL, NULL);
INSERT INTO [dbo].[t_s_muti_lang] ([id], [lang_key], [lang_context], [lang_code], [create_date], [create_by], [create_name], [update_date], [update_by], [update_name]) VALUES (N'402860816469f4aa01646a2dcf1c0028', N'common.isRead', N'Status', N'en', '2018-07-05 19:22:24.0000000', N'admin', N'管理员', NULL, NULL, NULL);


INSERT INTO [dbo].[t_s_sms_template] ([id], [template_type], [template_code], [template_name], [template_content], [template_test_json], [create_date], [create_by], [create_name], [update_date], [update_by], [update_name]) VALUES (N'4028608164691b000164693108140003', N'3', N'SYS001', N'催办：${taskName}', N'${userName}，您好！
请前待办任务办理事项！${taskName}


===========================
此消息由系统发出', N'{
"taskName":"HR审批",
"userName":"admin"
}', '2018-07-05 14:46:18.0000000', N'admin', N'管理员', '2018-07-05 18:31:34.0000000', N'admin', N'管理员');


INSERT INTO [dbo].[t_s_type] ([ID], [typecode], [typename], [typepid], [typegroupid], [create_date], [create_name], [order_num]) VALUES (N'4028608164691b00016469289a040001', N'3', N'系统提醒模板', NULL, N'8a71b40e4a38319b014a3858fca40018', '2018-07-05 14:37:05.0000000', N'管理员', '3');

INSERT INTO [dbo].[t_s_function] ([ID], [functioniframe], [functionlevel], [functionname], [functionorder], [functionurl], [parentfunctionid], [iconid], [desk_iconid], [functiontype], [function_icon_style], [create_by], [create_name], [update_by], [update_date], [create_date], [update_name]) VALUES (N'40289181647d9d4a01647daaa4ce0001', NULL, '1', N'表单原生组件二', N'4', N'jeecgFormDemoController.do?natures', N'4028f6815af3ce54015af3d1ad610001', N'8a8ab0b246dc81120146dc8180460000', N'8a8ab0b246dc81120146dc8180dd001e', '0', N'fa-code', N'admin', N'管理员', N'admin', '2018-07-09 18:29:31.0000000', '2018-07-09 14:11:33.0000000', N'管理员');

CREATE TABLE [dbo].[t_s_dict_table_config] (
[id] nvarchar(36) NOT NULL ,
[table_name] nvarchar(100) NULL ,
[value_col] nvarchar(50) NULL ,
[text_col] nvarchar(50) NULL ,
[dict_condition] nvarchar(255) NULL ,
[isvalid] nvarchar(32) NULL ,
[create_name] nvarchar(50) NULL ,
[create_by] nvarchar(50) NULL ,
[create_date] datetime2(7) NULL ,
[update_name] nvarchar(50) NULL ,
[update_by] nvarchar(50) NULL ,
[update_date] datetime2(7) NULL ,
[sys_org_code] nvarchar(50) NULL ,
[sys_company_code] nvarchar(50) NULL 
)


GO
IF ((SELECT COUNT(*) from fn_listextendedproperty('MS_Description', 
'SCHEMA', N'dbo', 
'TABLE', N't_s_dict_table_config', 
NULL, NULL)) > 0) 
EXEC sp_updateextendedproperty @name = N'MS_Description', @value = N'字典表授权配置'
, @level0type = 'SCHEMA', @level0name = N'dbo'
, @level1type = 'TABLE', @level1name = N't_s_dict_table_config'
ELSE
EXEC sp_addextendedproperty @name = N'MS_Description', @value = N'字典表授权配置'
, @level0type = 'SCHEMA', @level0name = N'dbo'
, @level1type = 'TABLE', @level1name = N't_s_dict_table_config'
GO
IF ((SELECT COUNT(*) from fn_listextendedproperty('MS_Description', 
'SCHEMA', N'dbo', 
'TABLE', N't_s_dict_table_config', 
'COLUMN', N'table_name')) > 0) 
EXEC sp_updateextendedproperty @name = N'MS_Description', @value = N'表名'
, @level0type = 'SCHEMA', @level0name = N'dbo'
, @level1type = 'TABLE', @level1name = N't_s_dict_table_config'
, @level2type = 'COLUMN', @level2name = N'table_name'
ELSE
EXEC sp_addextendedproperty @name = N'MS_Description', @value = N'表名'
, @level0type = 'SCHEMA', @level0name = N'dbo'
, @level1type = 'TABLE', @level1name = N't_s_dict_table_config'
, @level2type = 'COLUMN', @level2name = N'table_name'
GO
IF ((SELECT COUNT(*) from fn_listextendedproperty('MS_Description', 
'SCHEMA', N'dbo', 
'TABLE', N't_s_dict_table_config', 
'COLUMN', N'value_col')) > 0) 
EXEC sp_updateextendedproperty @name = N'MS_Description', @value = N'值字段名'
, @level0type = 'SCHEMA', @level0name = N'dbo'
, @level1type = 'TABLE', @level1name = N't_s_dict_table_config'
, @level2type = 'COLUMN', @level2name = N'value_col'
ELSE
EXEC sp_addextendedproperty @name = N'MS_Description', @value = N'值字段名'
, @level0type = 'SCHEMA', @level0name = N'dbo'
, @level1type = 'TABLE', @level1name = N't_s_dict_table_config'
, @level2type = 'COLUMN', @level2name = N'value_col'
GO
IF ((SELECT COUNT(*) from fn_listextendedproperty('MS_Description', 
'SCHEMA', N'dbo', 
'TABLE', N't_s_dict_table_config', 
'COLUMN', N'text_col')) > 0) 
EXEC sp_updateextendedproperty @name = N'MS_Description', @value = N'文本字段名'
, @level0type = 'SCHEMA', @level0name = N'dbo'
, @level1type = 'TABLE', @level1name = N't_s_dict_table_config'
, @level2type = 'COLUMN', @level2name = N'text_col'
ELSE
EXEC sp_addextendedproperty @name = N'MS_Description', @value = N'文本字段名'
, @level0type = 'SCHEMA', @level0name = N'dbo'
, @level1type = 'TABLE', @level1name = N't_s_dict_table_config'
, @level2type = 'COLUMN', @level2name = N'text_col'
GO
IF ((SELECT COUNT(*) from fn_listextendedproperty('MS_Description', 
'SCHEMA', N'dbo', 
'TABLE', N't_s_dict_table_config', 
'COLUMN', N'dict_condition')) > 0) 
EXEC sp_updateextendedproperty @name = N'MS_Description', @value = N'字典表查询条件'
, @level0type = 'SCHEMA', @level0name = N'dbo'
, @level1type = 'TABLE', @level1name = N't_s_dict_table_config'
, @level2type = 'COLUMN', @level2name = N'dict_condition'
ELSE
EXEC sp_addextendedproperty @name = N'MS_Description', @value = N'字典表查询条件'
, @level0type = 'SCHEMA', @level0name = N'dbo'
, @level1type = 'TABLE', @level1name = N't_s_dict_table_config'
, @level2type = 'COLUMN', @level2name = N'dict_condition'
GO
IF ((SELECT COUNT(*) from fn_listextendedproperty('MS_Description', 
'SCHEMA', N'dbo', 
'TABLE', N't_s_dict_table_config', 
'COLUMN', N'isvalid')) > 0) 
EXEC sp_updateextendedproperty @name = N'MS_Description', @value = N'是否启用'
, @level0type = 'SCHEMA', @level0name = N'dbo'
, @level1type = 'TABLE', @level1name = N't_s_dict_table_config'
, @level2type = 'COLUMN', @level2name = N'isvalid'
ELSE
EXEC sp_addextendedproperty @name = N'MS_Description', @value = N'是否启用'
, @level0type = 'SCHEMA', @level0name = N'dbo'
, @level1type = 'TABLE', @level1name = N't_s_dict_table_config'
, @level2type = 'COLUMN', @level2name = N'isvalid'
GO
IF ((SELECT COUNT(*) from fn_listextendedproperty('MS_Description', 
'SCHEMA', N'dbo', 
'TABLE', N't_s_dict_table_config', 
'COLUMN', N'create_name')) > 0) 
EXEC sp_updateextendedproperty @name = N'MS_Description', @value = N'创建人名称'
, @level0type = 'SCHEMA', @level0name = N'dbo'
, @level1type = 'TABLE', @level1name = N't_s_dict_table_config'
, @level2type = 'COLUMN', @level2name = N'create_name'
ELSE
EXEC sp_addextendedproperty @name = N'MS_Description', @value = N'创建人名称'
, @level0type = 'SCHEMA', @level0name = N'dbo'
, @level1type = 'TABLE', @level1name = N't_s_dict_table_config'
, @level2type = 'COLUMN', @level2name = N'create_name'
GO
IF ((SELECT COUNT(*) from fn_listextendedproperty('MS_Description', 
'SCHEMA', N'dbo', 
'TABLE', N't_s_dict_table_config', 
'COLUMN', N'create_by')) > 0) 
EXEC sp_updateextendedproperty @name = N'MS_Description', @value = N'创建人登录名称'
, @level0type = 'SCHEMA', @level0name = N'dbo'
, @level1type = 'TABLE', @level1name = N't_s_dict_table_config'
, @level2type = 'COLUMN', @level2name = N'create_by'
ELSE
EXEC sp_addextendedproperty @name = N'MS_Description', @value = N'创建人登录名称'
, @level0type = 'SCHEMA', @level0name = N'dbo'
, @level1type = 'TABLE', @level1name = N't_s_dict_table_config'
, @level2type = 'COLUMN', @level2name = N'create_by'
GO
IF ((SELECT COUNT(*) from fn_listextendedproperty('MS_Description', 
'SCHEMA', N'dbo', 
'TABLE', N't_s_dict_table_config', 
'COLUMN', N'create_date')) > 0) 
EXEC sp_updateextendedproperty @name = N'MS_Description', @value = N'创建日期'
, @level0type = 'SCHEMA', @level0name = N'dbo'
, @level1type = 'TABLE', @level1name = N't_s_dict_table_config'
, @level2type = 'COLUMN', @level2name = N'create_date'
ELSE
EXEC sp_addextendedproperty @name = N'MS_Description', @value = N'创建日期'
, @level0type = 'SCHEMA', @level0name = N'dbo'
, @level1type = 'TABLE', @level1name = N't_s_dict_table_config'
, @level2type = 'COLUMN', @level2name = N'create_date'
GO
IF ((SELECT COUNT(*) from fn_listextendedproperty('MS_Description', 
'SCHEMA', N'dbo', 
'TABLE', N't_s_dict_table_config', 
'COLUMN', N'update_name')) > 0) 
EXEC sp_updateextendedproperty @name = N'MS_Description', @value = N'更新人名称'
, @level0type = 'SCHEMA', @level0name = N'dbo'
, @level1type = 'TABLE', @level1name = N't_s_dict_table_config'
, @level2type = 'COLUMN', @level2name = N'update_name'
ELSE
EXEC sp_addextendedproperty @name = N'MS_Description', @value = N'更新人名称'
, @level0type = 'SCHEMA', @level0name = N'dbo'
, @level1type = 'TABLE', @level1name = N't_s_dict_table_config'
, @level2type = 'COLUMN', @level2name = N'update_name'
GO
IF ((SELECT COUNT(*) from fn_listextendedproperty('MS_Description', 
'SCHEMA', N'dbo', 
'TABLE', N't_s_dict_table_config', 
'COLUMN', N'update_by')) > 0) 
EXEC sp_updateextendedproperty @name = N'MS_Description', @value = N'更新人登录名称'
, @level0type = 'SCHEMA', @level0name = N'dbo'
, @level1type = 'TABLE', @level1name = N't_s_dict_table_config'
, @level2type = 'COLUMN', @level2name = N'update_by'
ELSE
EXEC sp_addextendedproperty @name = N'MS_Description', @value = N'更新人登录名称'
, @level0type = 'SCHEMA', @level0name = N'dbo'
, @level1type = 'TABLE', @level1name = N't_s_dict_table_config'
, @level2type = 'COLUMN', @level2name = N'update_by'
GO
IF ((SELECT COUNT(*) from fn_listextendedproperty('MS_Description', 
'SCHEMA', N'dbo', 
'TABLE', N't_s_dict_table_config', 
'COLUMN', N'update_date')) > 0) 
EXEC sp_updateextendedproperty @name = N'MS_Description', @value = N'更新日期'
, @level0type = 'SCHEMA', @level0name = N'dbo'
, @level1type = 'TABLE', @level1name = N't_s_dict_table_config'
, @level2type = 'COLUMN', @level2name = N'update_date'
ELSE
EXEC sp_addextendedproperty @name = N'MS_Description', @value = N'更新日期'
, @level0type = 'SCHEMA', @level0name = N'dbo'
, @level1type = 'TABLE', @level1name = N't_s_dict_table_config'
, @level2type = 'COLUMN', @level2name = N'update_date'
GO
IF ((SELECT COUNT(*) from fn_listextendedproperty('MS_Description', 
'SCHEMA', N'dbo', 
'TABLE', N't_s_dict_table_config', 
'COLUMN', N'sys_org_code')) > 0) 
EXEC sp_updateextendedproperty @name = N'MS_Description', @value = N'所属部门'
, @level0type = 'SCHEMA', @level0name = N'dbo'
, @level1type = 'TABLE', @level1name = N't_s_dict_table_config'
, @level2type = 'COLUMN', @level2name = N'sys_org_code'
ELSE
EXEC sp_addextendedproperty @name = N'MS_Description', @value = N'所属部门'
, @level0type = 'SCHEMA', @level0name = N'dbo'
, @level1type = 'TABLE', @level1name = N't_s_dict_table_config'
, @level2type = 'COLUMN', @level2name = N'sys_org_code'
GO
IF ((SELECT COUNT(*) from fn_listextendedproperty('MS_Description', 
'SCHEMA', N'dbo', 
'TABLE', N't_s_dict_table_config', 
'COLUMN', N'sys_company_code')) > 0) 
EXEC sp_updateextendedproperty @name = N'MS_Description', @value = N'所属公司'
, @level0type = 'SCHEMA', @level0name = N'dbo'
, @level1type = 'TABLE', @level1name = N't_s_dict_table_config'
, @level2type = 'COLUMN', @level2name = N'sys_company_code'
ELSE
EXEC sp_addextendedproperty @name = N'MS_Description', @value = N'所属公司'
, @level0type = 'SCHEMA', @level0name = N'dbo'
, @level1type = 'TABLE', @level1name = N't_s_dict_table_config'
, @level2type = 'COLUMN', @level2name = N'sys_company_code'
GO

-- ----------------------------
-- Indexes structure for table t_s_dict_table_config
-- ----------------------------
CREATE UNIQUE INDEX [uniq_tablename_valuecol_textcol] ON [dbo].[t_s_dict_table_config]
([table_name] ASC, [value_col] ASC, [text_col] ASC) 
WITH (IGNORE_DUP_KEY = ON, STATISTICS_NORECOMPUTE = ON)
GO

-- ----------------------------
-- Primary Key structure for table t_s_dict_table_config
-- ----------------------------
ALTER TABLE [dbo].[t_s_dict_table_config] ADD PRIMARY KEY ([id])
GO


INSERT INTO [dbo].[t_s_function] ([ID], [functioniframe], [functionlevel], [functionname], [functionorder], [functionurl], [parentfunctionid], [iconid], [desk_iconid], [functiontype], [function_icon_style], [create_by], [create_name], [update_by], [update_date], [create_date], [update_name]) VALUES (N'40286081648332f8016483352acf0001', NULL, '1', N'字典表授权配置', N'7', N'tSDictTableConfigController.do?list', N'8a8ab0b246dc81120146dc8180d2001a', N'8a8ab0b246dc81120146dc8180460000', N'8a8ab0b246dc81120146dc8180dd001e', '0', N'', N'admin', N'管理员', N'admin', '2018-07-10 16:01:17.0000000', '2018-07-10 16:00:57.0000000', N'管理员');

update [dbo].[t_s_muti_lang] set lang_context = '3.7.7' where lang_key ='system.version.number';

