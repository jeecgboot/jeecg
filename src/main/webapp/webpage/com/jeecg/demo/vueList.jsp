<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/context/mytags.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<meta charset="UTF-8">
	<title>ElementDemo</title>
	<script src="https://cdn.bootcss.com/vue/2.2.2/vue.js"></script>
	<script src="https://cdn.bootcss.com/vue-resource/1.5.0/vue-resource.js"></script>  
	<!-- 引入样式 -->
	<link rel="stylesheet" href="https://unpkg.com/element-ui@1.4/lib/theme-default/index.css">
	<!-- 引入组件库 -->
	<script src="https://unpkg.com/element-ui@1.4/lib/index.js"></script>
	<link rel="stylesheet" href="${webRoot}/plug-in/element-ui/css/elementui-ext.css">
<style>
.toolbar {
    padding: 10px;
    margin: 10px 0;
}
.toolbar .el-form-item {
    margin-bottom: 10px;
}
.el-table__body-wrapper{overflow:hidden;}
.el-checkbox__inner{width:16px;height:16px;}
.el-table th,.el-table__header-wrapper thead div{background-color:#fff;}
</style>
</head>
<body bgcolor="white">
	<div id="test">
		<!--工具条-->
		<!--update-begin-Author:zhangweijian  Date: 20180710 for：TASK #2935 【样式】vue 列表样式尝试优化改进,常用示例-->
		<el-col :span="24" class="toolbar" style="padding-bottom: 0px;background: #f2f2f2;">
			<el-form :inline="true" :model="filters">
				<el-form-item style="margin-bottom: 8px;margin-top: 8px;">
					<el-input v-model="filters.name" placeholder="姓名" size="small"></el-input>
				</el-form-item>
				<el-form-item style="margin-top: 8px;">
			    	<el-button type="primary" v-on:click="getUsers" size="small">查询</el-button>
			    </el-form-item>
			    <el-form-item style="margin-top: 8px;">
		<!--update-end-Author:zhangweijian  Date: 20180710 for：TASK #2935 【样式】vue 列表样式尝试优化改进，常用示例-->
			    	<el-button type="primary" @click="handleAdd" size="small">新增</el-button>
			    </el-form-item>
			</el-form>
		</el-col>

		<!--列表-->
		<el-table :data="users" border stripe size="mini" highlight-current-row v-loading="listLoading" @selection-change="selsChange" style="width: 100%;">
			<el-table-column type="selection" width="55"></el-table-column>
			<el-table-column type="index" width="60"></el-table-column>
			<el-table-column prop="name" label="姓名" width="120" sortable show-overflow-tooltip></el-table-column>
			<el-table-column prop="sex" label="性别" width="100" :formatter="formatSex" sortable show-overflow-tooltip></el-table-column>
			<el-table-column prop="age" label="年龄" width="100" sortable show-overflow-tooltip></el-table-column>
			<el-table-column prop="birthday" label="生日" width="120" :formatter="formatBirthday" sortable show-overflow-tooltip></el-table-column>
			<el-table-column prop="phone" label="电话" min-width="120" sortable show-overflow-tooltip></el-table-column>
			<el-table-column label="操作" width="150">
				<template scope="scope">
					<el-button size="small" @click="handleEdit(scope.$index, scope.row)">编辑</el-button>
					<el-button size="small" type="danger" @click="handleDel(scope.$index, scope.row)">删除</el-button>
				</template>
			</el-table-column>
		</el-table>

		<!--工具条-->
		<el-col :span="24" class="toolbar">
			<el-button size="small" type="danger" @click="batchRemove" :disabled="this.sels.length===0">批量删除</el-button>
			 <el-pagination @current-change="handleCurrentChange" :page-sizes="[10, 20, 50, 100]"
      			:page-size="10" :total="total" layout="sizes, prev, pager, next"  style="float:right;"></el-pagination>
		</el-col>

		<!--编辑界面-->
		<el-dialog title="编辑" v-model="editFormVisible" :close-on-click-modal="false">
			<el-form :model="editForm" label-width="80px" :rules="editFormRules" ref="editForm">
				<el-form-item label="姓名" prop="name">
					<el-input v-model="editForm.name" auto-complete="off" placeholder="请输入用戶名"></el-input>
				</el-form-item>
				<el-form-item label="性别">
					<el-radio v-model="editForm.sex" :label="1">男</el-radio>
					<el-radio v-model="editForm.sex" :label="0">女</el-radio>
				</el-form-item>
				<el-form-item label="年龄">
					<el-input v-model="editForm.age" :min="0" :max="200"></el-input>
				</el-form-item>
				<el-form-item label="生日">
					<el-date-picker type="date" placeholder="选择日期" v-model="editForm.birthday"></el-date-picker>
				</el-form-item>
				<!--update-begin-Author:zhangweijian Date: 20180710 for：TASK #2941 【bug】常用示例，小问题,手机号校验-->
				<el-form-item label="电话" prop="phone">
				<!--update-end-Author:zhangweijian Date: 20180710 for：TASK #2941 【bug】常用示例，小问题，手机号校验-->
					<el-input v-model="editForm.phone"  placeholder="请输入手机号"></el-input>
				</el-form-item>
			</el-form>
			<div slot="footer" class="dialog-footer">
				<el-button @click.native="editFormVisible = false">取消</el-button>
				<el-button type="primary" @click.native="editSubmit" :loading="editLoading">提交</el-button>
			</div>
		</el-dialog>

		<!--新增界面-->
		<el-dialog title="新增" v-model="addFormVisible" :close-on-click-modal="false">
			<el-form :model="addForm" label-width="80px" :rules="addFormRules" ref="addForm">
				<el-form-item label="姓名" prop="name">
					<el-input v-model="addForm.name" auto-complete="off" placeholder="请输入用戶名"></el-input>
				</el-form-item>
				<el-form-item label="性别">
					<el-radio v-model="addForm.sex" :label="1">男</el-radio>
					<el-radio v-model="addForm.sex" :label="0">女</el-radio>
				</el-form-item>
				<el-form-item label="年龄">
				<!--update-begin-Author:zhangweijian Date: 20180710 for：TASK #2941 【bug】常用示例，小问题，手机号校验-->
					<el-input v-model="addForm.age" :min="0" :max="200" auto-complete="off"></el-input>
				<!--update-end-Author:zhangweijian Date: 20180710 for：TASK #2941 【bug】常用示例，小问题，手机号校验-->
				</el-form-item>
				<el-form-item label="生日">
					<el-date-picker type="date" placeholder="选择日期" v-model="addForm.birthday"></el-date-picker>
				</el-form-item>
				<!--update-begin-Author:zhangweijian Date: 20180710 for：TASK #2941 【bug】常用示例，小问题，手机号校验-->
				<el-form-item label="电话" prop="phone">
				<!--update-end-Author:zhangweijian Date: 20180710 for：TASK #2941 【bug】常用示例，小问题，手机号校验-->
					<el-input v-model="addForm.phone" placeholder="请输入手机号"></el-input>
				</el-form-item>
			</el-form>
			<div slot="footer" class="dialog-footer">
				<el-button @click.native="addFormVisible = false">取消</el-button>
				<el-button type="primary" @click.native="addSubmit" :loading="addLoading">提交</el-button>
			</div>
		</el-dialog>
	</section>
	</div>
</body>
<script>
<!--update-begin-Author:zhangweijian Date: 20180710 for：TASK #2941 【bug】常用示例，小问题，手机号校验-->
var validPhone=(rule, value,callback)=>{
    if (!value){
        callback(new Error('请输入电话号码'))
    }else  if (!isvalidPhone(value)){
      callback(new Error('请输入正确的11位手机号码'))
    }else {
        callback()
    }
}
function isvalidPhone(str) {
	const reg = /^1[3|4|5|7|8][0-9]\d{8}$/
	return reg.test(str)
}
<!--update-end-Author:zhangweijian Date: 20180710 for：TASK #2941 【bug】常用示例，小问题，手机号校验-->
	var vue = new Vue({			
		el:"#test",
		data() {
			return {
				filters: {
					name: ''
				},
				url:{
					list:'jeecgListDemoController.do?datagrid',
					del:'jeecgListDemoController.do?doDel',
					batchDel:'jeecgListDemoController.do?doBatchDel',
					save:'jeecgListDemoController.do?doAdd',
					edit:'jeecgListDemoController.do?doUpdate'
				},
				users: [],
				total: 0,
				page: 1,
				listLoading: false,
				sels: [],//列表选中列

				editFormVisible: false,//编辑界面是否显示
				editLoading: false,
				editFormRules: {
					name: [
						{ required: true, message: '请输入姓名', trigger: 'blur' }
					<!--update-begin-Author:zhangweijian Date: 20180710 for：TASK #2941 【bug】常用示例，小问题-->
					],
					phone: [
						{ required: true, validator: validPhone, trigger: 'blur' }
					<!--update-end-Author:zhangweijian Date: 20180710 for：TASK #2941 【bug】常用示例，小问题-->
					]
				},
				//编辑界面数据
				editForm: {
					id: 0,
					name: '',
					sex: 0,
					age: 0,
					birthday: '',
					phone: ''
				},

				addFormVisible: false,//新增界面是否显示
				addLoading: false,
				addFormRules: {
					name: [
						{ required: true, message: '请输入姓名', trigger: 'blur' }
					<!--update-begin-Author:zhangweijian Date: 20180710 for：TASK #2941 【bug】常用示例，小问题-->
					],
					phone: [
							{ required: true, validator: validPhone, trigger: 'blur' }
					<!--update-end-Author:zhangweijian Date: 20180710 for：TASK #2941 【bug】常用示例，小问题-->
					]
				},
				//新增界面数据
				addForm: {
					name: '',
					sex: 0,
					age: 0,
					birthday: '',
					phone: ''
				}

			}
		},
		methods: {
			//性别显示转换
			formatSex: function (row, column) {
				return row.sex == 1 ? '男' : row.sex == 0 ? '女' : '未知';
			},
			formatBirthday: function(row,column){
				return !!row.birthday?formatDate(new Date(row.birthday), 'yyyy-MM-dd'):'';
			},
			handleCurrentChange(val) {
				this.page = val;
				this.getUsers();
			},
			//获取用户列表
			getUsers() {
				let para = {
					params: {
						page: this.page,
						rows:10,
						name:this.filters.name,
						field:'id,name,sex,age,birthday,phone'
					}
				};
				this.listLoading = true;
				this.$http.get(this.url.list,para).then((res) => {
					this.total = res.data.total;
					for (var i=0; i<res.data.rows.length; i++)
				  	{
						res.data.rows[i].sex=parseInt(res.data.rows[i].sex);
				  	}
					this.users = res.data.rows;
					this.listLoading = false;
				});
			},
			//删除
			handleDel: function (index, row) {
				this.$confirm('确认删除该记录吗?', '提示', {
					type: 'warning'
				}).then(() => {
					this.listLoading = true;
					let para = { id: row.id };
					this.$http.post(this.url.del,para,{emulateJSON: true}).then((res) => {
						this.listLoading = false;
						this.$message({
							message: '删除成功',
							type: 'success'
						});
						this.getUsers();
					});
				}).catch(() => {

				});
			},
			//显示编辑界面
			handleEdit: function (index, row) {
				this.editFormVisible = true;
				this.editForm = Object.assign({}, row);
			},
			//显示新增界面
			handleAdd: function () {
				this.addFormVisible = true;
				this.addForm = {
					name: '',
					sex: 0,
					age: 0,
					birthday: '',
					phone: ''
				};
			},
			//编辑
			editSubmit: function () {
				this.$refs.editForm.validate((valid) => {
					if (valid) {
						this.$confirm('确认提交吗？', '提示', {}).then(() => {
							this.editLoading = true;
							let para = Object.assign({}, this.editForm);
							para.birthday = (!para.birthday || para.birthday == '') ? '' : formatDate(new Date(para.birthday), 'yyyy-MM-dd');
							this.$http.post(this.url.edit,para,{emulateJSON: true}).then((res) => {
								this.editLoading = false;
								this.$message({
									message: '提交成功',
									type: 'success'
								});
								this.$refs['editForm'].resetFields();
								this.editFormVisible = false;
								this.getUsers();
							});
						});
					}
				});
			},
			//新增
			addSubmit: function () {
				this.$refs.addForm.validate((valid) => {
					if (valid) {
						this.$confirm('确认提交吗？', '提示', {}).then(() => {
							this.addLoading = true;
							let para = Object.assign({}, this.addForm);
							para.birthday = (!para.birthday || para.birthday == '') ? '' : formatDate(new Date(para.birthday), 'yyyy-MM-dd');
							this.$http.post(this.url.save,para,{emulateJSON: true}).then((res) => {
								this.addLoading = false;
								this.$message({
									message: '提交成功',
									type: 'success'
								});
								this.$refs['addForm'].resetFields();
								this.addFormVisible = false;
								this.getUsers();
							});
						});
					}
				});
			},
			selsChange: function (sels) {
				this.sels = sels;
			},
			//批量删除
			batchRemove: function () {
				var ids = this.sels.map(item => item.id).toString();
				this.$confirm('确认删除选中记录吗？', '提示', {
					type: 'warning'
				}).then(() => {
					this.listLoading = true;
					let para = { ids: ids };
					this.$http.post(this.url.batchDel,para,{emulateJSON: true}).then((res) => {
						this.listLoading = false;
						this.$message({
							message: '删除成功',
							type: 'success'
						});
						this.getUsers();
					});
				}).catch(() => {
				});
			}
		},
		mounted() {
			this.getUsers();
		}
	});
	
	function formatDate(date, pattern) {
        pattern = pattern || "yyyy-MM-dd";
        return pattern.replace(/([yMdhsm])(\1*)/g, function ($0) {
            switch ($0.charAt(0)) {
                case 'y': return padding(date.getFullYear(), $0.length);
                case 'M': return padding(date.getMonth() + 1, $0.length);
                case 'd': return padding(date.getDate(), $0.length);
                case 'w': return date.getDay() + 1;
                case 'h': return padding(date.getHours(), $0.length);
                case 'm': return padding(date.getMinutes(), $0.length);
                case 's': return padding(date.getSeconds(), $0.length);
            }
        });
    };
	function padding(s, len) {
	    var len = len - (s + '').length;
	    for (var i = 0; i < len; i++) { s = '0' + s; }
	    return s;
	};
</script>
</html>
