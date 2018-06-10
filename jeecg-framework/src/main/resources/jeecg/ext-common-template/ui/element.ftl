						<#-- element-ui-->
						<#macro element po modelpre = "" size = "">
							<#if po.showType=='date'>
								<el-date-picker name="${po.fieldName}" size="${size}" v-model="${modelpre}${po.fieldName}" type="date" placeholder="请选择日期"></el-date-picker>		
							<#elseif po.showType=='datetime'>
								<el-date-picker name="${po.fieldName}" size="${size}" v-model="${modelpre}${po.fieldName}" type="datetime"  placeholder="选择日期时间"></el-date-picker>
							<#elseif po.showType=='select' || po.showType=='list' || po.showType=='radio'>
								<el-select name="${po.fieldName}" size="${size}" v-model="${modelpre}${po.fieldName}" placeholder="请选择">
								<el-option v-for="item in ${po.dictField}Options" :key="item.typecode" :label="item.typename" :value="item.typecode"></el-option>
								</el-select>
							<#elseif po.showType=='checkbox'>
								<el-select name="${po.fieldName}" size="${size}" v-model="${modelpre}${po.fieldName}" multiple collapse-tags placeholder="请选择">
								<el-option v-for="item in ${po.dictField}Options" :key="item.typecode" :label="item.typename" :value="item.typecode"></el-option>
								</el-select>
							<#elseif po.showType=='file' ||  po.showType=='image'>
								<el-upload :action="fileAction" :data="{isup:'1'}" :on-success="${po.fieldName}UploadFileHandler" :on-remove="${po.fieldName}RemoveFileHandler" :file-list="formFile.${po.fieldName}FileList">
							  		<el-button size="mini" type="primary">点击上传</el-button>
								</el-upload>
							<#else>
								<el-input name="${po.fieldName}" size="${size}" v-model="${modelpre}${po.fieldName}" <@datatype validType="${po.fieldValidType!''}" isNull="${po.isNull}" type="${po.type}" mustInput="${po.fieldMustInput!''}"  tableName="${po.table.tableName}" fieldName="${po.oldFieldName}"/>></el-input>
							</#if>
						</#macro>