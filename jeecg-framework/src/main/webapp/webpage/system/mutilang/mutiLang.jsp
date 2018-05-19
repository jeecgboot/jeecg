<%@ page language="java" import="java.util.*" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/context/mytags.jsp"%>
<!DOCTYPE html>
<html>
 <head>
  <title><t:mutiLang langKey="lang.maintain"/></title>
  <t:base type="jquery,easyui,tools,DatePicker"></t:base>
 </head>
 <body style="overflow-y: hidden" scroll="no">
  <t:formvalid formid="formobj" dialog="true" usePlugin="password" layout="table" action="mutiLangController.do?save">
			<input id="id" name="id" type="hidden" value="${mutiLangPage.id }">
			<table style="width: 600px;" cellpadding="0" cellspacing="1" class="formtable">
				<tr>
					<td align="right">
						<label class="Validform_label">
							<t:mutiLang langKey="common.languagekey"/>:
						</label>
					</td>
					<td class="value">
						<input class="inputxt" id="langKey" name="langKey" value="${mutiLangPage.langKey}" datatype="*">
						<span class="Validform_checktip"></span>
					</td>
				</tr>
				<tr>
					<td align="right">
						<label class="Validform_label">
							<t:mutiLang langKey="common.content"/>:
						</label>
					</td>
					<td class="value">
						<input class="inputxt" id="langContext" name="langContext" value="${mutiLangPage.langContext}" datatype="*">
						<span class="Validform_checktip"></span>
					</td>
				</tr>
				<tr>
					<td align="right">
						<label class="Validform_label">
							<t:mutiLang langKey="common.language"/>:
						</label>
					</td>
					<td class="value">
						<t:dictSelect field="langCode" typeGroupCode="lang" hasLabel="false" defaultVal="${mutiLangPage.langCode}"></t:dictSelect>
						<span class="Validform_checktip"></span>
					</td>
				</tr>
			</table>
		</t:formvalid>
 </body>