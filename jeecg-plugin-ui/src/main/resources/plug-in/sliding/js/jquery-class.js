(function ($){

 _Class=function(){
	var initializing=0,fnTest=/\b_super\b/,
		Class=function(){};
	Class.prototype={
		ops:function(o1,o2){
			o2=o2||{};
			for(var key in o1){
				this['_'+key]=key in o2?o2[key]:o1[key];
			}
		}
	};
	Class.extend=function(prop){
		var _super = this.prototype;
		initializing=1;//锁定初始化,阻止超类执行初始化
		var _prototype=new this();//只是通过此来继承，而非创建类
		initializing=0;//解锁初始化
		function fn(name, fn) {
			return function() {
				this._super = _super[name];//保存超类方法，此this后面通过apply改变成本体类引用
				var ret = fn.apply(this, arguments);//创建方法，并且改变this指向
				return ret;//返回刚才创建的方法
			};
		}
		var _mtd;//临时变量，存方法
		for (var name in prop){//遍历传进来的所有方法
			_mtd=prop[name];
			_prototype[name] =(typeof _mtd=='function'&&
			typeof _super[name]=='function'&&
			fnTest.test(_mtd))?fn(name,_mtd):_mtd;//假如传进来的是函数，进行是否调用超类的检测来决定是否保存超类
		}
		function F(arg1) {//构造函数，假如没有被初始化，并且有初始化函数，执行初始化
			if(this.constructor!=Object){
				return new F({
					FID:'JClassArguments',
					val:arguments
				});
			}
			if (!initializing&&this.init){
				if(arg1&&arg1.FID&&arg1.FID=='JClassArguments'){
					this.init.apply(this, arg1.val);
				}else{
					this.init.apply(this, arguments);
				}
				this.init=null;
			
			};
		}
		F.prototype=_prototype;//创建。。。
		F.constructor=F;//修正用
		F.extend=arguments.callee;
		return F;
	};
	return Class;
 }();
	$.Class=function(ops){
		return _Class.extend(typeof ops=='function'?ops():ops);
	};

})(jQuery);