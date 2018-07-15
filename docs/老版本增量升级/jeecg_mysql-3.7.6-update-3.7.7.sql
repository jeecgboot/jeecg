ALTER TABLE `t_s_log`
MODIFY COLUMN `username`  varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '用户账号' AFTER `userid`;
INSERT INTO `t_s_function` (`ID`, `functioniframe`, `functionlevel`, `functionname`, `functionorder`, `functionurl`, `parentfunctionid`, `iconid`, `desk_iconid`, `functiontype`, `function_icon_style`, `create_by`, `create_name`, `update_by`, `update_date`, `create_date`, `update_name`) VALUES ('402881f263dd1d8f0163de06421c0067', NULL, '1', '下拉列表控件', '36', 'jeecgFormDemoController.do?dropDownDatagrid', '4028f6815af3ce54015af3d1ad610001', '8a8ab0b246dc81120146dc8180460000', '8a8ab0b246dc81120146dc8180dd001e', '0', '', 'admin', '管理员', 'admin', '2018-06-08 19:56:47', '2018-06-08 14:12:22', '管理员');
INSERT INTO `t_s_role_function` (`ID`, `operation`, `functionid`, `roleid`, `datarule`) VALUES ('402881f263dd1d8f0163de0660e70069', NULL, '402881f263dd1d8f0163de06421c0067', '8a8ab0b246dc81120146dc8181870050', NULL);
ALTER TABLE `t_s_function`
ADD INDEX `index_group_url_type` (`functionurl`, `functiontype`);
update cgform_head set sub_table_str = null where id = '4028b881535b12bd01535b1ae3680001';
DROP TABLE IF EXISTS `jeecg_demo_excel`;
CREATE TABLE `jeecg_demo_excel` (
  `id` varchar(36) NOT NULL COMMENT 'id',
  `name` varchar(100) DEFAULT NULL COMMENT '姓名',
  `sex` varchar(3) DEFAULT NULL COMMENT '性别',
  `birthday` datetime DEFAULT NULL COMMENT '生日',
  `depart` varchar(36) DEFAULT NULL COMMENT '关联部门',
  `fd_replace` varchar(255) DEFAULT NULL COMMENT '测试替换',
  `fd_convert` varchar(255) DEFAULT NULL COMMENT '测试转换',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='excel导入导出示例';
INSERT INTO `t_s_function` (`ID`, `functioniframe`, `functionlevel`, `functionname`, `functionorder`, `functionurl`, `parentfunctionid`, `iconid`, `desk_iconid`, `functiontype`, `function_icon_style`, `create_by`, `create_name`, `update_by`, `update_date`, `create_date`, `update_name`) VALUES ('4028f6816402785c0164027969d20001', NULL, '1', 'excel导入导出示例', '99', 'jeecgDemoExcelController.do?list', '4028f6815af3ce54015af3d1ad610001', '8a8ab0b246dc81120146dc8180460000', '8a8ab0b246dc81120146dc8180dd001e', '0', '', 'admin', '管理员', NULL, NULL, '2018-06-15 16:04:28', NULL);
INSERT INTO `jeecg_demo_excel` (`id`, `name`, `sex`, `birthday`, `depart`, `fd_replace`, `fd_convert`) VALUES ('4028f6816402f8e30164032b767c0001', '威震天', '0', '2014-06-10 00:00:00', '402880e447e99cf10147e9a03b320003', '1', '200');
INSERT INTO `jeecg_demo_excel` (`id`, `name`, `sex`, `birthday`, `depart`, `fd_replace`, `fd_convert`) VALUES ('4028f6816402f8e30164032c00ab0005', '白居易', '0', '2014-06-10 00:00:00', '402880e447e9a9570147e9b677320003', '1', '600');
INSERT INTO `jeecg_demo_excel` (`id`, `name`, `sex`, `birthday`, `depart`, `fd_replace`, `fd_convert`) VALUES ('4028f6816402f8e30164032d7d010007', '刘诗诗', '1', '1993-06-01 00:00:00', '8a8ab0b246dc81120146dc8180bd0018', '0', '1000');
INSERT INTO `t_s_muti_lang`(`id`, `lang_key`, `lang_context`, `lang_code`, `create_date`, `create_by`, `create_name`, `update_date`, `update_by`, `update_name`) VALUES ('402881026416bfa8016416cb9ed60007', 'common.range1to10', 'The type in the range of 1~10 characters', 'en', '2018-06-19 14:46:41', 'admin', '管理员', NULL, NULL, NULL);
INSERT INTO `t_s_muti_lang`(`id`, `lang_key`, `lang_context`, `lang_code`, `create_date`, `create_by`, `create_name`, `update_date`, `update_by`, `update_name`) VALUES ('402881026416bfa8016416cb5fc20005', 'common.range1to10', '类型编码在1~10位字符', 'zh-cn', '2018-06-19 14:46:24', 'admin', '管理员', NULL, NULL, NULL);
INSERT INTO `t_s_muti_lang`(`id`, `lang_key`, `lang_context`, `lang_code`, `create_date`, `create_by`, `create_name`, `update_date`, `update_by`, `update_name`) VALUES ('402881026416bfa8016416c82a160003', 'common.range1to50', 'The type in the range of 1~50 characters', 'en', '2018-06-19 14:42:54', 'admin', '管理员', NULL, NULL, NULL);
INSERT INTO `t_s_muti_lang`(`id`, `lang_key`, `lang_context`, `lang_code`, `create_date`, `create_by`, `create_name`, `update_date`, `update_by`, `update_name`) VALUES ('402881026416bfa8016416c774de0001', 'common.range1to50', '类型范围在1~50位字符', 'zh-cn', '2018-06-19 14:42:08', 'admin', '管理员', NULL, NULL, NULL);
ALTER TABLE `t_s_type`
ADD COLUMN `order_num`  int(3) NULL COMMENT '序号' AFTER `create_name`;
INSERT INTO `t_s_muti_lang` (`id`, `lang_key`, `lang_context`, `lang_code`, `create_date`, `create_by`, `create_name`, `update_date`, `update_by`, `update_name`) VALUES ('4028f681641bf52b01641c28c724000b', 'dict.order', 'Serial number', 'en', '2018-06-20 15:46:31', 'admin', '管理员', NULL, NULL, NULL);
INSERT INTO `t_s_muti_lang` (`id`, `lang_key`, `lang_context`, `lang_code`, `create_date`, `create_by`, `create_name`, `update_date`, `update_by`, `update_name`) VALUES ('4028f681641bf52b01641c2802030009', 'dict.order', '序号', 'zh-cn', '2018-06-20 15:45:41', 'admin', '管理员', NULL, NULL, NULL);
INSERT INTO `t_s_function` (`ID`, `functioniframe`, `functionlevel`, `functionname`, `functionorder`, `functionurl`, `parentfunctionid`, `iconid`, `desk_iconid`, `functiontype`, `function_icon_style`, `create_by`, `create_name`, `update_by`, `update_date`, `create_date`, `update_name`) VALUES ('4028f681643b2e6401643b3aeba50001', NULL, '1', '按钮折叠demo', '99', 'jeecgListDemoController.do?collapseDemo', '4028f6815af3ce54015af3d1ad610001', '8a8ab0b246dc81120146dc8180460000', '8a8ab0b246dc81120146dc8180dd001e', '0', '', 'admin', '管理员', NULL, NULL, '2018-06-26 16:34:34', NULL);
ALTER TABLE `t_s_operation`
ADD COLUMN `processnode_id`  varchar(32)  NULL DEFAULT NULL COMMENT '流程节点id' AFTER `operationtype`;
UPDATE `t_s_function` SET `ID`='402881f263dd1d8f0163de06421c0067', `functioniframe`=NULL, `functionlevel`='1', `functionname`='下拉列表控件', `functionorder`='36', `functionurl`='jeecgFormDemoController.do?dropDownDatagrid', `parentfunctionid`='4028f6815af3ce54015af3d1ad610001', `iconid`='8a8ab0b246dc81120146dc8180460000', `desk_iconid`='8a8ab0b246dc81120146dc8180dd001e', `functiontype`='0', `function_icon_style`='fa-angle-down', `create_by`='admin', `create_name`='管理员', `update_by`='admin', `update_date`='2018-06-28 11:05:22', `create_date`='2018-06-08 14:12:22', `update_name`='管理员' WHERE (`ID`='402881f263dd1d8f0163de06421c0067');
UPDATE `t_s_function` SET `ID`='4028f6816402785c0164027969d20001', `functioniframe`=NULL, `functionlevel`='1', `functionname`='excel导入导出示例', `functionorder`='99', `functionurl`='jeecgDemoExcelController.do?list', `parentfunctionid`='4028f6815af3ce54015af3d1ad610001', `iconid`='8a8ab0b246dc81120146dc8180460000', `desk_iconid`='8a8ab0b246dc81120146dc8180dd001e', `functiontype`='0', `function_icon_style`='fa-arrows-v', `create_by`='admin', `create_name`='管理员', `update_by`='admin', `update_date`='2018-06-28 10:57:42', `create_date`='2018-06-15 16:04:28', `update_name`='管理员' WHERE (`ID`='4028f6816402785c0164027969d20001');
UPDATE `t_s_function` SET `ID`='4028f681643b2e6401643b3aeba50001', `functioniframe`=NULL, `functionlevel`='1', `functionname`='按钮折叠demo', `functionorder`='99', `functionurl`='jeecgListDemoController.do?collapseDemo', `parentfunctionid`='4028f6815af3ce54015af3d1ad610001', `iconid`='8a8ab0b246dc81120146dc8180460000', `desk_iconid`='8a8ab0b246dc81120146dc8180dd001e', `functiontype`='0', `function_icon_style`='fa-arrow-circle-down', `create_by`='admin', `create_name`='管理员', `update_by`='admin', `update_date`='2018-06-28 11:05:51', `create_date`='2018-06-26 16:34:34', `update_name`='管理员' WHERE (`ID`='4028f681643b2e6401643b3aeba50001');
INSERT INTO `t_s_muti_lang` (`id`, `lang_key`, `lang_context`, `lang_code`, `create_date`, `create_by`, `create_name`, `update_date`, `update_by`, `update_name`) VALUES ('4028918164456ce001644580c16e0007', 'common.user.interfaceUser', '接口用户不允许登录', 'zh-cn', '2018-06-28 16:27:03', 'admin', '管理员', NULL, NULL, NULL);
INSERT INTO `t_s_muti_lang` (`id`, `lang_key`, `lang_context`, `lang_code`, `create_date`, `create_by`, `create_name`, `update_date`, `update_by`, `update_name`) VALUES ('4028918164456ce00164458189cf0009', 'common.user.interfaceUser', 'Interface user does not allow login', 'en', '2018-06-28 16:27:55', 'admin', '管理员', NULL, NULL, NULL);
update cgform_ftl set FTL_CONTENT = REPLACE(FTL_CONTENT, '/curdtools_zh-cn.js', '/curdtools.js');
update cgform_ftl set FTL_CONTENT = REPLACE(FTL_CONTENT, '/jquery-1.8.3.js"></script>', '/jquery-1.8.3.js"></script><script type="text/javascript" src="plug-in/jquery-plugs/i18n/jquery.i18n.properties.js"></script>');
ALTER TABLE `t_s_sms_template`
ADD COLUMN `template_code`  varchar(32) NULL COMMENT '模板CODE' AFTER `template_type`;
ALTER TABLE `t_s_sms_template`
ADD UNIQUE INDEX `uniq_templatecode` (`template_code`);
ALTER TABLE `t_s_sms_template`
ADD COLUMN `template_test_json`  varchar(1000) NULL COMMENT '模板测试json' AFTER `template_content`;
ALTER TABLE `t_s_sms`
ADD COLUMN `is_read`  smallint(2) NOT NULL DEFAULT 0 COMMENT '是否已阅读' AFTER `es_status`;
INSERT INTO `t_s_muti_lang` (`id`, `lang_key`, `lang_context`, `lang_code`, `create_date`, `create_by`, `create_name`, `update_date`, `update_by`, `update_name`) VALUES ('40286081646932eb01646935152c0005', 'common.templateCode', '模板CODE', 'zh-cn', '2018-07-05 14:50:43', 'admin', '管理员', NULL, NULL, NULL);
INSERT INTO `t_s_muti_lang` (`id`, `lang_key`, `lang_context`, `lang_code`, `create_date`, `create_by`, `create_name`, `update_date`, `update_by`, `update_name`) VALUES ('40286081646932eb01646935698d0007', 'common.templateCode', 'Template Code', 'en', '2018-07-05 14:51:05', 'admin', '管理员', NULL, NULL, NULL);
INSERT INTO `t_s_muti_lang` (`id`, `lang_key`, `lang_context`, `lang_code`, `create_date`, `create_by`, `create_name`, `update_date`, `update_by`, `update_name`) VALUES ('402860816469f4aa01646a2da0cc0026', 'common.isRead', '状态', 'zh-cn', '2018-07-05 19:22:12', 'admin', '管理员', NULL, NULL, NULL);
INSERT INTO `t_s_muti_lang` (`id`, `lang_key`, `lang_context`, `lang_code`, `create_date`, `create_by`, `create_name`, `update_date`, `update_by`, `update_name`) VALUES ('402860816469f4aa01646a2dcf1c0028', 'common.isRead', 'Status', 'en', '2018-07-05 19:22:24', 'admin', '管理员', NULL, NULL, NULL);
INSERT INTO `t_s_sms_template` (`id`, `template_type`, `template_code`, `template_name`, `template_content`, `template_test_json`, `create_date`, `create_by`, `create_name`, `update_date`, `update_by`, `update_name`) VALUES ('4028608164691b000164693108140003', '3', 'SYS001', '催办：${taskName}', '${userName}，您好！\r\n请前待办任务办理事项！${taskName}\r\n\r\n\r\n===========================\r\n此消息由系统发出', '{\r\n\"taskName\":\"HR审批\",\r\n\"userName\":\"admin\"\r\n}', '2018-07-05 14:46:18', 'admin', '管理员', '2018-07-05 18:31:34', 'admin', '管理员');
INSERT INTO `t_s_type` (`ID`, `typecode`, `typename`, `typepid`, `typegroupid`, `create_date`, `create_name`, `order_num`) VALUES ('4028608164691b00016469289a040001', '3', '系统提醒模板', NULL, '8a71b40e4a38319b014a3858fca40018', '2018-07-05 14:37:05', '管理员', '3');
update t_s_muti_lang set lang_context = '3.7.7' where id in ('4028ef81533c078201533c08e2370003','4028ef81533c078201533c08b1ca0001');
INSERT INTO `t_s_function` (`ID`, `functioniframe`, `functionlevel`, `functionname`, `functionorder`, `functionurl`, `parentfunctionid`, `iconid`, `desk_iconid`, `functiontype`, `function_icon_style`, `create_by`, `create_name`, `update_by`, `update_date`, `create_date`, `update_name`) VALUES ('40289181647d9d4a01647daaa4ce0001', NULL, '1', '表单原生组件二', '4', 'jeecgFormDemoController.do?topjuiDemo', '4028f6815af3ce54015af3d1ad610001', '8a8ab0b246dc81120146dc8180460000', '8a8ab0b246dc81120146dc8180dd001e', '0', 'fa-code', 'admin', '管理员', 'admin', '2018-07-09 14:53:08', '2018-07-09 14:11:33', '管理员');
UPDATE `t_s_function` SET `ID`='40289181647d9d4a01647daaa4ce0001', `functioniframe`=NULL, `functionlevel`='1', `functionname`='表单原生组件二', `functionorder`='4', `functionurl`='jeecgFormDemoController.do?natures', `parentfunctionid`='4028f6815af3ce54015af3d1ad610001', `iconid`='8a8ab0b246dc81120146dc8180460000', `desk_iconid`='8a8ab0b246dc81120146dc8180dd001e', `functiontype`='0', `function_icon_style`='fa-code', `create_by`='admin', `create_name`='管理员', `update_by`='admin', `update_date`='2018-07-09 18:29:31', `create_date`='2018-07-09 14:11:33', `update_name`='管理员' WHERE (`ID`='40289181647d9d4a01647daaa4ce0001');
CREATE TABLE `t_s_dict_table_config` (
  `id` varchar(36) NOT NULL,
  `table_name` varchar(100) default NULL COMMENT '表名',
  `value_col` varchar(50) default NULL COMMENT '值字段名',
  `text_col` varchar(50) default NULL COMMENT '文本字段名',
  `dict_condition` varchar(255) default NULL COMMENT '字典表查询条件',
  `isvalid` varchar(32) default NULL COMMENT '是否启用',
  `create_name` varchar(50) default NULL COMMENT '创建人名称',
  `create_by` varchar(50) default NULL COMMENT '创建人登录名称',
  `create_date` datetime default NULL COMMENT '创建日期',
  `update_name` varchar(50) default NULL COMMENT '更新人名称',
  `update_by` varchar(50) default NULL COMMENT '更新人登录名称',
  `update_date` datetime default NULL COMMENT '更新日期',
  `sys_org_code` varchar(50) default NULL COMMENT '所属部门',
  `sys_company_code` varchar(50) default NULL COMMENT '所属公司',
  PRIMARY KEY  (`id`),
  UNIQUE KEY `uniq_tablename_valuecol_textcol` USING BTREE (`table_name`,`value_col`,`text_col`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='字典表授权配置';
INSERT INTO `t_s_function` (`ID`, `functioniframe`, `functionlevel`, `functionname`, `functionorder`, `functionurl`, `parentfunctionid`, `iconid`, `desk_iconid`, `functiontype`, `function_icon_style`, `create_by`, `create_name`, `update_by`, `update_date`, `create_date`, `update_name`) VALUES ('40286081648332f8016483352acf0001', NULL, '1', '字典表授权配置', '7', 'tSDictTableConfigController.do?list', '8a8ab0b246dc81120146dc8180d2001a', '8a8ab0b246dc81120146dc8180460000', '8a8ab0b246dc81120146dc8180dd001e', '0', '', 'admin', '管理员', 'admin', '2018-07-10 16:01:17', '2018-07-10 16:00:57', '管理员');
update t_s_muti_lang set lang_context = '3.7.7' where lang_key ='system.version.number';
