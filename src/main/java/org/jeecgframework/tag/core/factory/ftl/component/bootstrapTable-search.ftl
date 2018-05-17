<#if dataGrid.queryMode=='group'>
	<#if po.query>
	    <#if po.queryMode=='single'>
	    	<#if po.replace??>
	    		<div class="col-xs-12 col-sm-6 col-md-4">
	    		<label for="${po.field?replace("_","\\.")}">${po.title}：</label>
	    		<div class="input-group" style="width:100%">
	    		<select class="form-control input-sm" id="${po.field?replace("_","\\.")}" name="${po.field?replace("_","\\.")}">
	    		<option value ="" >${MutiLangUtil.getLang("common.please.select")}</option>
	    			<#list po.replace?split(",") as str>  
         				<option value ="${str?split("_")[1]}" >${MutiLangUtil.getLang(str?split("_")[0])}</option>
					</#list>  
	    		</select>
	    		</div>
	    		</div>
			<#elseif po.dictionary??>
				<#if po.dictionary?index_of(",")!=-1&&po.popup>
					<div class="col-xs-12 col-sm-6 col-md-4">
		    		<label for="${po.field}">${po.title}：</label>
		    		<div class="input-group" style="width:100%">
		    		<input type="text" class="form-control input-sm" id="${po.field}" name="${po.field}">
		    		</div>
		    		</div>
				<#elseif po.dictionary?index_of(",")!=-1&&!po.popup>
					<div class="col-xs-12 col-sm-6 col-md-4">
		    		<label for="${po.field?replace("_","\\.")}">${po.title}：</label>
		    		<div class="input-group" style="width:100%">
		    		<select class="form-control input-sm" id="${po.field?replace("_","\\.")}" name="${po.field?replace("_","\\.")}">
		    		<option value ="" >${MutiLangUtil.getLang("common.please.select")}</option>
		    			<#list ComponentTools.getTableDictData(po) as dict>  
	         				<option value ="${dict.field}" >${dict.text}</option>
						</#list>  
		    		</select>
		    		</div>
		    		</div>
				<#else>
					<div class="col-xs-12 col-sm-6 col-md-4">
		    		<label for="${po.field?replace("_","\\.")}">${po.title}：</label>
		    		<div class="input-group" style="width:100%">
		    		<select class="form-control input-sm" id="${po.field?replace("_","\\.")}" name="${po.field?replace("_","\\.")}">
		    		<option value ="" >${MutiLangUtil.getLang("common.please.select")}</option>
		    			<#list ComponentTools.getDictData(po) as dict>  
	         				<option value ="${dict.typecode}" >${MutiLangUtil.getLang(dict.typename)}</option>
						</#list>  
		    		</select>
		    		</div>
		    		</div>
				</#if>
			<#else>
					<div class="col-xs-12 col-sm-6 col-md-4">
		    		<label for="${po.field}">${po.title}：</label>
		    		<div class="input-group" style="width:100%">
		    		<input type="text" class="form-control input-sm" id="${po.field}" name="${po.field}">
		    		</div>
		    		</div>
		    		<#if po.formatter??>
			    		<script type="text/javascript"> 
			    		laydate.render({
			    			elem: '#${po.field}',
			    			<#if po.formatter=='yyyy-MM-dd'>
			    			type: 'date',
			    			<#else>
			    			type: 'datetime',
			    			</#if>
			    			trigger: 'click',
			    			ready: function(date){ 
			    				$("#${po.field}").val(DateJsonFormat(date,this.format)); 
			    			}
			    		}); 
			    		</script>
		    		</#if>
			</#if>
		<#elseif po.queryMode=='group'>
			<div class="col-xs-12 col-sm-6 col-md-4">
    		<label for="${po.field}_begin">${po.title}：</label>
    		<div class="input-group" style="width:100%">
    		<input type="text" class="form-control input-sm" id="${po.field}_begin" name="${po.field}_begin">
    		<span class="input-group-addon input-sm" >~</span>
    		<input type="text" class="form-control input-sm" id="${po.field}_end" name="${po.field}_end">
    		</div>
    		</div>
    		<#if po.formatter??>
	    		<script type="text/javascript"> 
	    		laydate.render({
	    			elem: '#${po.field}_begin',
	    			<#if po.formatter=='yyyy-MM-dd'>
	    			type: 'date',
	    			<#else>
	    			type: 'datetime',
	    			</#if>
	    			trigger: 'click',
	    			ready: function(date){ 
	    				$("#${po.field}_begin").val(DateJsonFormat(date,this.format)); 
	    			}
	    		}); 
	    		laydate.render({
	    			elem: '#${po.field}_end',
	    			<#if po.formatter=='yyyy-MM-dd'>
	    			type: 'date',
	    			<#else>
	    			type: 'datetime',
	    			</#if>
	    			trigger: 'click',
	    			ready: function(date){ 
	    				$("#${po.field}_end").val(DateJsonFormat(date,this.format)); 
	    			}
	    		}); 
	    		</script>
    		</#if>
		</#if>
	</#if>
</#if>

								