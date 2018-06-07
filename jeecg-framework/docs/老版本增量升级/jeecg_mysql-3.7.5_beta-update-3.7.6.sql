update t_s_role set role_type=0 where role_type is null;
ALTER TABLE `jeecg_demo`
MODIFY COLUMN `content`  text CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '个人介绍' AFTER `birthday`;
INSERT INTO `t_s_function` (`ID`, `functioniframe`, `functionlevel`, `functionname`, `functionorder`, `functionurl`, `parentfunctionid`, `iconid`, `desk_iconid`, `functiontype`, `function_icon_style`, `create_by`, `create_name`, `update_by`, `update_date`, `create_date`, `update_name`) VALUES ('402881f463a591710163a5e59a830010', NULL, '2', '接口用户管理', '3', 'userController.do?interfaceUser', '402881fc60a07a350160a07cf68e0001', '8a8ab0b246dc81120146dc8180460000', '8a8ab0b246dc81120146dc8180dd001e', '0', '', 'admin', '管理员', NULL, NULL, '2018-05-28 16:37:58', NULL);
delete from t_s_black_list where ip in (select a.ip from (select ip from t_s_black_list GROUP BY ip HAVING COUNT(1) > 1) a )
and id not in  (select b.md from (select max(id) md from t_s_black_list GROUP BY ip HAVING COUNT(1) > 1) b );
ALTER TABLE `t_s_black_list`
ADD UNIQUE INDEX `unique_key_ip` (`ip`) ;
INSERT INTO `t_s_function` (`ID`, `functioniframe`, `functionlevel`, `functionname`, `functionorder`, `functionurl`, `parentfunctionid`, `iconid`, `desk_iconid`, `functiontype`, `function_icon_style`, `create_by`, `create_name`, `update_by`, `update_date`, `create_date`, `update_name`) VALUES ('4028f68163b5547e0163b55616930001', NULL, '1', '上传重构demo', '34', 'jeecgFormDemoController.do?webuploader', '4028f6815af3ce54015af3d1ad610001', '8a8ab0b246dc81120146dc8180460000', '8a8ab0b246dc81120146dc8180dd001e', '0', '', 'admin', '管理员', NULL, NULL, '2018-05-31 16:35:08', NULL);
INSERT INTO `t_s_function` (`ID`, `functioniframe`, `functionlevel`, `functionname`, `functionorder`, `functionurl`, `parentfunctionid`, `iconid`, `desk_iconid`, `functiontype`, `function_icon_style`, `create_by`, `create_name`, `update_by`, `update_date`, `create_date`, `update_name`) VALUES ('402881f463b56b950163b5aefcdb0002', NULL, '1', '自定义嵌套子表列表', '35', 'jfromOrderController.do?gridViewlist', '4028f6815af3ce54015af3d1ad610001', '8a8ab0b246dc81120146dc8180460000', '8a8ab0b246dc81120146dc8180dd001e', '0', '', 'admin', '管理员', NULL, NULL, '2018-05-31 18:12:14', NULL);
INSERT INTO `t_s_function` (`ID`, `functioniframe`, `functionlevel`, `functionname`, `functionorder`, `functionurl`, `parentfunctionid`, `iconid`, `desk_iconid`, `functiontype`, `function_icon_style`, `create_by`, `create_name`, `update_by`, `update_date`, `create_date`, `update_name`) VALUES ('402881f463b4e5d20163b4f9a81b0001', NULL, '1', 'Bootstrap布局报表', '34', 'jeecgListDemoController.do?bootStrapEchartsDemo', '8a8ab0b246dc81120146dc8180d4001b', '8a8ab0b246dc81120146dc8180460000', '8a8ab0b246dc81120146dc8180dd001e', '0', '', 'admin', '管理员', 'admin', '2018-05-31 19:48:06', '2018-05-31 14:54:10', '管理员');
update t_s_muti_lang  set  lang_context = ' ' where  lang_key ='common.please.select';
ALTER TABLE `jform_graphreport_head` 
DROP INDEX `index_code`,
ADD UNIQUE INDEX `index_code`(`code`);
update t_s_muti_lang set lang_context = '3.7.6' where lang_key ='system.version.number';
