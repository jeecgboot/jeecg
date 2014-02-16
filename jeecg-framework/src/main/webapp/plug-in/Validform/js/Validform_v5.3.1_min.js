(function($, win, undef) {
	var errorobj = null, msgobj = null, msghidden = true;
	var tipmsg = {
		tit : "提示信息",
		w : {
			"*" : "不能为空！",
			"*6-16" : "请填写6到16位任意字符！",
			"n" : "请填写数字！",
			"n6-16" : "请填写6到16位数字！",
			"s" : "不能输入特殊字符！",
			"s6-18" : "请填写6到18位字符！",
			"p" : "请填写邮政编码！",
			"m" : "请填写手机号码！",
			"e" : "邮箱地址格式不对！",
			"url" : "请填写网址！",
			"w1" : "必须输入字母开头、可带数字、下划线的字符"
		},
		def : "请填写正确信息！",
		undef : "datatype未定义！",
		reck : "两次输入的内容不一致！",
		r : "通过信息验证！",
		c : "正在检测信息…",
		s : "请{填写|选择}{0|信息}！",
		v : "所填信息没有经过验证，请稍后…",
		p : "正在提交数据…"
	}
	$.Tipmsg = tipmsg;
	var Validform = function(forms, settings, inited) {
		var settings = $.extend( {}, Validform.defaults, settings);
		settings.datatype
				&& $.extend(Validform.util.dataType, settings.datatype);
		var brothers = this;
		brothers.tipmsg = {
			w : {}
		};
		brothers.settings = settings;
		brothers.forms = forms;
		brothers.objects = [];
		if (inited === true) {
			return false;
		}
		forms.each(function() {
			if (this.validform_inited == "inited") {
				return true;
			}
			this.validform_inited = "inited";
			var $this = $(this);
			this.validform_status = "normal";
			this.validform_label = settings.label;
			$this.data("tipmsg", brothers.tipmsg);
			$this.delegate("[datatype]", "blur", function() {
				var subpost = arguments[1];
				Validform.util.check.call(this, $this, brothers, subpost);
			});
			Validform.util.enhance.call($this, settings.tiptype,
					settings.usePlugin, settings.tipSweep);
			settings.btnSubmit
					&& $this.find(settings.btnSubmit).bind("click", function() {
						$this.trigger("submit");
						return false;
					});
			$this.submit(function() {
				var subflag = Validform.util.submitForm.call($this, settings);
				subflag === undef && (subflag = true);
				return subflag;
			});
			$this.find("[type='reset']").add($this.find(settings.btnReset))
					.bind("click", function() {
						Validform.util.resetForm.call($this);
					});
		});
		if (settings.tiptype == 1
				|| (settings.tiptype == 2 || settings.tiptype == 3)
				&& settings.ajaxPost) {
			creatMsgbox();
		}
	}
	Validform.defaults = {
		tiptype : 1,
		tipSweep : false,
		showAllError : false,
		postonce : false,
		ajaxPost : false
	}
	Validform.util = {
		dataType : {
			"*" : /[\w\W]+/,
			"*6-16" : /^[\w\W]{6,16}$/,
			"n" : /^\d+$/,
			"n6-16" : /^\d{6,16}$/,
			"s" : /^[\u4E00-\u9FA5\uf900-\ufa2d\w\.\s]+$/,
			"s6-18" : /^[\u4E00-\u9FA5\uf900-\ufa2d\w\.\s]{6,18}$/,
			"p" : /^[0-9]{6}$/,
			"m" : /^13[0-9]{9}$|14[0-9]{9}|15[0-9]{9}$|18[0-9]{9}$/,
			"e" : /^\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*$/,
			"url" : /^(\w+:\/\/)?\w+(\.\w+)+.*$/,
			"w1" : /^([a-zA-Z]+)([\w]+)*$/
		},
		toString : Object.prototype.toString,
		isEmpty : function(val) {
			return val === "" || val === $.trim(this.attr("tip"));
		},
		getValue : function(obj) {
			var inputval, curform = this;
			if (obj.is(":radio")) {
				inputval = curform.find(
						":radio[name='" + obj.attr("name") + "']:checked")
						.val();
				inputval = inputval === undef ? "" : inputval;
			} else if (obj.is(":checkbox")) {
				inputval = "";
				curform.find(
						":checkbox[name='" + obj.attr("name") + "']:checked")
						.each(function() {
							inputval += $(this).val() + ',';
						})
				inputval = inputval === undef ? "" : inputval;
			} else {
				inputval = obj.val();
			}
			inputval = $.trim(inputval);
			return Validform.util.isEmpty.call(obj, inputval) ? "" : inputval;
		},
		ajax_check:function(tableName,fieldName,fieldVlaue,param){
			   //获取编辑页面的数据主键
					var obid = null;
					if(param!=null){
						 var obid_id = param;
						 obid = obid_id;
					}else{
						 obid = $("input[id='id']").val();
					}
					
					$.ajaxSetup({ async: false});//同步ajax 
					var check_flag="";
					$.ajax({
						url : 'duplicateCheckAction.do?doDuplicateCheck',
						async:false,
						data : {
							tableName : tableName,
							fieldName : fieldName,
							fieldVlaue: fieldVlaue,
							rowObid   : obid
						},
						dataType : 'json',
						success : function(response) {
							check_flag = response.msg+"+"+response.success;
							//$.messager.alert('提示', response.msg, 'error');
						}
					});
					$.ajaxSetup({ async: false});//同步ajax 
					return check_flag;
				},
		enhance : function(tiptype, usePlugin, tipSweep, addRule) {
			var curform = this;
			curform
					.find("[datatype]")
					.each(
							function() {
								if (tiptype == 2) {
									if ($(this).parent().next().find(
											".Validform_checktip").length == 0) {
										$(this)
												.parent()
												.next()
												.append(
														"<span class='Validform_checktip' />");
									}
								} else if (tiptype == 3 || tiptype == 4) {
									if ($(this).siblings(".Validform_checktip").length == 0) {
										$(this)
												.parent()
												.append(
														"<span class='Validform_checktip' />");
									}
								}
							})
			curform
					.find("input[recheck]")
					.each(
							function() {
								if (this.validform_inited == "inited") {
									return true;
								}
								this.validform_inited = "inited";
								var _this = $(this);
								var recheckinput = curform.find("input[name='"
										+ $(this).attr("recheck") + "']");
								recheckinput
										.bind(
												"keyup",
												function() {
													if (recheckinput.val() == _this
															.val()
															&& recheckinput
																	.val() != "") {
														if (recheckinput
																.attr("tip")) {
															if (recheckinput
																	.attr("tip") == recheckinput
																	.val()) {
																return false;
															}
														}
														_this.trigger("blur");
													}
												})
										.bind(
												"blur",
												function() {
													if (recheckinput.val() != _this
															.val()
															&& _this.val() != "") {
														if (_this.attr("tip")) {
															if (_this
																	.attr("tip") == _this
																	.val()) {
																return false;
															}
														}
														_this.trigger("blur");
													}
												});
							});
			curform.find("[tip]").each(function() {
				if (this.validform_inited == "inited") {
					return true;
				}
				this.validform_inited = "inited";
				var defaultvalue = $(this).attr("tip");
				var altercss = $(this).attr("altercss");
				$(this).focus(function() {
					if ($(this).val() == defaultvalue) {
						$(this).val('');
						if (altercss) {
							$(this).removeClass(altercss);
						}
					}
				}).blur(function() {
					if ($.trim($(this).val()) === '') {
						$(this).val(defaultvalue);
						if (altercss) {
							$(this).addClass(altercss);
						}
					}
				});
			});
			curform.find(":checkbox[datatype],:radio[datatype]").each(
					function() {
						if (this.validform_inited == "inited") {
							return true;
						}
						this.validform_inited = "inited";
						var _this = $(this);
						var name = _this.attr("name");
						curform.find("[name='" + name + "']").filter(
								":checkbox,:radio").bind("click", function() {
							setTimeout(function() {
								_this.trigger("blur");
							}, 0);
						});
					});
			curform.find("select[datatype][multiple]").bind("click",
					function() {
						var _this = $(this);
						setTimeout(function() {
							_this.trigger("blur");
						}, 0);
					});
			Validform.util.usePlugin.call(curform, usePlugin, tiptype,
					tipSweep, addRule);
		},
		usePlugin : function(plugin, tiptype, tipSweep, addRule) {
			var curform = this, plugin = plugin || {};
			if (curform.find("input[plugin='swfupload']").length
					&& typeof (swfuploadhandler) != "undefined") {
				var custom = {
					custom_settings : {
						form : curform,
						showmsg : function(msg, type, obj) {
							Validform.util.showmsg
									.call(
											curform,
											msg,
											tiptype,
											{
												obj : curform
														.find("input[plugin='swfupload']"),
												type : type,
												sweep : tipSweep
											});
						}
					}
				};
				custom = $.extend(true, {}, plugin.swfupload, custom);
				curform.find("input[plugin='swfupload']").each(function(n) {
					if (this.validform_inited == "inited") {
						return true;
					}
					this.validform_inited = "inited";
					$(this).val("");
					swfuploadhandler.init(custom, n);
				});
			}
			if (curform.find("input[plugin='datepicker']").length
					&& $.fn.datePicker) {
				plugin.datepicker = plugin.datepicker || {};
				if (plugin.datepicker.format) {
					Date.format = plugin.datepicker.format;
					delete plugin.datepicker.format;
				}
				if (plugin.datepicker.firstDayOfWeek) {
					Date.firstDayOfWeek = plugin.datepicker.firstDayOfWeek;
					delete plugin.datepicker.firstDayOfWeek;
				}
				curform
						.find("input[plugin='datepicker']")
						.each(
								function(n) {
									if (this.validform_inited == "inited") {
										return true;
									}
									this.validform_inited = "inited";
									plugin.datepicker.callback
											&& $(this)
													.bind(
															"dateSelected",
															function() {
																var d = new Date(
																		$.event._dpCache[this._dpId]
																				.getSelected()[0])
																		.asString(Date.format);
																plugin.datepicker
																		.callback(
																				d,
																				this);
															});
									$(this).datePicker(plugin.datepicker);
								});
			}
			if (curform.find("input[plugin*='passwordStrength']").length
					&& $.fn.passwordStrength) {
				plugin.passwordstrength = plugin.passwordstrength || {};
				plugin.passwordstrength.showmsg = function(obj, msg, type) {
					Validform.util.showmsg.call(curform, msg, tiptype, {
						obj : obj,
						type : type,
						sweep : tipSweep
					});
				};
				curform.find("input[plugin='passwordStrength']").each(
						function(n) {
							if (this.validform_inited == "inited") {
								return true;
							}
							this.validform_inited = "inited";
							$(this).passwordStrength(plugin.passwordstrength);
						});
			}
			if (addRule != "addRule" && plugin.jqtransform
					&& $.fn.jqTransSelect) {
				var jqTransformHideSelect = function(oTarget) {
					var ulVisible = $('.jqTransformSelectWrapper ul:visible');
					ulVisible.each(function() {
						var oSelect = $(this).parents(
								".jqTransformSelectWrapper:first").find(
								"select").get(0);
						if (!(oTarget && oSelect.oLabel && oSelect.oLabel
								.get(0) == oTarget.get(0))) {
							$(this).hide();
						}
					});
				};
				var jqTransformCheckExternalClick = function(event) {
					if ($(event.target).parents('.jqTransformSelectWrapper').length === 0) {
						jqTransformHideSelect($(event.target));
					}
				};
				var jqTransformAddDocumentListener = function() {
					$(document).mousedown(jqTransformCheckExternalClick);
				};
				if (plugin.jqtransform.selector) {
					curform.find(plugin.jqtransform.selector).filter(
							'input:submit, input:reset, input[type="button"]')
							.jqTransInputButton();
					curform.find(plugin.jqtransform.selector).filter(
							'input:text, input:password').jqTransInputText();
					curform.find(plugin.jqtransform.selector).filter(
							'input:checkbox').jqTransCheckBox();
					curform.find(plugin.jqtransform.selector).filter(
							'input:radio').jqTransRadio();
					curform.find(plugin.jqtransform.selector)
							.filter('textarea').jqTransTextarea();
					if (curform.find(plugin.jqtransform.selector).filter(
							"select").length > 0) {
						curform.find(plugin.jqtransform.selector).filter(
								"select").jqTransSelect();
						jqTransformAddDocumentListener();
					}
				} else {
					curform.jqTransform();
				}
				curform.find(".jqTransformSelectWrapper").find("li a").click(
						function() {
							$(this).parents(".jqTransformSelectWrapper").find(
									"select").trigger("blur");
						});
			}
		},
		getNullmsg : function(curform) {
			var obj = this;
			var reg = /[\u4E00-\u9FA5\uf900-\ufa2da-zA-Z\s]+/g;
			var nullmsg;
			var label = curform[0].validform_label || ".Validform_label";
			label = obj.siblings(label).text()
					|| obj.siblings().find(label).text()
					|| obj.parent().siblings(label).text()
					|| obj.parent().siblings().find(label).text();
			label = label.match(reg) || [ "" ];
			reg = /\{(.+)\|(.+)\}/;
			nullmsg = curform.data("tipmsg").s || tipmsg.s;
			label = label[0].replace(/\s(?![a-zA-Z])/g, "");
			if (label != "") {
				nullmsg = nullmsg.replace(/\{0\|(.+)\}/, label);
				if (obj.attr("recheck")) {
					nullmsg = nullmsg.replace(/\{(.+)\}/, "");
					obj.attr("nullmsg", nullmsg);
					return nullmsg;
				}
			} else {
				nullmsg = obj.is(":checkbox,:radio,select") ? nullmsg.replace(
						/\{0\|(.+)\}/, "") : nullmsg.replace(/\{0\|(.+)\}/,
						"$1");
			}
			nullmsg = obj.is(":checkbox,:radio,select") ? nullmsg.replace(reg,
					"$2") : nullmsg.replace(reg, "$1");
			obj.attr("nullmsg", nullmsg);
			return nullmsg;
		},
		getErrormsg : function(curform, datatype, recheck) {
			var obj = this;
			var regxp = /^(.+?)((\d+)-(\d+))?$/, regxp2 = /^(.+?)(\d+)-(\d+)$/, regxp3 = /(.*?)\d+(.+?)\d+(.*)/, mac = datatype
					.match(regxp), temp, str;
			if (recheck == "recheck") {
				str = curform.data("tipmsg").reck || tipmsg.reck;
				return str;
			}
			if (mac[0] in tipmsg.w) {
				return curform.data("tipmsg").w[mac[0]] || tipmsg.w[mac[0]];
			}
			for ( var name in tipmsg.w) {
				if (name.indexOf(mac[1]) != -1 && regxp2.test(name)) {
					str = (curform.data("tipmsg").w[name] || tipmsg.w[name])
							.replace(regxp3, "$1" + mac[3] + "$2" + mac[4]
									+ "$3");
					tipmsg.w[mac[0]] = str;
					return str;
				}
			}
			return curform.data("tipmsg").def || tipmsg.def;
		},
		_regcheck : function(datatype, gets, obj, curform) {
			var curform = curform, info = null, passed = false, reg = /\/.+\//g, regex = /^(.+?)(\d+)-(\d+)$/, type = 3;
			if (reg.test(datatype)) {
				var regstr = datatype.match(reg)[0].slice(1, -1);
				var param = datatype.replace(reg, "");
				var rexp = RegExp(regstr, param);
				passed = rexp.test(gets);
			} else if (Validform.util.toString
					.call(Validform.util.dataType[datatype]) == "[object Function]") {
				passed = Validform.util.dataType[datatype](gets, obj, curform,
						Validform.util.dataType);
				if (passed === true || passed === undef) {
					passed = true;
				} else {
					info = passed;
					passed = false;
				}
			} else {
				if (!(datatype in Validform.util.dataType)) {
					var mac = datatype.match(regex), temp;
					if (!mac) {
						passed = false;
						info = curform.data("tipmsg").undef || tipmsg.undef;
					} else {
						for ( var name in Validform.util.dataType) {
							temp = name.match(regex);
							if (!temp) {
								continue;
							}
							if (mac[1] === temp[1]) {
								var str = Validform.util.dataType[name]
										.toString(), param = str
										.match(/\/[mgi]*/g)[1]
										.replace("\/", ""), regxp = new RegExp(
										"\\{" + temp[2] + "," + temp[3] + "\\}",
										"g");
								str = str.replace(/\/[mgi]*/g, "\/").replace(
										regxp,
										"{" + mac[2] + "," + mac[3] + "}")
										.replace(/^\//, "").replace(/\/$/, "");
								Validform.util.dataType[datatype] = new RegExp(
										str, param);
								break;
							}
						}
					}
				}
				if (Validform.util.toString
						.call(Validform.util.dataType[datatype]) == "[object RegExp]") {
					passed = Validform.util.dataType[datatype].test(gets);
				}
			}
			if (passed) {
				type = 2;
				info = obj.attr("sucmsg") || curform.data("tipmsg").r
						|| tipmsg.r;
				if (obj.attr("recheck")) {
					var theother = curform.find("input[name='"
							+ obj.attr("recheck") + "']:first");
					if (gets != theother.val()) {
						passed = false;
						type = 3;
						info = obj.attr("errormsg")
								|| Validform.util.getErrormsg.call(obj,
										curform, datatype, "recheck");
					}
				}
			} else {
				info = info
						|| obj.attr("errormsg")
						|| Validform.util.getErrormsg.call(obj, curform,
								datatype);
				if (Validform.util.isEmpty.call(obj, gets)) {
					info = obj.attr("nullmsg")
							|| Validform.util.getNullmsg.call(obj, curform);
				}
			}
			return {
				passed : passed,
				type : type,
				info : info
			};
		},
		regcheck : function(datatype, gets, obj) {
			var curform = this, info = null, passed = false, type = 3;
			if (obj.attr("ignore") === "ignore"
					&& Validform.util.isEmpty.call(obj, gets)) {
				if (obj.data("cked")) {
					info = "";
				}
				return {
					passed : true,
					type : 4,
					info : info
				};
			}
			obj.data("cked", "cked");
			var dtype = Validform.util.parseDatatype(datatype);
			var res;
			for ( var eithor = 0; eithor < dtype.length; eithor++) {
				for ( var dtp = 0; dtp < dtype[eithor].length; dtp++) {
					res = Validform.util._regcheck(dtype[eithor][dtp], gets,
							obj, curform);
					if (!res.passed) {
						break;
					}
				}
				if (res.passed) {
					break;
				}
			}
			return res;
		},
		parseDatatype : function(datatype) {
			var reg = /\/.+?\/[mgi]*(?=(,|$|\||\s))|[\w\*-]+/g, dtype = datatype
					.match(reg), sepor = datatype.replace(reg, "").replace(
					/\s*/g, "").split(""), arr = [], m = 0;
			arr[0] = [];
			arr[0].push(dtype[0]);
			for ( var n = 0; n < sepor.length; n++) {
				if (sepor[n] == "|") {
					m++;
					arr[m] = [];
				}
				arr[m].push(dtype[n + 1]);
			}
			return arr;
		},
		showmsg : function(msg, type, o, triggered) {
			if (msg == undef) {
				return;
			}
			if (triggered == "bycheck"
					&& o.sweep
					&& (o.obj && !o.obj.is(".Validform_error") || typeof type == "function")) {
				return;
			}
			$.extend(o, {
				curform : this
			});
			if (typeof type == "function") {
				type(msg, o, Validform.util.cssctl);
				return;
			}
			if (type == 1 || triggered == "byajax" && type != 4) {
				msgobj.find(".Validform_info").html(msg);
			}
			if (type == 1 && o.type != 2 || triggered == "byajax" && type != 4) {
				msghidden = false;
				msgobj.find(".iframe").css("height", msgobj.outerHeight());
				msgobj.show();
				setCenter(msgobj, 100);
			}
			if (msg == "通过信息验证！") {
				setTimeout(function() {
					msgobj.hide();
				}, 1000);
			}
			if (type == 2 && o.obj) {
				o.obj.parent().next().find(".Validform_checktip").html(msg);
				Validform.util.cssctl(o.obj.parent().next().find(
						".Validform_checktip"), o.type);
			}
			if ((type == 3 || type == 4) && o.obj) {
				o.obj.siblings(".Validform_checktip").html(msg);
				Validform.util.cssctl(o.obj.siblings(".Validform_checktip"),
						o.type);
			}
		},
		cssctl : function(obj, status) {
			switch (status) {
			case 1:
				obj.removeClass("Validform_right Validform_wrong").addClass(
						"Validform_checktip Validform_loading");
				break;
			case 2:
				obj.removeClass("Validform_wrong Validform_loading").addClass(
						"Validform_checktip Validform_right");
				break;
			case 4:
				obj.removeClass(
						"Validform_right Validform_wrong Validform_loading")
						.addClass("Validform_checktip");
				break;
			default:
				obj.removeClass("Validform_right Validform_loading").addClass(
						"Validform_checktip Validform_wrong");
			}
		},
		check : function(curform, brothers, subpost, bool) {
			var settings = brothers.settings;
			var subpost = subpost || "";
			var inputval = Validform.util.getValue.call(curform, $(this));
			if (settings.ignoreHidden && $(this).is(":hidden")
					|| $(this).data("dataIgnore") === "dataIgnore") {
				return true;
			}
			if (settings.dragonfly && !$(this).data("cked")
					&& Validform.util.isEmpty.call($(this), inputval)
					&& $(this).attr("ignore") != "ignore") {
				return false;
			}
			var flag = Validform.util.regcheck.call(curform, $(this).attr(
					"datatype"), inputval, $(this));
			if (inputval == this.validform_lastval && !$(this).attr("recheck")
					&& subpost == "") {
				return flag.passed ? true : false;
			}
			this.validform_lastval = inputval;
			var _this;
			errorobj = _this = $(this);
			if (!flag.passed) {
				Validform.util.abort.call(_this[0]);
				if (!bool) {
					Validform.util.showmsg.call(curform, flag.info,
							settings.tiptype, {
								obj : $(this),
								type : flag.type,
								sweep : settings.tipSweep
							}, "bycheck");
					!settings.tipSweep && _this.addClass("Validform_error");
				}
				return false;
			}
			//字段重复校验
			var  validType=$(this).attr("validType");
			var tipType=settings.tiptype;
			//if(tipType==null||tipType!=1){
			if(validType!=null){
		       var params=validType.split(",");
		       var  ajaxResultValue=Validform.util.ajax_check(params[0],params[1],$(this).val(),$("input[name='"+params[2]+"']").val());
			   var resultParams= new Array(); //定义一数组
                resultParams=ajaxResultValue.split("+"); //字符分割     
			   if (resultParams[1] == "false" && tipType == 1) {
                    msgobj.find(".Validform_info").html(resultParams[0]);
                    msghidden = false;
                    msgobj.find(".iframe").css("height", msgobj.outerHeight());
                    msgobj.show();
                    setCenter(msgobj, 100);
                    _this.addClass("Validform_error");
                    flag = false;
                    return false;
                }
                else if (resultParams[1] == "false") {
                        $(_this).next().html(resultParams[0]);
                        $(_this).next().addClass("Validform_wrong");
                        _this.addClass("Validform_error");
                        return false;
                    }
		    }	
		    //}
			
			
			var ajaxurl = $(this).attr("ajaxurl");
			if (ajaxurl && !Validform.util.isEmpty.call($(this), inputval)
					&& !bool) {
				var inputobj = $(this);
				if (subpost == "postform") {
					inputobj[0].validform_subpost = "postform";
				} else {
					inputobj[0].validform_subpost = "";
				}
				if (inputobj[0].validform_valid === "posting"
						&& inputval == inputobj[0].validform_ckvalue) {
					return "ajax";
				}
				inputobj[0].validform_valid = "posting";
				inputobj[0].validform_ckvalue = inputval;
				Validform.util.showmsg.call(curform, brothers.tipmsg.c
						|| tipmsg.c, settings.tiptype, {
					obj : inputobj,
					type : 1,
					sweep : settings.tipSweep
				}, "bycheck");
				Validform.util.abort.call(_this[0]);
				var ajaxsetup = curform[0].validform_config || {};
				ajaxsetup = ajaxsetup.ajaxurl || {};
				var localconfig = {
					type : "POST",
					cache : false,
					url : ajaxurl,
					data : "param=" + encodeURIComponent(inputval) + "&name="
							+ encodeURIComponent($(this).attr("name")),
					success : function(data) {
						if ($.trim(data.status) === "y") {
							inputobj[0].validform_valid = "true";
							data.info && inputobj.attr("sucmsg", data.info);
							Validform.util.showmsg.call(curform, inputobj
									.attr("sucmsg")
									|| brothers.tipmsg.r || tipmsg.r,
									settings.tiptype, {
										obj : inputobj,
										type : 2,
										sweep : settings.tipSweep
									}, "bycheck");
							_this.removeClass("Validform_error");
							errorobj = null;
							if (inputobj[0].validform_subpost == "postform") {
								curform.trigger("submit");
							}
						} else {
							inputobj[0].validform_valid = data.info;
							Validform.util.showmsg.call(curform, data.info,
									settings.tiptype, {
										obj : inputobj,
										type : 3,
										sweep : settings.tipSweep
									});
							_this.addClass("Validform_error");
						}
						_this[0].validform_ajax = null;
					},
					error : function(data) {
						if (data.status == "200") {
							if (data.responseText == "y") {
								ajaxsetup.success( {
									"status" : "y"
								});
							} else {
								ajaxsetup.success( {
									"status" : "n",
									"info" : data.responseText
								});
							}
							return false;
						}
						if (data.statusText !== "abort") {
							var msg = "status: " + data.status
									+ "; statusText: " + data.statusText;
							Validform.util.showmsg.call(curform, msg,
									settings.tiptype, {
										obj : inputobj,
										type : 3,
										sweep : settings.tipSweep
									});
							_this.addClass("Validform_error");
						}
						inputobj[0].validform_valid = data.statusText;
						_this[0].validform_ajax = null;
						return true;
					}
				}
				if (ajaxsetup.success) {
					var temp_suc = ajaxsetup.success;
					ajaxsetup.success = function(data) {
						localconfig.success(data);
						temp_suc(data, inputobj);
					}
				}
				if (ajaxsetup.error) {
					var temp_err = ajaxsetup.error;
					ajaxsetup.error = function(data) {
						localconfig.error(data) && temp_err(data, inputobj);
					}
				}
				ajaxsetup = $.extend( {}, localconfig, ajaxsetup, {
					dataType : "json"
				});
				_this[0].validform_ajax = $.ajax(ajaxsetup);
				return "ajax";
			} else if (ajaxurl
					&& Validform.util.isEmpty.call($(this), inputval)) {
				Validform.util.abort.call(_this[0]);
				_this[0].validform_valid = "true";
			}
			if (!bool) {
				Validform.util.showmsg.call(curform, flag.info,
						settings.tiptype, {
							obj : $(this),
							type : flag.type,
							sweep : settings.tipSweep
						}, "bycheck");
				_this.removeClass("Validform_error");
			}
			errorobj = null;
			return true;
		},
		submitForm : function(settings, flg, url, ajaxPost, sync) {
			var curform = this;
			if (curform[0].validform_status === "posting") {
				return false;
			}
			if (settings.postonce && curform[0].validform_status === "posted") {
				return false;
			}
			var beforeCheck = settings.beforeCheck
					&& settings.beforeCheck(curform);
			if (beforeCheck === false) {
				return false;
			}
			var flag = true, inflag;
			
			
			//tipType==1弹出层提示信息。
			var tipType=settings.tiptype
					//字段重复校验
			if(tipType==null||tipType!=1){
				 curform.find("[validType]").each(function(obj){
				   var validType=$(this).attr("validType");
					if(validType!=null&&$(this).val()!=""){
				       var params=validType.split(",");
				       var   ajaxResultValue=Validform.util.ajax_check(params[0],params[1],$(this).val(),$("input[name='"+params[2]+"']").val());
					   var resultParams= new Array(); //定义一数组
		                resultParams=ajaxResultValue.split("+"); //字符分割     
					  if(resultParams[1]=="false"){
					   $(_this).next().html(resultParams[0]);
					    $(_this).next().addClass("Validform_wrong");
					     _this.addClass("Validform_error");
							flag=false;
					     return false;
					   }
					   else{
					   }
				    }	
					});
			}
	
			if(tipType!=null&&tipType==1){
				curform.find("[validType]").each(function(obj){
				   var validType=$(this).attr("validType");
					if(validType!=null&&$(this).val()!=""){
				       var params=validType.split(",");
				       var  ajaxResultValue=Validform.util.ajax_check(params[0],params[1],$(this).val(),$("input[name='"+params[2]+"']").val());
					   var resultParams= new Array(); //定义一数组
		                resultParams=ajaxResultValue.split("+"); //字符分割     
					  if(resultParams[1]=="false"){
					   //$(th).next().html(resultParams[0]);
					    $(this).addClass("Validform_error");
					   msgobj.find(".Validform_info").html(resultParams[0]);
					   msghidden=false;
						msgobj.find(".iframe").css("height",msgobj.outerHeight());
						msgobj.show();
						setCenter(msgobj,100);
					     _this.addClass("Validform_error");
							flag=false;
					     return false;
					   }
					   else{
					   }
				    }	
					});
			}
			
			
			curform
					.find("[datatype]")
					.each(
							function() {
								if (flg) {
									return false;
								}
								if (settings.ignoreHidden
										&& $(this).is(":hidden")
										|| $(this).data("dataIgnore") === "dataIgnore") {
									return true;
								}
								var inputval = Validform.util.getValue.call(
										curform, $(this)), _this;
								errorobj = _this = $(this);
								inflag = Validform.util.regcheck.call(curform,
										$(this).attr("datatype"), inputval,
										$(this));
								if (!inflag.passed) {
									Validform.util.showmsg.call(curform,
											inflag.info, settings.tiptype, {
												obj : $(this),
												type : inflag.type,
												sweep : settings.tipSweep
											});
									_this.addClass("Validform_error");
									if (!settings.showAllError) {
										_this.focus();
										flag = false;
										return false;
									}
									flag && (flag = false);
									return true;
								}
								if ($(this).attr("ajaxurl")
										&& !Validform.util.isEmpty.call(
												$(this), inputval)) {
									if (this.validform_valid !== "true") {
										var thisobj = $(this);
										Validform.util.showmsg.call(curform,
												curform.data("tipmsg").v
														|| tipmsg.v,
												settings.tiptype, {
													obj : thisobj,
													type : 3,
													sweep : settings.tipSweep
												});
										_this.addClass("Validform_error");
										thisobj.trigger("blur", [ "postform" ]);
										if (!settings.showAllError) {
											flag = false;
											return false;
										}
										flag && (flag = false);
										return true;
									}
								} else if ($(this).attr("ajaxurl")
										&& Validform.util.isEmpty.call($(this),
												inputval)) {
									Validform.util.abort.call(this);
									this.validform_valid = "true";
								}
								Validform.util.showmsg.call(curform,
										inflag.info, settings.tiptype, {
											obj : $(this),
											type : inflag.type,
											sweep : settings.tipSweep
										});
								_this.removeClass("Validform_error");
								errorobj = null;
							});
			if (settings.showAllError) {
				curform.find(".Validform_error:first").focus();
			}
			if (flag) {
				var beforeSubmit = settings.beforeSubmit
						&& settings.beforeSubmit(curform);
				if (beforeSubmit === false) {
					return false;
				}
				curform[0].validform_status = "posting";
				var config = curform[0].validform_config || {}
				if (settings.ajaxPost || ajaxPost === "ajaxPost") {
					var ajaxsetup = config.ajaxpost || {};
					ajaxsetup.url = url || ajaxsetup.url || config.url
							|| curform.attr("action");
					ajaxsetup.success
							|| ajaxsetup.error
							|| Validform.util.showmsg.call(curform, curform
									.data("tipmsg").p
									|| tipmsg.p, settings.tiptype, {
								obj : curform,
								type : 1,
								sweep : settings.tipSweep
							}, "byajax");
					if (sync) {
						ajaxsetup.async = false;
					} else if (sync === false) {
						ajaxsetup.async = true;
					}
					if (ajaxsetup.success) {
						var temp_suc = ajaxsetup.success;
						ajaxsetup.success = function(data) {
							settings.callback && settings.callback(data);
							curform[0].validform_ajax = null;
							if ($.trim(data.status) === "y") {
								curform[0].validform_status = "posted";
							} else {
								curform[0].validform_status = "normal";
							}
							temp_suc(data, curform);
						}
					}
					if (ajaxsetup.error) {
						var temp_err = ajaxsetup.error;
						ajaxsetup.error = function(data) {
							settings.callback && settings.callback(data);
							curform[0].validform_status = "normal";
							curform[0].validform_ajax = null;
							temp_err(data, curform);
						}
					}
					var localconfig = {
						type : "POST",
						async : true,
						data : curform.serializeArray(),
						success : function(data) {
							if ($.trim(data.status) === "y") {
								curform[0].validform_status = "posted";
								Validform.util.showmsg.call(curform, data.info,
										settings.tiptype, {
											obj : curform,
											type : 2,
											sweep : settings.tipSweep
										}, "byajax");
							} else {
								curform[0].validform_status = "normal";
								Validform.util.showmsg.call(curform, data.info,
										settings.tiptype, {
											obj : curform,
											type : 3,
											sweep : settings.tipSweep
										}, "byajax");
							}
							settings.callback && settings.callback(data);
							curform[0].validform_ajax = null;
						},
						error : function(data) {
							var msg = "status: " + data.status
									+ "; statusText: " + data.statusText;
							settings.callback && settings.callback(data);
							curform[0].validform_status = "normal";
							curform[0].validform_ajax = null;
						}
					}
					ajaxsetup = $.extend( {}, localconfig, ajaxsetup, {
						dataType : "json"
					});
					curform[0].validform_ajax = $.ajax(ajaxsetup);
				} else {
					if (!settings.postonce) {
						curform[0].validform_status = "normal";
					}
					var url = url || config.url;
					if (url) {
						curform.attr("action", url);
					}
					return settings.callback && settings.callback(curform);
				}
			}
			return false;
		},
		resetForm : function() {
			var brothers = this;
			brothers.each(function() {
				this.reset();
				this.validform_status = "normal";
			});
			brothers.find(".Validform_right").text("");
			brothers.find(".passwordStrength").children().removeClass(
					"bgStrength");
			brothers.find(".Validform_checktip").removeClass(
					"Validform_wrong Validform_right Validform_loading");
			brothers.find(".Validform_error").removeClass("Validform_error");
			brothers.find("[datatype]").removeData("cked").removeData(
					"dataIgnore").each(function() {
				this.validform_lastval = null;
			});
			brothers.eq(0).find("input:first").focus();
		},
		abort : function() {
			if (this.validform_ajax) {
				this.validform_ajax.abort();
			}
		}
	}
	$.Datatype = Validform.util.dataType;
	Validform.prototype = {
		dataType : Validform.util.dataType,
		eq : function(n) {
			var obj = this;
			if (n >= obj.forms.length) {
				return null;
			}
			if (!(n in obj.objects)) {
				obj.objects[n] = new Validform($(obj.forms[n]).get(),
						obj.settings, true);
			}
			return obj.objects[n];
		},
		resetStatus : function() {
			var obj = this;
			$(obj.forms).each(function() {
				this.validform_status = "normal";
			});
			return this;
		},
		setStatus : function(status) {
			var obj = this;
			$(obj.forms).each(function() {
				this.validform_status = status || "posting";
			});
			return this;
		},
		getStatus : function() {
			var obj = this;
			var status = $(obj.forms)[0].validform_status;
			return status;
		},
		ignore : function(selector) {
			var obj = this;
			var selector = selector || "[datatype]"
			$(obj.forms).find(selector).each(
					function() {
						$(this).data("dataIgnore", "dataIgnore").removeClass(
								"Validform_error");
					});
			return this;
		},
		unignore : function(selector) {
			var obj = this;
			var selector = selector || "[datatype]"
			$(obj.forms).find(selector).each(function() {
				$(this).removeData("dataIgnore");
			});
			return this;
		},
		addRule : function(rule) {
			var obj = this;
			var rule = rule || [];
			for ( var index = 0; index < rule.length; index++) {
				var o = $(obj.forms).find(rule[index].ele);
				for ( var attr in rule[index]) {
					attr !== "ele" && o.attr(attr, rule[index][attr]);
				}
			}
			$(obj.forms).each(
					function() {
						var $this = $(this);
						Validform.util.enhance.call($this,
								obj.settings.tiptype, obj.settings.usePlugin,
								obj.settings.tipSweep, "addRule");
					});
			return this;
		},
		ajaxPost : function(flag, sync, url) {
			var obj = this;
			if (obj.settings.tiptype == 1 || obj.settings.tiptype == 2
					|| obj.settings.tiptype == 3) {
				creatMsgbox();
			}
			Validform.util.submitForm.call($(obj.forms[0]), obj.settings, flag,
					url, "ajaxPost", sync);
			return this;
		},
		submitForm : function(flag, url) {
			var obj = this;
			var subflag = Validform.util.submitForm.call($(obj.forms[0]),
					obj.settings, flag, url);
			subflag === undef && (subflag = true);
			if (subflag === true) {
				obj.forms[0].submit();
			}
			return this;
		},
		resetForm : function() {
			var obj = this;
			Validform.util.resetForm.call($(obj.forms));
			return this;
		},
		abort : function() {
			var obj = this;
			$(obj.forms).each(function() {
				Validform.util.abort.call(this);
			});
			return this;
		},
		check : function(bool, selector) {
			var selector = selector || "[datatype]", obj = this, curform = $(obj.forms), flag = true;
			curform.find(selector).each(
					function() {
						Validform.util.check.call(this, curform, obj, "", bool)
								|| (flag = false);
					});
			return flag;
		},
		config : function(setup) {
			var obj = this;
			setup = setup || {};
			$(obj.forms).each(
					function() {
						this.validform_config = $.extend(true,
								this.validform_config, setup);
					});
			return this;
		}
	}
	$.fn.Validform = function(settings) {
		return new Validform(this, settings);
	};
	function setCenter(obj, time) {
		var left = ($(window).width() - obj.outerWidth()) / 2, top = ($(window)
				.height() - obj.outerHeight()) / 2, top = (document.documentElement.scrollTop ? document.documentElement.scrollTop
				: document.body.scrollTop)
				+ (top > 0 ? top : 0);
		obj.css( {
			left : left
		}).animate( {
			top : top
		}, {
			duration : time,
			queue : false
		});
	}
	function creatMsgbox() {
		if ($("#Validform_msg").length !== 0) {
			return false;
		}
		msgobj = $(
				'<div id="Validform_msg"><div class="Validform_title">' + tipmsg.tit + '<a class="Validform_close" href="javascript:void(0);">&chi;</a></div><div class="Validform_info"></div><div class="iframe"><iframe frameborder="0" scrolling="no" height="100%" width="100%"></iframe></div></div>')
				.appendTo("body");
		msgobj.find("a.Validform_close").click(function() {
			msgobj.hide();
			msghidden = true;
			if (errorobj) {
				errorobj.focus().addClass("Validform_error");
			}
			return false;
		}).focus(function() {
			this.blur();
		});
		$(window).bind("scroll resize", function() {
			!msghidden && setCenter(msgobj, 400);
		});
	}
	;
	$.Showmsg = function(msg) {
		creatMsgbox();
		Validform.util.showmsg.call(win, msg, 1, {});
	};
	$.Hidemsg = function() {
		msgobj.hide();
		msghidden = true;
	};
})(jQuery, window)