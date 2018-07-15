/**
 * ichartjs Library v1.0 http://www.ichartjs.com/
 * 
 * @author wanghe
 * @Copyright 2013 wanghetommy@gmail.com Licensed under the Apache License, Version 2.0 (the "License"); 
 * you may not use this file except in compliance with the License. 
 * You may obtain a copy of the License at http://www.apache.org/licenses/LICENSE-2.0
 */
;
(function(window) {
	var ua = navigator.userAgent.toLowerCase(), mc = function(e) {
		return e.test(ua)
	}, ts = Object.prototype.toString, isOpera = mc(/opera/), isChrome = mc(/\bchrome\b/), isWebKit = mc(/webkit/), isSafari = !isChrome && mc(/safari/), isIE = !isOpera && mc(/msie/), supportCanvas = !!document.createElement('canvas').getContext, isGecko = !isWebKit
			&& mc(/gecko/), isMobile = mc(/ipod|ipad|iphone|android/gi), arithmetic = {
		Linear : function(t, b, c, d) {
			return c * t / d + b;
		},
		Cubic : {
			easeIn : function(t, b, c, d) {
				return c * (t /= d) * t * t + b;
			},
			easeOut : function(t, b, c, d) {
				return c * ((t = t / d - 1) * t * t + 1) + b;
			},
			easeInOut : function(t, b, c, d) {
				if ((t /= d / 2) < 1)
					return c / 2 * t * t * t + b;
				return c / 2 * ((t -= 2) * t * t + 2) + b;
			}
		}
	};
	var iChart_ = (function(window) {
		/**
		 * spirit from jquery
		 */
		var isReady = false, readyBound = false, readyList = [], DOMContentLoaded = (function() {
			if (document.addEventListener) {
				return function() {
					document.removeEventListener("DOMContentLoaded", DOMContentLoaded, false);
					ready();
				};
			} else if (document.attachEvent) {
				return function() {
					if (document.readyState === "complete") {
						document.detachEvent("onreadystatechange", DOMContentLoaded);
						ready();
					}
				};
			}
		})(), doScrollCheck = function() {
			if (isReady) {
				return;
			}
			try {
				document.documentElement.doScroll("left");
			} catch (e) {
				setTimeout(doScrollCheck, 1);
				return;
			}
			ready();
		}, ready = function() {
			if (!isReady) {
				isReady = true;
				for ( var i = 0; i < readyList.length; i++) {
					readyList[i].call(document);
				}
				readyList = [];
			}
		}, bindReady = function() {
			if (readyBound)
				return;
			readyBound = true;
			if (document.readyState === "complete") {
				return setTimeout(ready, 1);
			}
			if (document.addEventListener) {
				document.addEventListener("DOMContentLoaded", DOMContentLoaded, false);
				window.addEventListener("load", ready, false);
			} else if (document.attachEvent) {
				document.attachEvent("onreadystatechange", DOMContentLoaded);
				window.attachEvent("onload", ready);
				var toplevel = false;

				try {
					toplevel = window.frameElement == null;
				} catch (e) {
				}

				if (document.documentElement.doScroll && toplevel) {
					doScrollCheck();
				}
			}
		}, bind = function(fn) {
			bindReady();
			if (isReady)
				fn.call(document, _);
			else
				readyList.push(function() {
					return fn.call(this);
				});
		}, _ = function(selector) {
			if (!selector || selector.nodeType) {
				return selector;
			}
			if (typeof selector === "string") {
				if (selector.indexOf("#") != -1) {
					selector = selector.substring(1);
				}
				return document.getElementById(selector);
			}
			if (typeof selector === "function") {
				bind(selector);
			}
		};

		_.apply = function(d, e) {
			if (d && e && typeof e == "object") {
				for ( var a in e) {
					if (typeof e[a] != 'undefined')
						d[a] = e[a]
				}
			}
			if (!e && d) {
				var clone = {};
				for ( var a in d) {
					clone[a] = d[a]
				}
				return clone;
			}
			return d
		};

		_.apply(_, {
			version : "1.0",
			email : 'taylor@ichartjs.com',
			isEmpty : function(C, e) {
				return C === null || C === undefined || ((_.isArray(C) && !C.length)) || (!e ? C === "" : false)
			},
			isArray : function(e) {
				return ts.apply(e) === "[object Array]"
			},
			isDate : function(e) {
				return ts.apply(e) === "[object Date]"
			},
			isObject : function(e) {
				return !!e && ts.apply(e) === "[object Object]"
			},
			isFunction : function(e) {
				return ts.apply(e) === "[object Function]"
			},
			isNumber : function(e) {
				return typeof e === "number" && isFinite(e)
			},
			isString : function(e) {
				return typeof e === "string"
			},
			isBoolean : function(e) {
				return typeof e === "boolean"
			},
			isFalse : function(e) {
				return typeof e === "boolean" && !e;
			},
			isElement : function(e) {
				return e ? !!e.tagName : false
			},
			isDefined : function(e) {
				return typeof e !== "undefined"
			}
		});

		/**
		 * only get the attr that target not exist
		 */
		_.applyIf = function(d, e) {
			if (d && _.isObject(e)) {
				for ( var a in e) {
					if (_.isDefined(e[a]) && !_.isDefined(d[a]))
						d[a] = e[a]
				}
			}
			if (!e && d) {
				return _.apply(d);
			}
			return d
		};
		/**
		 * there will apply a deep clone
		 */
		_.merge = function(d, e, f) {
			if (d && _.isObject(e)) {
				for ( var a in e) {
					if (_.isDefined(e[a])) {
						if (_.isObject(e[a])) {
							if (_.isObject(d[a])) {
								_.merge(d[a], e[a]);
							} else {
								d[a] = _.clone(e[a], true);
							}
						} else {
							d[a] = e[a];
						}
					}
				}
				if (_.isObject(f)) {
					return _.merge(d, f);
				}
			}
			return d;
		};
		/**
		 * clone attribute that given
		 */
		_.clone = function(a, e, deep) {
			var d = {};
			if (_.isArray(a)&& _.isObject(e)) {
				for ( var i = 0; i < a.length; i++) {
					if (deep && _.isObject(e[a[i]]))
						d[a[i]] = _.clone(e[a[i]],deep);
					else
						d[a[i]] = e[a[i]];
				}
			} else if (_.isObject(a)) {
				for ( var b in a) {
					// avoid recursion reference
					if (e && _.isObject(a[b])&& !(a[b] instanceof _.Painter))
						d[b] = _.clone(a[b], e);
					else
						d[b] = a[b];
				}
			}
			return d;
		};

		_.override = function(e, D) {
			if (e&&D) {
				var C = e.prototype;
				_.apply(C, D);
				if (_.isIE && D.hasOwnProperty("toString")) {
					C.toString = D.toString
				}
			}
		};

		/**
		 * spirit from ext2.0
		 */
		_.extend = function() {
			var C = function(E) {
				for ( var D in E) {
					this[D] = E[D];
				}
			};
			var e = Object.prototype.constructor;
			return function(G, O) {
				var J = function() {
					G.apply(this, arguments);
				}
				var E = function() {
				}, H, D = G.prototype;
				E.prototype = D;
				H = J.prototype = new E();
				H.constructor = J;
				J.superclass = D;
				if (D.constructor == e) {
					D.constructor = G;
				}
				J.override = function(F) {
					_.override(J, F);
				};
				H.superclass = H.supr = (function() {
					return D;
				});
				H.override = C;
				_.override(J, O);
				J.extend = function(F) {
					return _.extend(J, F)
				};
				J.plugin_ = {};
				
				J.plugin = function(M,F) {
					if (_.isString(M) && _.isFunction(F))
						J.plugin_[M] = F;
				};
				return J;
			}
		}();

		// *******************Math************************
		var sin = Math.sin, cos = Math.cos, atan = Math.atan, tan = Math.tan, acos = Math.acos, sqrt = Math.sqrt, abs = Math.abs, pi = Math.PI, pi2 = 2 * pi, ceil = Math.ceil, round = Math.round, floor = Math.floor, max = Math.max, min = Math.min, pF = parseFloat,
		factor = function(v, w) {
			if (v == 0)
				return v;
			var M = abs(v),f = 0.1;
			if(M>1){
				while(M>1){
					M = M/10;
					f = f*10;
				}
				return floor(v/f+w)*f;
			}else{
				f = 1;
				while(M<1){
					M = M*10;
					f = f/10;
				}
				return round(v/f+w)*f;
			}
		}, colors = {
			navy : 'rgb(0,0,128)',
			olive : 'rgb(128,128,0)',
			orange : 'rgb(255,165,0)',
			silver : 'rgb(192,192,192)',
			white : 'rgb(255,255,255)',
			gold : 'rgb(255,215,0)',
			lime : 'rgb(0,255,0)',
			fuchsia : 'rgb(255,0,255)',
			aqua : 'rgb(0,255,255)',
			green : 'rgb(0,128,0)',
			gray : 'rgb(80,80,80)',
			red : 'rgb(255,0,0)',
			blue : 'rgb(0,0,255)',
			pink : 'rgb(255,192,203)',
			purple : 'rgb(128,0,128)',
			yellow : 'rgb(255,255,0)',
			maroon : 'rgb(128,0,0)',
			black : 'rgb(0,0,0)',
			azure : 'rgb(240,255,255)',
			beige : 'rgb(245,245,220)',
			brown : 'rgb(165,42,42)',
			cyan : 'rgb(0,255,255)',
			darkblue : 'rgb(0,0,139)',
			darkcyan : 'rgb(0,139,139)',
			darkgrey : 'rgb(169,169,169)',
			darkgreen : 'rgb(0,100,0)',
			darkkhaki : 'rgb(189,183,107)',
			darkmagenta : 'rgb(139,0,139)',
			darkolivegreen : 'rgb(85,107,47)',
			darkorange : 'rgb(255,140,0)',
			darkorchid : 'rgb(153,50,204)',
			darkred : 'rgb(139,0,0)',
			darksalmon : 'rgb(233,150,122)',
			darkviolet : 'rgb(148,0,211)',
			indigo : 'rgb(75,0,130)',
			khaki : 'rgb(240,230,140)',
			lightblue : 'rgb(173,216,230)',
			lightcyan : 'rgb(224,255,255)',
			lightgreen : 'rgb(144,238,144)',
			lightgrey : 'rgb(211,211,211)',
			lightpink : 'rgb(255,182,193)',
			lightyellow : 'rgb(255,255,224)',
			magenta : 'rgb(255,0,255)',
			violet : 'rgb(128,0,128)'
		}, hex2Rgb = function(hex) {
			hex = hex.replace(/#/g, "").replace(/^(\w)(\w)(\w)$/, "$1$1$2$2$3$3");
			return  (hex.length==7?'rgba(':'rgb(') + parseInt(hex.substring(0, 2), 16) + ',' + parseInt(hex.substring(2, 4), 16) + ',' + parseInt(hex.substring(4, 6), 16) + (hex.length==7?',0.'+hex.substring(6,7)+')':')');
		}, i2hex = function(N) {
			return ('0' + parseInt(N).toString(16)).slice(-2);
		}, rgb2Hex = function(rgb) {
			var m = rgb.match(/rgb\((\d+),(\d+),(\d+)\)/);
			return m ? ('#' + i2hex(m[1]) + i2hex(m[2]) + i2hex(m[3])).toUpperCase() : null;
		}, c2a = function(rgb) {
			var result = /rgb\((\w*),(\w*),(\w*)\)/.exec(rgb);
			if (result) {
				return new Array(result[1], result[2], result[3]);
			}
			result = /rgba\((\w*),(\w*),(\w*),(.*)\)/.exec(rgb);
			if (result) {
				return new Array(result[1], result[2], result[3], result[4]);
			}
			throw new Error("invalid colors value '" + rgb + "'");
		}, toHsv = function(r, g, b) {
			if (_.isArray(r)) {
				g = r[1];
				b = r[2];
				r = r[0];
			}
			r = r / 255;
			g = g / 255;
			b = b / 255;
			var m = max(max(r, g), b), mi = min(min(r, g), b), dv = m - mi;
			if (dv == 0) {
				return new Array(0, 0, m);
			}
			var h;
			if (r == m) {
				h = (g - b) / dv;
			} else if (g == m) {
				h = (b - r) / dv + 2;
			} else if (b == m) {
				h = (r - g) / dv + 4;
			}
			h *= 60;
			if (h < 0)
				h += 360;
			return new Array(h, dv / m, m);
		}, toRgb = function(color) {
			if (!color)
				return color;
			color = color.replace(/\s/g, '').toLowerCase();
			// Look for rgb(255,255,255)
			if (/^rgb\([0-9]{1,3},[0-9]{1,3},[0-9]{1,3}\)$/.exec(color)) {
				return color;
			}

			// Look for rgba(255,255,255,0.3)
			if (/^rgba\([0-9]{1,3},[0-9]{1,3},[0-9]{1,3},(0(\.[0-9])?|1(\.0)?)\)$/.exec(color)) {
				return color;
			}

			// Look for #a0b1c2 or #fff
			if (/^#(([a-fA-F0-9]{6,7})|([a-fA-F0-9]{3}))$/.exec(color))
				return hex2Rgb(color);
			// Look a string for green
			if (colors[color])
				return colors[color];
			throw new Error("invalid colors value '" + color + "'");
		}, hsv2Rgb = function(h, s, v, a) {
			if (_.isArray(h)) {
				a = s;
				s = h[1];
				v = h[2];
				h = h[0];
			}
			var r, g, b,
			hi = floor(h / 60) % 6,
			f = h / 60 - hi,
			p = v * (1 - s),
			q = v * (1 - s * f),
			t = v * (1 - s * (1 - f));
			switch (hi) {
				case 0 :
					r = v;
					g = t;
					b = p;
					break;
				case 1 :
					r = q;
					g = v;
					b = p;
					break;
				case 2 :
					r = p;
					g = v;
					b = t;
					break;
				case 3 :
					r = p;
					g = q;
					b = v;
					break;
				case 4 :
					r = t;
					g = p;
					b = v;
					break;
				case 5 :
					r = v;
					g = p;
					b = q;
					break;
			}
			return 'rgb' + (a ? 'a' : '') + '(' + round(r * 255) + ',' + round(g * 255) + ',' + round(b * 255) + (a ? ',' + a + ')' : ')');
		},
		/**
		 * the increment of s(v) of hsv model
		 */ 
		s_inc = 0.05, v_inc = 0.14,
		inc = function(v, iv) {
			iv = iv || v_inc;
			if (v > 0.5) {
				return iv - (1 - v) / 10;
			} else if (v > 0.1) {
				return iv - 0.16 + v / 5;
			} else {
				return v > iv ? iv : v / 2;
			}
		},
		/**
		 * @method anole,make color darker or lighter
		 * @param {Boolean} d true:dark,false:light
		 * @param {Object} rgb:color
		 * @param {Number} iv (0-1)
		 * @param {Number} is (0-1)
		 */
		anole = function(d, rgb, iv, is) {
			if (!rgb)
				return rgb;
			rgb = c2a(toRgb(rgb));
			var hsv = toHsv(rgb);
			is = is!=0?(is || s_inc):is;
			hsv[1] -= is;
			if (d) {
				hsv[2] -= inc(hsv[2], iv);
				hsv[1] = _.upTo(hsv[1], 1);
				hsv[2] = _.lowTo(hsv[2], 0);
			} else {
				hsv[2] += inc((1 - hsv[2]), iv);
				hsv[1] = _.lowTo(hsv[1], 0);
				hsv[2] = _.upTo(hsv[2], 1);
			}
			return hsv2Rgb(hsv, rgb[3]);
		},
		topi = function(v){
			if(v==0)return 0;
			if(v%pi2==0)return pi2;
			return v%pi2;
		};

		_.apply(_, {
			getFont : function(w, s, f) {
				return w + " " + s + "px " + f;
			},
			/**
			 * obtain the Dom Document*/
			getDoc : function() {
				var doc = window.contentWindow ? window.contentWindow.document : window.contentDocument ? window.contentDocument : window.document;
				return doc;
			},
			/**
			 * define the interface,the subclass must implement it
			 */
			DefineAbstract : function(M, H) {
				if (!H[M])
					throw new Error("Cannot instantiate the type '" + H.type + "'.you must implements it with method '" + M + "'.");
			},
			getAA : function(tf) {
				if (tf == 'linear')
					return arithmetic.Linear;
				if (tf == 'easeInOut' || tf == 'easeIn' || tf == 'easeOut')
					return arithmetic.Cubic[tf];
				return arithmetic.Linear;
			},
			/**
			 * simple noConflict implements
			 */
			noConflict : function() {
				return iChart_;
			},
			plugin : function(t, m, f) {
				if (_.isFunction(t))
					t.plugin(m, f);
			},
			parsePadding : function(s, d) {
				s = s || 0;
				if (_.isNumber(s))
					return new Array(s, s, s, s);
				if (_.isArray(s))
					return s;
				d = d || 0;
				s = s.replace(/^\s+|\s+$/g, "").replace(/\s{2,}/g, /\s/).replace(/\s/g, ',').split(",");
				if (s.length == 1) {
					s[0] = s[1] = s[2] = s[3] = pF(s[0]) || d;
				} else if (s.length == 2) {
					s[0] = s[2] = pF(s[0]) || d;
					s[1] = s[3] = pF(s[1]) || d;
				} else if (s.length == 3) {
					s[0] = pF(s[0]) || d;
					s[1] = s[3] = pF(s[1]) || d;
					s[2] = pF(s[2]) || d;
				} else {
					s[0] = pF(s[0]) || d;
					s[1] = pF(s[1]) || d;
					s[2] = pF(s[2]) || d;
					s[3] = pF(s[3]) || d;
				}
				return s;
			},
			/**
			 * the distance of two point
			 */
			distanceP2P : function(x1, y1, x2, y2) {
				return sqrt((x2 - x1) * (x2 - x1) + (y2 - y1) * (y2 - y1));
			},
			atan2Radian : function(ox, oy, x, y) {
				if (ox == x) {
					if (y > oy)
						return pi / 2;
					return pi * 3 / 2;
				}
				if (oy == y) {
					if (x > ox)
						return 0;
					return pi;
				}
				
				var q = _.quadrant(ox, oy, x, y),
					r = atan(abs((oy - y) / (ox - x)));
				
				return q?(q == 3?pi2:pi)+(q == 2?r:-r):r;
			},
			angle2Radian : function(a) {
				return a * pi / 180;
			},
			radian2Angle : function(r) {
				return r * 180 / pi;
			},
			/**
			 * indicate angle in which quadrant,and it different from concept of Math.this will return 0 if it in first quadrant(other eg.0,1,2,3)
			 */
			quadrant : function(ox, oy, x, y) {
				if (ox < x) {
					if (oy < y) {
						return 0;
					} else {
						return 3;
					}
				} else {
					if (oy < y) {
						return 1;
					} else {
						return 2;
					}
				}
			},
			toPI2 : function(a) {
				while(a<0)
					a+=pi2;
				return a%pi2;
			},
			visible:function(s, e, f){
				if(s>e)return [];
				var q1 = _.quadrantd(s),q2 = _.quadrantd(e);
				if((q1==2||q1==3)&&(q2==2||q2==3)&&((e-s)<pi))return[];
				s = _.toPI2(s);
				e = _.toPI2(e);
				if(e<s){e+=pi2;}
				if(s > pi){s = pi2;}
				else if(e>pi2){
					return [{s:s,e:pi,f:f},{s:pi2,e:e,f:f}]
				}else if(e>pi){
					e = pi;
				}
				return {s:s,e:e,f:f};
			},
			quadrantd : function(a) {
				if(a==0)return 0;
				if(a % pi2==0)return 3;
				while(a<0)
					a+=pi2;
				return ceil(2 * (a % pi2) / pi)-1;
			},
			upTo : function(u, v) {
				return v > u ? u : v;
			},
			lowTo : function(l, v) {
				return v < l ? l : v;
			},
			between : function(l, u, v) {
				return v > u ? u : v < l ? l : v;
			},
			inRange : function(l, u, v) {
				return u > v && l < v;
			},
			angleInRange : function(l, u, v) {
				v = (v -l);
				v = v<0?v+pi2:v;
				v = v %pi2;
				return (u -l) > v;
			},
			angleZInRange : function(l, u, v) {
				return u > l?u > v && l < v:(v > l || v < u);
			},
			inRangeClosed : function(l, u, v) {
				return u >= v && l <= v;
			},
			inEllipse : function(x, y, a, b) {
				return (x * x / a / a + y * y / b / b) <= 1;
			},
			p2Point : function(x, y, a, C) {
				return {
					x : x + cos(a) * C,
					y : y + sin(a) * C
				}
			},
			toRgb:toRgb,
			toRgba:function(c,o){
				var rgb = c2a(toRgb(c));
				return  'rgba(' + rgb[0]+',' + rgb[1]+',' + rgb[2]+',' + o +')';
			},
			/**
			 * vector point
			 */
			vectorP2P : function(x, y, radian) {
				if (!radian) {
					y = _.angle2Radian(y);
					x = _.angle2Radian(x);
				}
				y = sin(y);
				return {
					x : y * sin(x),
					y : y * cos(x)
				}
			},
			iGather : function(k) {
				return (k || 'ichartjs') + '-' + ceil(Math.random()*10000)+new Date().getTime().toString().substring(4);
			},
			toPercent : function(v, d) {
				return (v * 100).toFixed(d) + '%';
			},
			parsePercent:function(v,f){
				if(_.isString(v)){
					v = v.match(/(.*)%/);
					if(v){
						return f?floor(pF(v[1])*f/100):v[1]/100;
					}
				}
				return v;
			},
			parseFloat : function(v, d) {
				if (!_.isNumber(v)) {
					v = pF(v);
					if (!_.isNumber(v))
						throw new Error("[" + d +"]=" +v + "is not a valid number.");
				}
				return v;
			},
			ceil : function(max) {
				return factor(max,1);
			},
			floor : function(max, f) {
				return factor(max,-1);
			},
			_2D : '2d',
			_3D : '3d',
			light : function(rgb, iv, is) {
				return anole(false, rgb, iv, is);
			},
			dark : function(rgb, iv, is) {
				return anole(true, rgb, iv, is);
			},
			fixPixel : function(v) {
				return _.isNumber(v) ? v : pF(v.replace('px', "")) || 0;
			},
			toPixel : function(v) {
				return _.isNumber(v) ? v + 'px' : _.fixPixel(v) + 'px';
			},
			emptyFn : function() {
				return true;
			},
			supportCanvas : supportCanvas,
			isOpera : isOpera,
			isWebKit : isWebKit,
			isChrome : isChrome,
			isSafari : isSafari,
			isIE : isIE,
			isGecko : isGecko,
			isMobile : isMobile,
			touch: "ontouchend" in document,
			FRAME : isMobile ? 30 : 60
		});
		
		_.Assert = {
			gt : function(v, c, n) {
				if (!_.isNumber(v) && v >= c)
					throw new Error(n + " required Number gt " + c + ",given:" + v);
			},
			isNumber : function(v, n) {
				if (!_.isNumber(v))
					throw new Error(n + " required Number,given:" + v);
			},
			isArray : function(v, n) {
				if (!_.isArray(v))
					throw new Error(n + " required Array,given:" + v);
			},
			isTrue : function(v, cause) {
				if (v !== true)
					throw new Error(cause);
			}
		};
		/**
		 * shim layer with setTimeout fallback
		 */
		_.requestAnimFrame = (function() {
			var raf = window.requestAnimationFrame || window.webkitRequestAnimationFrame || window.mozRequestAnimationFrame || window.oRequestAnimationFrame || window.msRequestAnimationFrame || function(callback) {
				window.setTimeout(callback, 1000 / 60);
			};
			return function(f){raf(f)}
		})();
		
		
		/**
		 * defined Event
		 */
		_.Event = {
			addEvent : function(ele, type, fn, useCapture) {
				if (ele.addEventListener)
					ele.addEventListener(type, fn, useCapture);
				else if (ele.attachEvent)
					ele.attachEvent('on' + type, fn);
				else
					ele['on' + type] = fn;
			},
			fix : function(e) {
				/**
				 * Fix event for mise
				 */
				if (typeof (e) == 'undefined') {
					e = window.event;
				}
				var E = {
						target:e.target,
						pageX : e.pageX,
						pageY : e.pageY,
						offsetX : e.offsetX,
						offsetY : e.offsetY,
						stopPropagation:false,
						//time: new Date().getTime(),
						event:e
					};
				
				/**
				 * This is mainly for FF which doesn't provide offsetX
				 */
				if (typeof (e.offsetX) == 'undefined') {
					/**
					 * Fix target property, if necessary
					 */
					if (!e.target) {
						E.target = e.srcElement || document;
					}
					
					if(e.targetTouches){
						E.pageX = e.targetTouches[0].pageX;
						E.pageY = e.targetTouches[0].pageY;
					}
					
					/**
					 * Calculate pageX/Y if missing and clientX/Y available
					 */
					if (E.pageX == null && e.clientX != null) {
						var doc = document.documentElement, body = document.body;
						E.pageX = e.clientX + (doc && doc.scrollLeft || body && body.scrollLeft || 0) - (doc && doc.clientLeft || body && body.clientLeft || 0);
						E.pageY = e.clientY + (doc && doc.scrollTop || body && body.scrollTop || 0) - (doc && doc.clientTop || body && body.clientTop || 0);
					}
					
					/**
					 * Browser not with offsetX and offsetY
					 */
					var x = 0, y = 0, obj = e.target;
					while (obj != document.body && obj) {
						x += obj.offsetLeft;
						y += obj.offsetTop;
						obj = obj.offsetParent;
					}
					E.offsetX = E.pageX - x;
					E.offsetY = E.pageY - y;
				}
				
				E.x = E.offsetX;
				E.y = E.offsetY;
				/**
				 * Any browser that doesn't implement stopPropagation() (MSIE)
				 */
				if (!e.stopPropagation) {
					e.stopPropagation = function() {
						window.event.cancelBubble = true;
					}
				}
				
				return E;
		}
		};
		return _;

	})(window);

	/**
	 * Add useful method
	 */
	Array.prototype.each = function(f, s) {
		var j = this.length, r;
		for ( var i = 0; i < j; i++) {
			r = s ? f.call(s, this[i], i) : f(this[i], i);
			if (typeof r === "boolean" && !r) {
				break
			}
		};
		return this;
	};

	Array.prototype.eachAll = function(f, s) {
		this.each(function(d, i) {
			if (iChart_.isArray(d)) {
				return d.eachAll(f, s);
			} else {
				return s ? f.call(s, d, i) : f(d, i);
			}
		}, s);
	};
	
	Array.prototype.sor = function(f) {
		var _=this,L = _.length-1,T; 
		for(var i = 0; i < L; i++){
			for (var j = L; j > i;j--) {
			　　if (f?!f(_[j],_[j - 1]):(_[j] < _[j - 1])){ 
				　　T = _[j]; 　　
					_[j] = _[j - 1]; 　　
					_[j - 1] = T; 
				} 
			} 
		} 
	};
	
	
	window.iChart = iChart_;
	if (!window.$) {
		window.$ = window.iChart;
	}
})(window);

;(function($){
/**
 * @overview This is base class of all element.All must extend this so that has ability for configuration and event
 * this class include some base attribute
 * @component#$.Element
 * @extend#Object
 */
$.Element = function(config) {
	var _ = this._();
	/**
	 * indicate the element's type
	 */
	_.type = 'element';

	/**
	 * define abstract method
	 */
	$.DefineAbstract('configure', _);
	$.DefineAbstract('afterConfiguration', _);

	/**
	 * All of the configuration will in this property
	 */
	_.options = {};

	_.set({
		/**
		 * @inner {String} The unique id of this element (defaults to an auto-assigned id).
		 */
		id : '',
		/**
		 * @cfg {Object} Specifies the border for this element.
		 * Available property are:
		 * @Option enable {boolean} If enable the border
		 * @Option color {String} the border's color.(default to '#BCBCBC')
		 * @Option style {String} the border's style.(default to 'solid')
		 * @Option width {Number/String} the border's width.If given array,the option radius will be 0.(default to 1)
		 * @Option radius {Number/String} the border's radius.(default to 0)
		 */
		border : {
			enable : false,
			color : '#BCBCBC',
			style : 'solid',
			width : 1,
			radius : 0
		},
		/**
		 * @cfg {Boolean} Specifies whether the element should be show a shadow.In general there will be get a high render speed when apply false.(default to false)
		 */
		shadow : false,
		/**
		 * @cfg {String} Specifies the color of your shadow is.(default to '#666666')
		 */
		shadow_color : '#666666',
		/**
		 * @cfg {Number} Specifies How blur you want your shadow to be.(default to 4)
		 */
		shadow_blur : 4,
		/**
		 * @cfg {Number} Specifies Horizontal distance (x-axis) between the shadow and the shape in pixel.(default to 0)
		 */
		shadow_offsetx : 0,
		/**
		 * @cfg {Number} Specifies Vertical distance (y-axis) between the shadow and the shape in pixel.(default to 0)
		 */
		shadow_offsety : 0
	});
	
	/**
	 * variable for short
	 */
	_.W = 'width';
	_.H = 'height';
	_.O = 'top';
	_.B = 'bottom';
	_.L = 'left';
	_.R = 'right';
	_.C = 'center';
	_.X = 'originx';
	_.Y = 'originy';
	/**
	 * the running variable cache
	 */
	_.variable = {};
	
	/**
	 * the container of all events
	 */
	_.events = {
		'mouseup':[],
		'touchstart':[],
		'touchmove':[],
		'touchend':[],
		'mousedown':[],
		'dblclick':[]
	};
	this.registerEvent(
			/**
			 * @event Fires after the element initializing is finished this is for test
			 * @paramter $.Painter#this
			 */
			'initialize');
			
	_.initialization = false;
	
	/**
	 * inititalize configure
	 */
	_.configure.apply(_, Array.prototype.slice.call(arguments, 1));
	
	/**
	 * clone the original config
	 */
	_.default_ = $.clone(_.options,true);
	
	/**
	 * megre customize config
	 */
	_.set(config);
	_.afterConfiguration();
}

$.Element.prototype = {
	_:function(){return this},	
	afterConfiguration : function() {
		/**
		 * register customize event
		 */
		if ($.isObject(this.get('listeners'))) {
			for ( var e in this.get('listeners')) {
				this.on(e, this.get('listeners')[e]);
			}
		}
		this.initialize();
		
		/**
		 * fire the initialize event,this probable use to unit test
		 */
		this.fireEvent(this, 'initialize', [this]);
	},
	registerEvent : function() {
		for ( var i = 0; i < arguments.length; i++) {
			this.events[arguments[i]] = [];
		}
	},
	fireString : function(socpe, name, args, s) {
		var t = this.fireEvent(socpe, name, args);
		return $.isString(t) ? t : (t!==true&&$.isDefined(t)?t.toString():s);
	},
	fireEvent : function(socpe, name, args) {
		var L = this.events[name].length;
		if (L == 1)
			return this.events[name][0].apply(socpe, args);
		var r = true;
		for ( var i = 0; i < L; i++) {
			if(!this.events[name][i].apply(socpe, args))
				r  = false;
		}
		return r;
	},
	on : function(n, fn) {
		if($.isString(n)){
			if (!this.events[n])
				throw new Error('['+this.type+"] invalid event:'" + n + "'");
			this.events[n].push(fn);
		}else if($.isArray(n)){
			n.each(function(c){this.on(c, fn)},this);
		}
		return this;
	},
	getPlugin:function(n){
		return this.constructor.plugin_[n];
	},
	set : function(c) {
		if ($.isObject(c))
			$.merge(this.options, c);
	},
	pushIf : function(name, value) {
		if (!$.isDefined(this.get(name))) {
			return this.push(name, value);
		}
		return this.get(name);
	},
	/**
	 * average write speed about 0.013ms
	 */
	push : function(name, value) {
		var A = name.split("."),L=A.length - 1,V = this.options;
		for (var i = 0; i < L; i++) {
			if (!V[A[i]])
				V[A[i]] = {};
			V = V[A[i]];
		}
		V[A[L]] = value;
		return value;
	},
	/**
	 * average read speed about 0.005ms
	 */
	get : function(name) {
		var A = name.split("."), V = this.options[A[0]];
		for (var i = 1; i < A.length; i++) {
			if (!V)
				return null;
			V = V[A[i]];
		}
		return V;
	}
}
/**
 * @end
 */


/**
 * @overview The interface this class defined d,so the sub class has must capability to draw and aware of event. this class is a abstract class,so you should not try to initialize it.
 * @component#$.Painter
 * @extend#$.Element
 */
$.Painter = $.extend($.Element, {

	configure : function() {
		/**
		 * indicate the element's type
		 */
		this.type = 'painter';

		this.dimension = $._2D;

		/**
		 * define abstract method
		 */
		$.DefineAbstract('commonDraw', this);
		$.DefineAbstract('initialize', this);

		this.set({
			/**
			 * @cfg {String} Specifies the default strokeStyle of the canvas's context in this element.(defaults to 'gray')
			 */
			strokeStyle : 'gray',
			/**
			 * @cfg {Number} Specifies the padding for this element in pixel,the same rule as css padding.(defaults to 10)
			 */
			padding : 10,
			/**
			 * @cfg {String} Specifies the font's color for this element.(defaults to 'black')
			 */
			color : 'black',
			/**
			 * @cfg {Number} Specifies Horizontal offset(x-axis) in pixel.(default to 0)
			 */
			offsetx : 0,
			/**
			 * @cfg {Number}Specifies Vertical distance (y-axis) in pixel.(default to 0)
			 */
			offsety : 0,
			/**
			 * @cfg {String} Specifies the backgroundColor for this element.(defaults to 'FDFDFD')
			 */
			background_color : '#FEFEFE',
			/**
			 * @cfg {float} Specifies the factor make color dark or light for this element,relative to background-color,the bigger the value you set,the larger the color changed.scope{0.01 - 0.5}.(defaults to '0.15')
			 */
			color_factor : 0.15,
			/**
			 * @inner {String} ('2d','3d')
			 */
			style : '',
			/**
			 * @cfg {Object} Here,specify as true by default
			 */
			border : {
				enable : true
			},
			/**
			 * @cfg {Boolean} True to apply the gradient.(default to false)
			 */
			gradient : false,
			/**
			 * @cfg {String} Specifies the gradient mode of background.(defaults to 'LinearGradientUpDown')
			 * @Option 'LinearGradientUpDown'
			 * @Option 'LinearGradientDownUp'
			 * @Option 'LinearGradientLeftRight'
			 * @Option 'LinearGradientRightLeft'
			 * @Option 'RadialGradientOutIn'
			 * @Option 'RadialGradientInOut'
			 */
			gradient_mode:'LinearGradientUpDown',
			/**
			 * @cfg {Number}Specifies the z-index.(default to 0)
			 */
			z_index : 0,
			/**
			 * @cfg {Object} A config object containing one or more event handlers.(default to null)
			 */
			listeners : null,
			/**
			 * @inner {Number} inner use
			 */
			originx : 0,
			/**
			 * @inner {Number} inner use
			 */
			originy : 0
		});

		this.variable.event = {
			mouseover : false
		};
		
		/**
		 * register the common event
		 */
		this.registerEvent(
		/**
		 * @event Fires when this element is clicked
		 * @paramter $.Painter#this
		 * @paramter EventObject#e The click event object
		 * @paramter Object#param The additional parameter
		 */
		'click',
		/**
		 * @event Fires when the mouse move on the element
		 * @paramter $.Painter#this
		 * @paramter EventObject#e The mousemove event object
		 */
		'mousemove',
		/**
		 * @event Fires when the mouse hovers over the element
		 * @paramter $.Painter#this
		 * @paramter EventObject#e The mouseover event object
		 */
		'mouseover',
		/**
		 * @event Fires when the mouse exits the element
		 * @paramter $.Painter#this
		 * @paramter EventObject#e The mouseout event object
		 */
		'mouseout',
		/**
		 * @event Fires before the element drawing.Return false from an event handler to stop the draw.
		 * @paramter $.Painter#this
		 */
		'beforedraw',
		/**
		 * @event Fires after the element drawing when calling the draw method.
		 * @paramter $.Painter#this
		 */
		'draw');
		
		
	},
	is3D : function() {
		return this.dimension == $._3D;
	},
	applyGradient:function(x,y,w,h){
		var _ = this._();
		if(_.get('gradient')){
			_.push('f_color', _.T.gradient(x||_.x||0,y||_.y||0,w||_.get(_.W),h||_.get(_.H),[_.get('dark_color'), _.get('light_color')],_.get('gradient_mode')));
			_.push('light_color', _.T.gradient(x||_.x||0,y||_.y||0,w||_.get(_.W),h||_.get(_.H),[_.get('background_color'), _.get('light_color')],_.get('gradient_mode')));
			_.push('f_color_',_.get('f_color'));
		}
	},
	/**
	 * @method The commnd fire to draw the chart use configuration,
	 * this is a abstract method.Currently known,both <link>$.Chart</link> and <link>$.Component</link> implement this method.
	 * @return void
	 */
	draw : function(e) {
		/**
		 * fire the beforedraw event
		 */
		if (!this.fireEvent(this, 'beforedraw', [this,e])) {
			return this;
		}
		/**
		 * execute the commonDraw() that the subClass implement
		 */
		this.commonDraw(this,e);

		/**
		 * fire the draw event
		 */
		this.fireEvent(this, 'draw', [this,e]);
	},
	doConfig : function() {
		
		var _ = this._(), p = $.parsePadding(_.get('padding')), b = _.get('border.enable'), b = b ? $.parsePadding(_.get('border.width')) : [0, 0, 0, 0], bg = $.toRgb(_.get('background_color')), f = _.get('color_factor'),g=_.get('gradient')?0:null;
		
		_.set({
			border_top:b[0],
			border_right:b[1],
			border_bottom:b[2],
			border_left:b[3],
			hborder:b[1] + b[3],
			vborder:b[0] + b[2],
			padding_top:p[0] + b[0],
			padding_right:p[1] + b[1],
			padding_bottom:p[2] + b[2],
			padding_left:p[3] + b[3],
			hpadding:p[1] + p[3] + b[1] + b[3],
			vpadding:p[0] + p[2] + b[0] + b[2]
		});	
		
		
		if (_.get('shadow')) {
			_.push('shadow', {
				color : _.get('shadow_color'),
				blur : _.get('shadow_blur'),
				offsetx : _.get('shadow_offsetx'),
				offsety : _.get('shadow_offsety')
			});
		}
		
		_.push('f_color', bg);
		_.push('f_color_', bg);
		_.push("light_color", $.light(bg, f,g));
		_.push("dark_color", $.dark(bg, f*0.8,g));
		_.push("light_color2", $.light(bg, f * 2,g));
		
		_.id = _.get('id');
		
		if(_.is3D()&&!_.get('xAngle_')){
			var P = $.vectorP2P(_.get('xAngle'),_.get('yAngle'));
			_.push('xAngle_',P.x);
			_.push('yAngle_',P.y);
		}
	}
});
/**
 * @end
 */

/**
 * 
 * @overview the base class use for Html componment
 * @component#$.Html
 * @extend#$.Element
 */
$.Html = $.extend($.Element,{
	configure : function(T) {
		
		/**
		 * indicate the element's type
		 */
		this.type = 'html';
		
		this.T = T;
		
		/**
		 * define abstract method
		 */
		$.DefineAbstract('beforeshow',this);
		
		this.set({
			 animation:true,
			 /**
			  * @inner Specifies the width of this element in pixels.
			  */
			 width:0,
			 /**
			  * @inner Specifies the height of this element in pixels.
			  */
			 height:0,
			 /**
			 * @cfg {String} Custom style specification to be applied to this element.(default to '')
			 * like this:'padding:10px;font-size:12px'
			 */
			 style:'',
			 /**
			  * @inner The z-index of this element.(default to 999)
			  */
			 index:999,
			 /**
			  * @inner The top of this element.(default to 0)
			  */
			 offset_top:0,
			 /**
			  * @inner The left of this element.(default to 0)
			  */
			 offset_left:0
		});
		
		
		this.transitions = "";
	},
	initialize:function(){
		this.wrap = this.get('wrap');
		this.dom = document.createElement("div");
		
		if(this.get('shadow')){
			this.css('boxShadow',this.get('shadow_offsetx')+'px '+this.get('shadow_offsety')+'px '+this.get('shadow_blur')+'px '+this.get('shadow_color'));
		}
		if(this.get('border.enable')){
			this.css('border',this.get('border.width')+"px "+this.get('border.style')+" "+this.get('border.color'));
			this.css('borderRadius',this.get('border.radius')+"px");
		}
		this.css('zIndex',this.get('index'));
		
		this.applyStyle();
	},
	width:function(){
		return this.dom.offsetWidth;
	},
	height:function(){
		return this.dom.offsetHeight;
	},
	onTransitionEnd:function(fn,useCapture){
		var type = 'transitionend';
		if($.isWebKit){
			type = 'webkitTransitionEnd';
		}else if($.isOpera){
			type = 'oTransitionEnd';
		}
		$.Event.addEvent(this.dom,type,fn,useCapture);
	},
	transition:function(v){
		this.transitions = this.transitions==''?v:this.transitions+','+v;
		if($.isWebKit){
			this.css('WebkitTransition',this.transitions);
		}else if($.isGecko){
			this.css('MozTransition',this.transitions);
		}else if($.isOpera){
			this.css('OTransition',this.transitions);
		}else{
			this.css('transition',this.transitions);
		}
	},
	show:function(e,m){
		this.beforeshow(e,m);
		this.css('visibility','visible');
		if(this.get('animation')){
			this.css('opacity',1);
		}
	},
	hidden:function(e){
		this.css('visibility','hidden');
	},
	getDom:function(){
		return this.dom;
	},
	css:function(k,v){
		if($.isString(k))if($.isDefined(v))this.dom.style[k]=v;else return this.dom.style[k];
	},
	applyStyle:function(){
		var styles  = this.get('style').split(";"),style;
		for(var i = 0;i< styles.length;i++){
			style = styles[i].split(":");
			if(style.length>1)this.css(style[0],style[1]);
		}
	}
});
/**
 * @end
 */
/**
 * @overview this a abstract component of all concrete chart
 * @component#$.Component
 * @extend#$.Painter
 */
$.Component = $.extend($.Painter, {
	configure : function(c) {
		/**
		 * invoked the super class's configuration
		 */
		$.Component.superclass.configure.apply(this, arguments);

		/**
		 * indicate the element's type
		 */
		this.type = 'component';

		this.set({
			/**
			 * @cfg {Number} Specifies the font size of this element in pixels.(default to 12)
			 */
			fontsize : 12,
			/**
			 * @cfg {String} Specifies the font of this element.(default to 'Verdana')
			 */
			font : 'Verdana',
			/**
			 * @cfg {String} Specifies the font weight of this element.(default to 'normal')
			 */
			fontweight : 'normal',
			/**
			 * @inner {Boolean} Specifies the config of Tip.For details see <link>$.Tip</link> Note:this has a extra property named 'enable',indicate whether tip available(default to false)
			 */
			tip : {
				enable : false,
				border : {
					width : 2
				}
			}
		});

		/**
		 * If this element can split or contain others.(default to false)
		 */
		this.atomic = false;
		/**
		 * If method draw be proxy.(default to false)
		 */
		this.proxy = false;
		this.inject(c);
	},
	initialize : function() {
		$.DefineAbstract('isEventValid', this);
		$.DefineAbstract('doDraw', this);
		
		this.doConfig();
		this.initialization = true;
	},
	/**
	 * @method return the component's dimension,return hold following property
	 * @property x:the left-top coordinate-x
	 * @property y:the left-top coordinate-y
	 * @property width:the width of component,note:available there applies box model
	 * @property height:the height of component,note:available there applies box model
	 * @return object
	 */
	getDimension : function() {
		return {
			x : this.x,
			y : this.y,
			width : this.get("width"),
			height : this.get("height")
		}
	},
	doConfig : function() {
		$.Component.superclass.doConfig.call(this);
		var _ = this._();

		_.x = _.push(_.X, _.get(_.X) + _.get('offsetx'));
		_.y = _.push(_.Y, _.get(_.Y) + _.get('offsety'));
		
		_.push('fontStyle', $.getFont(_.get('fontweight'), _.get('fontsize'), _.get('font')));
		
		/**
		 * if have evaluate it
		 */
		_.data = _.get('data');
		
		if (_.get('tip.enable')) {
			/**
			 * make tip's border in accord with sector
			 */
			_.pushIf('tip.border.color', _.get('f_color'));

			if (!$.isFunction(_.get('tip.invokeOffset')))
				/**
				 * indicate the tip must calculate position
				 */
				_.push('tip.invokeOffset', _.tipInvoke());
		}

	},
	isMouseOver : function(e) {
		return this.isEventValid(e,this);
	},
	redraw : function(e) {
		this.container.draw(e);
	},
	commonDraw : function(_) {
		/**
		 * execute the doDraw() that the subClass implement
		 */
		if (!_.proxy)
			_.doDraw.call(_,_);

	},
	inject : function(c) {
		if (c) {
			this.container = c;
			this.target = this.T = c.T;
		}
	}
});
/**
 * @end
 */

 	/**
	 * @overview the tip component.
	 * @component#$.Tip
	 * @extend#$.Element
	 */
	$.Tip = $.extend($.Html,{
		configure:function(){
			
			/**
			 * invoked the super class's configuration
			 */
			$.Tip.superclass.configure.apply(this,arguments);
			
			/**
			 * indicate the legend's type
			 */
			this.type = 'tip';
			
			this.set({
				name:'',
				value:'',
				/**
				 * @cfg {String} Specifies the text want to disply.(default to '')
				 */
				 text:'',
				 /**
					 * @cfg {String} Specifies the tip's type.(default to 'follow') Available value are:
					 * @Option follow
					 * @Option fixed
					 */
				 showType:'follow',
				 /**
					 * @cfg {Function} Specifies Function to calculate the position.(default to null)
					 */
				 invokeOffset:null,
				 /**
					 * @cfg {Number} Specifies the duration when fadeIn/fadeOut in millisecond.(default to 300)
					 */
				 fade_duration:300,
				 /**
					 * @cfg {Number} Specifies the duration when move in millisecond.(default to 100)
					 */
				 move_duration:100,
				 /**
				  * ease
				  * linear
				  * ease-in
				  * ease-out
				  * ease-in-out
				  */
				 timing_function:'ease-out',
				 /**
					 * @cfg {Boolean} if calculate the position every time (default to false)
					 */
				 invokeOffsetDynamic:false,
				 /**
					 * @cfg {String} Specifies the css of this Dom.
					 */
				 style:'textAlign:left;padding:4px 5px;cursor:pointer;backgroundColor:rgba(239,239,239,.85);fontSize:12px;color:black;',
				 /**
					 * @cfg {Object} Override the default as enable = true,radius = 5
					 */
				 border:{
					enable:true,
					radius : 5
				 },
				 delay:200
			});
			this.registerEvent(
					/**
					 * @event Fires when parse this tip's text.Return value will override existing.
					 * @paramter <link>$.Tip</link>#tip
					 * @paramter string#name the current tip's name
					 * @paramter string#value the current tip's value
					 * @paramter string#text the current tip's text
					 * @paramter int#index index of data,if there was a line
					 */
					'parseText');
		},
		position:function(t,l){
			this.style.top =  (t<0?0:t)+"px";
			this.style.left = (l<0?0:l)+"px";
		},
		follow:function(e,m){
			var _ = this._();
			_.style.width = "";
			if(_.get('invokeOffsetDynamic')){
				if(m.hit){
					if($.isString(m.text)||$.isNumber(m.text)){
						_.text(m.name,m.value,m.text,m.i,_);
					}
					var o = _.get('invokeOffset')(_.width(),_.height(),m);
					_.position(o.top,o.left);
				}
			}else{
				if(_.get('showType')!='follow'&&$.isFunction(_.get('invokeOffset'))){
					var o = _.get('invokeOffset')(_.width(),_.height(),m);
					_.position(o.top,o.left);
				}else{
					_.position((e.y-_.height()*1.1-2),e.x+2);
				}
			}
		},
		text:function(n,v,t,i,_){
			_.dom.innerHTML = _.fireString(_, 'parseText', [_,n,v,t,i],t);
		},
		beforeshow:function(e,m){
			this.follow(e,m);
		},
		hidden:function(e){
			if(this.get('animation')){
				this.css('opacity',0);
			}else{
				this.css('visibility','hidden');
			}
		},
		initialize:function(){
			$.Tip.superclass.initialize.call(this);
			
			var _ = this._();
			
			_.css('position','absolute');
			
			_.text(_.get('name'),_.get('value'),_.get('text'),0,_);
			
			_.style = _.dom.style;
			_.hidden();
			
			if(_.get('animation')){
				var m =  _.get('move_duration')/1000+'s '+_.get('timing_function')+' 0s';
				_.transition('opacity '+_.get('fade_duration')/1000+'s '+_.get('timing_function')+' 0s');
				_.transition('top '+m);
				_.transition('left '+m);
				_.onTransitionEnd(function(e){
					if(_.css('opacity')==0){
						_.css('visibility','hidden');
					}
				},false);
			}
			
			_.wrap.appendChild(_.dom);
			
			_.T.on('mouseover',function(c,e,m){
				_.show(e,m);	
			}).on('mouseout',function(c,e,m){
				_.hidden(e);
			});
			
			if(_.get('showType')=='follow'){
				_.T.on('mousemove',function(c,e,m){
					if(_.T.variable.event.mouseover){
						setTimeout(function(){
							if(_.T.variable.event.mouseover)
								_.follow(e,m);
						},_.get('delay'));
					}
				});
			}
		}
});
/**
 * @end
 */


	/**
	 * @overview this element simulate the crosshair on the coordinate.actually this composed of some div of html. 
	 * @component#$.CrossHair
	 * @extend#$.Html
	 */
	$.CrossHair = $.extend($.Html,{
		configure:function(){
		
			/**
			 * invoked the super class's configuration
			 */
			$.CrossHair.superclass.configure.apply(this,arguments);
			
			/**
			 * indicate the component's type
			 */
			this.type = 'crosshair';
			
			this.set({
				/**
				 * @inner {Number} Specifies the position top,normally this will given by chart.(default to 0)
				 */
				 top:0,
				 /**
				 * @inner {Number} Specifies the position left,normally this will given by chart.(default to 0)
				 */
				 left:0,
				 /**
				 * @inner {Boolean} private use
				 */
				 hcross:true,
				  /**
				 * @inner {Boolean} private use
				 */
				 vcross:true,
				 /**
				 * @inner {Function} private use
				 */
				 invokeOffset:null,
				 /**
				 * @cfg {Number} Specifies the linewidth of the crosshair.(default to 1)
				 */
				 line_width:1,
				 /**
				 * @cfg {Number} Specifies the linewidth of the crosshair.(default to 1)
				 */
				 line_color:'#1A1A1A',
				 delay:200
			});
		},
		/**
		 * this function will implement at every target object,and this just default effect
		 */
		follow:function(e,m){
			if(this.get('invokeOffset')){
				var o = this.get('invokeOffset')(e,m);
				if(o&&o.hit){
					this.position(o.top-this.top,o.left-this.left);
				}
				return false;
			}else{
				/**
				 * set the 1px offset will make the line at the top left all the time
				 */
				this.position(e.y-this.top-1,e.x-this.left-1);
			}
			return true;
		},
		position:function(t,l){
			this.horizontal.style.top = (t-this.size)+"px";
			this.vertical.style.left = (l-this.size)+"px";
		},
		beforeshow:function(e,m){
			if(!this.follow(e,m)){
				this.position(-99,-99);
			}
		},
		doCreate:function(_,w,h){
			var d = document.createElement("div");
			d.style.width= $.toPixel(w);
			d.style.height= $.toPixel(h);
			d.style.backgroundColor = _.get('line_color');
			d.style.position="absolute";
			_.dom.appendChild(d);
			return d;
		},
		initialize:function(){
			$.CrossHair.superclass.initialize.call(this);
			
			var _ = this._(),L = $.toPixel(_.get('line_width'));
			
			_.top = $.fixPixel(_.get(_.O));
			_.left = $.fixPixel(_.get(_.L));
			
			_.dom = document.createElement("div");
			
			_.dom.style.zIndex=_.get('index');
			_.dom.style.position="absolute";
			/**
			 * set size zero make integration with vertical and horizontal
			 */
			_.dom.style.width= $.toPixel(0);
			_.dom.style.height=$.toPixel(0);
			_.dom.style.top=$.toPixel(_.get(_.O));
			_.dom.style.left=$.toPixel(_.get(_.L));
			_.css('visibility','hidden');
			
			_.horizontal = _.doCreate(_,_.get('hcross')?$.toPixel(_.get(_.W)):"0px",L);
			_.vertical = _.doCreate(_,L,_.get('vcross')?$.toPixel(_.get(_.H)):"0px");
			_.size = _.get('line_width')/2;
			
			if(_.get('shadow')){
				_.dom.style.boxShadow = _.get('shadowStyle');
			}
			
			_.wrap.appendChild(_.dom);
			
			_.T.on('mouseover',function(c,e,m){
				_.show(e,m);	
			}).on('mouseout',function(c,e,m){
				_.hidden(e,m);	
			}).on('mousemove',function(c,e,m){
				_.follow(e,m);
			});
			
		}
});
/**
 * @end
 */
/**
 * @overview this component use for abc
 * @component#$.Legend
 * @extend#$.Component
 */
$.Legend = $.extend($.Component, {
	configure : function() {
		/**
		 * invoked the super class's configuration
		 */
		$.Legend.superclass.configure.apply(this, arguments);

		/**
		 * indicate the legend's type
		 */
		this.type = 'legend';

		this.set({
			/**
			 * @cfg {Array} Required,The datasource of Legend.Normally,this will given by chart.(default to undefined)
			 */
			data : undefined,
			/**
			 * @inner {Number} Specifies the width.Note if set to 'auto' will be fit the actual width.(default to 'auto')
			 */
			width : 'auto',
			/**
			 * @cfg {Number/String} Specifies the number of column.(default to 1) Note:If set to 'max',the list will be lie on the property row
			 */
			column : 1,
			/**
			 * @cfg {Number/String} Specifies the number of column.(default to 'max') Note:If set to 'max',the list will be lie on the property column
			 */
			row : 'max',
			/**
			 * @cfg {Number} Specifies the limited width.Normally,this will given by chart.(default to 0)
			 */
			maxwidth : 0,
			/**
			 * @cfg {Number} Specifies the lineheight when text display multiline.(default to 16)
			 */
			line_height : 16,
			/**
			 * @cfg {String} Specifies the shape of legend' sign (default to 'square') Available value are：
			 * @Option 'round'
			 * @Option 'square'
			 * @Option 'bar'
			 * @Option 'round-bar'
			 * @Option 'square-bar'
			 */
			sign : 'square',
			/**
			 * @cfg {Number} the size of legend' sign (default to 12)
			 */
			sign_size : 12,
			/**
			 * @cfg {Number} the distance of legend' sign and text (default to 5)
			 */
			sign_space : 5,
			/**
			 * @cfg {Number} Specifies the space between the sign and text.(default to 5)
			 */
			legend_space : 5,
			
			z_index : 1009,
			/**
			 * @cfg {Boolean} If true the text's color will accord with sign's.(default to false)
			 */
			text_with_sign_color : false,
			/**
			 * @cfg {String} Specifies the horizontal position of the legend in chart.(defaults to 'right').Available value are:
			 * @Option 'left'
			 * @Option 'center' Only applies when valign = 'top|bottom'
			 * @Option 'right'
			 */
			align : 'right',
			/**
			 * @cfg {String} this property specifies the vertical position of the legend in an module (defaults to 'middle'). Available value are:
			 * @Option 'top'
			 * @Option 'middle' Only applies when align = 'left|right'
			 * @Option 'bottom'
			 */
			valign : 'middle'
		});

		/**
		 * this element support boxMode
		 */
		this.atomic = true;

		this.registerEvent(
		/**
		 * @event Fires when parse this element'data.Return text value will override existing.
		 * @paramter $.Chart#this
		 * @paramter string#text the text will display
		 * @paramter int#i the index of data
		 * @return string
		 */
		'parse');

	},
	isEventValid : function(e,_) {
		var r = {
			valid : false
		};
		if (e.x > this.x && e.x < (_.x + _.width) && e.y > _.y && e.y < (_.y + _.height)) {
			_.data.each(function(d, i) {
				if (e.x > d.x && e.x < (d.x + d.width_ + _.get('signwidth')) && e.y > d.y && e.y < (d.y + _.get('line_height'))) {
					r = {
						valid : true,
						index : i,
						target : d
					}
					return false;
				}
			}, _);
		}
		return r;
	},
	drawCell : function(x, y, text, color,n,_) {
		var s = _.get('sign_size'),f = _.getPlugin('sign');
		if(!f||!f.call(_,_.T,n,x + s / 2,y,s,color)){
			if(n.indexOf("bar")!=-1){
				_.T.box(x, y - s / 12, s, s / 6, 0, color);
			}
			if(n=='round'){
				_.T.round(x + s / 2, y, s / 2, color);
			}else if(n=='round-bar'){
				_.T.round(x + s / 2, y, s / 4, color);
			}else if (n == 'square-bar') {
				_.T.box(x + s / 4, y - s / 4, s / 2, s / 2, 0, color);
			}else if (n == 'square'){
				_.T.box(x, y-s/2, s, s, 0, color);
			}
		}
		_.T.fillText(text, x + _.get('signwidth'), y, 0, _.get('text_with_sign_color')?color:_.get('color'),'lr',_.get('line_height'));
	},
	doDraw : function(_) {
		_.T.box(_.x, _.y, _.width, _.height, _.get('border'), _.get('f_color'), false, _.get('shadow'));
		_.T.textStyle(_.L, 'middle', $.getFont(_.get('fontweight'), _.get('fontsize'), _.get('font')));
		_.data.each(function(d) {
			_.drawCell(d.x, d.y, d.text, d.color,d.sign,_);
		});
	},
	doLayout:function(_,g){
		var ss = _.get('sign_size'),
			w = 0,
			h=0, 
			temp = 0, 
			c = _.get('column'),
			r = _.get('row'),
			L = _.data.length;
		
		_.T.textFont(_.get('fontStyle'));
		
		if (_.get('line_height') < ss) {
			_.push('line_height', ss + ss / 5);
		}
		_.push('signwidth', (ss + _.get('sign_space')));
		/**
		 * calculate the width each item will used
		 */
		_.data.each(function(d) {
			d.width_ = _.T.measureText(d.text);
		}, _);
		
		/**
		 * calculate the each column's width it will used
		 */
		for ( var i = 0; i < c; i++) {
			temp = 0;
			for ( var j = i; j < L; j+=c) {
				temp = Math.max(temp, _.data[j].width_);
			}
			_.columnwidth[i] = temp;
			w += temp;
		}
		/**
		 * calculate the each row's height it will used
		 */
		for ( var i = 0; i < r; i++) {
			temp =0;
			for ( var j = i*c; j < L; j++) {
				temp = Math.max(temp, _.data[j].text.split("\n").length);
			}
			_.columnheight[i] = temp;
			h+=temp;
		}
		
		w = _.push(_.W, w + _.get('hpadding') + _.get('signwidth') * c + (c - 1) * _.get('legend_space'));
		
		if (w > _.get('maxwidth')) {
			var f = _.get('maxwidth')/w,l2=$.lowTo,o=Math.floor;
			_.push('fontsize', l2(6,o(_.get('fontsize')*f)));
			_.push('sign_size', l2(6,o(ss*f)));
			_.push('sign_space', l2(4,o(_.get('sign_space')*f)));
			_.push('legend_space', l2(4,o(_.get('legend_space')*f)));
			_.push('fontStyle', $.getFont(_.get('fontweight'), _.get('fontsize'), _.get('font')));
			_.doLayout(_,g);
			return;
		}
		
		var d,x,y,y2;
		_.width = w;
		
		_.height = h = _.push(_.H, h * _.get('line_height') + _.get('vpadding'));
		
		if (_.get('valign') == _.O) {
			_.y = g.get('t_originy');
		} else if (_.get('valign') == _.B) {
			_.y = g.get('b_originy') - h;
		} else {
			_.y = g.get('centery') - h / 2;
		}
		if (_.get('align') == _.L) {
			_.x = g.get('l_originx');
		} else if (_.get('align') == _.C) {
			_.x = g.get('centerx') - w / 2;
		} else {
			_.x = g.get('r_originx') - w;
		}
		
		_.x = _.push(_.X, _.x + _.get('offsetx'));
		_.y = _.push(_.Y, _.y + _.get('offsety'));
		
		y = _.y + _.get('padding_top');
		
		ss = _.get('legend_space')+_.get('signwidth');
		/**
		 * calculate the each cell's coordinate point
		 */
		for ( var i = 0; i < r; i++) {
			x = _.x + _.get('padding_left');
			y2=(_.columnheight[i]/2)*_.get('line_height');
			y+=y2;
			for ( var j = 0; j < c&&i*c+j<L; j++) {
				d = _.data[i*c+j];
				d.y = y;
				d.x = x;
				x += _.columnwidth[j] + ss;
			}
			y+=y2;
		}
	},
	doConfig : function() {
		$.Legend.superclass.doConfig.call(this);
		
		var _ = this._(),g = _.container,c = $.isNumber(_.get('column')),r = $.isNumber(_.get('row')), L = _.data.length;
		/**
		 * if the position is incompatible,rectify it.
		 */
		if (_.get('align') == _.C && _.get('valign') == 'middle') {
			_.push('valign', _.O);
		}

		/**
		 * if this position incompatible with container,rectify it.
		 */
		if (g.get('align') == _.L) {
			if (_.get('valign') == 'middle') {
				_.push('align', _.R);
			}
		}
		
		/**
		 * calculate the width each item will used
		 */
		_.data.each(function(d, i) {
			$.merge(d, _.fireEvent(_, 'parse', [_, d.name, i]));
			d.text = d.text || d.name;
			d.sign = d.sign || _.get('sign')
		}, _);
		
		if (!c && !r)
			c = _.push('column',1);
		if (c && !r)
			r = _.push('row', Math.ceil(L / _.get('column')));
		if (!c && r)
			c = _.push('column', Math.ceil(L / _.get('row')));

		c = _.get('column');
		r = _.get('row');
		
		if (L > r * c) {
			r += Math.ceil((L - r * c) / c);
			r = _.push('row', r);
		}
		_.columnwidth = new Array(c);
		_.columnheight = new Array(r);
		
		_.doLayout(_,g);
		
	}
});/** @end */

/**
 * @overview this component use for abc
 * @component#$.Label
 * @extend#$.Component
 */
$.Label = $.extend($.Component, {
	configure : function() {
		/**
		 * invoked the super class's configuration
		 */
		$.Label.superclass.configure.apply(this, arguments);

		/**
		 * indicate the legend's type
		 */
		this.type = 'label';

		this.set({
			/**
			 * @cfg {String} Specifies the text of this label,Normally,this will given by chart.(default to '').
			 */
			text : '',
			/**
			 * @cfg {Number} Specifies the lineheight when text display multiline.(default to 12).
			 */
			line_height : 12,
			/**
			 * @cfg {Number} Specifies the thickness of line in pixel.(default to 1).
			 */
			line_thickness : 1,
			/**
			 * @cfg {String} Specifies the shape of legend' sign (default to 'square').Available value are：
			 * @Option 'round'
			 * @Option 'square'
			 */
			sign : 'square',
			/**
			 * @cfg {Number} Specifies the size of legend' sign in pixel.(default to 12)
			 */
			sign_size : 12,
			/**
			 * @cfg {Number} Override the default as 2 in pixel.
			 */
			padding : '2 5',
			/**
			 * @cfg {Number} Override the default as 2 in pixel.
			 */
			offsety : 2,
			/**
			 * @cfg {Number} Specifies the space between the sign and text.(default to 5)
			 */
			sign_space : 5,
			/**
			 * @cfg {Number} Override the default as '#efefef'.
			 */
			background_color : '#efefef',
			/**
			 * @cfg {Boolean} If true the text's color will accord with sign's.(default to false)
			 */
			text_with_sign_color : false
		});

		/**
		 * this element support boxMode
		 */
		this.atomic = true;

		this.registerEvent();

	},
	isEventValid : function(e,_) {
		return {
			valid : $.inRange(_.labelx, _.labelx + _.get(_.W), e.x) && $.inRange(_.labely, _.labely + _.get(_.H), e.y)
		};
	},
	text : function(text) {
		if (text)
			this.push('text', text);
		this.push(this.W, this.T.measureText(this.get('text')) + this.get('hpadding') + this.get('sign_size') + this.get('sign_space'));
	},
	localizer : function(_) {
		var Q = _.get('quadrantd'),p = _.get('line_points'),m=_.get('smooth'),Q=(Q >= 1 && Q <= 2),x=_.get('labelx'),y=_.get('labely');
		_.labelx = x+(Q ? - _.get(_.W)-m : m);
		_.labely = y-_.get(_.H)/2;
		p[2] = {x:x,y:y};
		p[3] = {x:p[2].x+(Q ? -m : m),y:p[2].y};
	},
	doLayout : function(x, y,n,_) {
		_.push('labelx', _.get('labelx') + x/n);
		_.push('labely', _.get('labely') + y/n);
		
		_.get('line_points').each(function(p,i) {
			p.x += x;
			p.y += y;
			return i==1;
		}, _);
		_.localizer(_);
	},
	doDraw : function(_){
		var p = _.get('line_points'), ss = _.get('sign_size'), x = _.labelx + _.get('padding_left'), y = _.labely + _.get('padding_top');
		
		_.T.label(p, _.get('line_thickness'), _.get('border.color'));
		
		_.T.box(_.labelx, _.labely, _.get(_.W), _.get(_.H), _.get('border'), _.get('f_color'), false, _.get('shadow'));

		_.T.textStyle(_.L, _.O, _.get('fontStyle'));

		var textcolor = _.get('color');
		if (_.get('text_with_sign_color')) {
			textcolor = _.get('scolor');
		}
		if (_.get('sign') == 'square') {
			_.T.box(x, y, ss, ss, 0, _.get('scolor'));
		} else if(_.get('sign')){
			_.T.round(x + ss / 2, y + ss / 2, ss / 2, _.get('scolor'));
		}
		_.T.fillText(_.get('text'), x + ss + _.get('sign_space'), y, _.get('textwidth'), textcolor);
	},
	doConfig : function() {
		$.Label.superclass.doConfig.call(this);
		var _ = this._();

		_.T.textFont(_.get('fontStyle'));

		if (_.get('fontsize') > _.get('line_height')) {
			_.push('line_height', _.get('fontsize'));
		}
		if(!_.get('sign')){
			_.push('sign_size',0);
			_.push('sign_space',0);
		}
		_.push(_.H, _.get('line_height') + _.get('vpadding'));

		_.text();

		_.localizer(_);

	}
});
/**
 * @end
 */

	/**
	 * @overview this component use for abc
	 * @component#$.Text
	 * @extend#$.Component
	 */
	$.Text = $.extend($.Component,{
		configure:function(){
			/**
			 * invoked the super class's  configuration
			 */
			$.Text.superclass.configure.apply(this,arguments);
			
			/**
			 * indicate the component's type
			 */
			this.type = 'text';
			
			this.set({
				/**
				 * @cfg {String} Specifies the text want to disply.(default to '')
				 */
				text:'',
				/**
				 * @cfg {String} there has two layers of meaning,when width is 0,Specifies the textAlign of html5.else this is the alignment of box.(default to 'center')
				 * when width is 0,Available value are:
				 * @Option start
				 * @Option end
				 * @Option left
				 * @Option right
				 * @Option center
				 * when width is not 0,Available value are:
				 * @Option left
				 * @Option right
				 * @Option center
				 */
				textAlign:'center',
				/**
				 * @cfg {String} Here,specify as false to make background transparent.(default to null)
				 */
				background_color : 0,
				/**
				 * @cfg {String} Specifies the textBaseline of html5.(default to 'top')
				 * Available value are:
				 * @Option top
				 * @Option hanging
				 * @Option middle
				 * @Option alphabetic
				 * @Option ideographic
				 * @Option bottom
				 */
				textBaseline:'top',
				/**
				 * @cfg {Object} Here,specify as false by default
				 * @see <link>$.Element#border</link>
				 */
				border : {
					enable : false
				},
				/**
				 * @cfg {Number} Specifies the maxwidth of text in pixels,if given 0 will not be limited.(default to 0)
				 */
				width:0,
				/**
				 * @cfg {Number} Specifies the maxheight of text in pixels,if given 0 will not be limited(default to 0)
				 */
				height:0,
				/**
				 * @cfg {Number} Here,specify as 0 by default
				 */
				padding:0,
				/**
				 * @cfg {String} Specifies the writing-mode of text.(default to 'lr') .
				 * Available value are:
				 * @Option 'lr'
				 */
				writingmode : 'lr',
				/**
				 * @cfg {Number} Specifies the lineheight when text display multiline.(default to 16).
				 */
				line_height : 16,
				/**
				 * @cfg {Number} Specifies the angle that text writed.0 to horizontal,clockwise.(default to 0).
				 */
				rotate:0
			});
			
			this.registerEvent();
			
		},
		doDraw:function(_){
			if(_.get('box_feature'))
			_.T.box(_.x,_.y,_.get(_.W),_.get(_.H),_.get('border'),_.get('f_color'));
			if(_.get('text')!='')
			_.T.text(_.get('text'),_.get('textx'),_.get('texty'),_.get(_.W),_.get('color'),_.get('textAlign'),_.get('textBaseline'),_.get('fontStyle'),_.get('writingmode'),_.get('line_height'),_.get('shadow'),_.get('rotate'));
		},
		isEventValid:function(){
			return {valid:false};
		},
		doLayout:function(x,y,n,_){
			_.x = _.push(_.X,_.x+x);
			_.y = _.push(_.Y,_.y+y);
			_.push('textx',_.get('textx')+x);
			_.push('texty',_.get('texty')+y);
		},
		doConfig:function(){
			$.Text.superclass.doConfig.call(this);
			var _ = this._(),x = _.x,y=_.y+_.get('padding_top'),w=_.get(_.W),h=_.get(_.H),a=_.get('textAlign');
			x+=(a==_.C?w/2:(a==_.R?w-_.get('padding_right'):_.get('padding_left')));
			if(h){
				y+=h/2;
				_.push('textBaseline','middle');
			}
			
			_.push('textx',x);
			_.push('texty',y);
			_.push('box_feature',w&&h);
			
			_.applyGradient();
			
		}
});
/**
 * @end
 */
;
(function($) {

	var PI = Math.PI, inc = PI / 90,inc2 = inc/2, ceil = Math.ceil, floor = Math.floor, PI2 = 2 * PI, max = Math.max, min = Math.min, sin = Math.sin, cos = Math.cos, fd = function(w, c) {
		return w == 1 ? (floor(c) + 0.5) : Math.round(c);
	}, getCurvePoint = function(seg, point, i, smo) {
		var x = point.x, y = point.y, lp = seg[i - 1], np = seg[i + 1], lcx, lcy, rcx, rcy;
		if (i < seg.length - 1) {
			var lastY = lp.y, nextY = np.y, c;
			lcx = (smo * x + lp.x) / (smo + 1);
			lcy = (smo * y + lastY) / (smo + 1);
			rcx = (smo * x + np.x) / (smo + 1);
			rcy = (smo * y + nextY) / (smo + 1);

			c = ((rcy - lcy) * (rcx - x)) / (rcx - lcx) + y - rcy;
			lcy += c;
			rcy += c;

			if (lcy > lastY && lcy > y) {
				lcy = max(lastY, y);
				rcy = 2 * y - lcy;
			} else if (lcy < lastY && lcy < y) {
				lcy = min(lastY, y);
				rcy = 2 * y - lcy;
			}
			if (rcy > nextY && rcy > y) {
				rcy = max(nextY, y);
				lcy = 2 * y - rcy;
			} else if (rcy < nextY && rcy < y) {
				rcy = min(nextY, y);
				lcy = 2 * y - rcy;
			}
			point.rcx = rcx;
			point.rcy = rcy;
		}
		return [lp.rcx || lp.x, lp.rcy || lp.y, lcx || x, lcy || y, x, y];
	},
	pF = function(n){
		return $.isNumber(n)?n:$.parseFloat(n,n);
	},
	simple = function(c) {
		var M,V=0,MI,ML=0,n='minValue',x='maxValue';
		this.total = 0,init=false;
		c.each(function(d,i){
			V  = d.value;
			if($.isArray(V)){
				var T = 0;
				ML = V.length>ML?V.length:ML;
				for(var j=0;j<V.length;j++){
					V[j] = pF(V[j]);
					T+=V[j];
					if(!init){
						M = MI = V[j];
						init=true;
					}
					M = max(V[j],M);
					MI = min(V[j],MI);
				}
				d.total = T;
			}else{
				V = pF(V);
				d.value = V;
				this.total+=V;
				if(!init){
					M = MI = V;
					init=true;
				}
				M = max(V,M);
				MI = min(V,MI);
			}
		},this);
		
		if(this.get(n)){
			MI = min(this.get(n),MI);
		}
		
		if(this.get(x)){
			M = max(this.get(x),M);
		}
		
		if($.isArray(this.get('labels'))){
			ML = this.get('labels').length>ML?this.get('labels').length:ML;
		}
		this.push('maxItemSize',ML);
		this.push(n,MI);
		this.push(x,M);
	},
	complex = function(c){
		var _=this._(),M,MI,V,d,L,init=false;
		_.labels = _.get('labels');
		L =_.labels.length;
		if(L==0){
			L=c[0].value.length;for(var i=0;i<L;i++)_.labels.push("");
		}
		_.columns = [];_.total = 0;
		for(var i=0;i<L;i++){
			var item = [];
			for(var j=0;j<c.length;j++){
				d = c[j];
				V = d.value[i];
				if(!V)continue;
				V =  pF(V,V);
				d.value[i] = V;
				_.total+=V;
				if(!init){
					M = MI = V;
					init=true;
				}
				M = max(V,M);
				MI = min(V,MI);
				item.push({
					name:d.name,
					value:d.value[i],
					color:d.color
				});
			}
			_.columns.push({
				name:_.labels[i],
				item:item
			});
		}
		_.push('minValue',MI); 
		_.push('maxValue',M);
	};
	
	/**
	 * @private support an improved API for drawing in canvas
	 */
	function Cans(c) {
		if (typeof c === "string")
			c = $(c);
		if (!c || !c['tagName'] || c['tagName'].toLowerCase() != 'canvas')
			throw new Error("there not a canvas element");

		this.canvas = c;
		this.c = this.canvas.getContext("2d");
		this.width = this.canvas.width;
		this.height = this.canvas.height;
	}

	Cans.prototype = {
		getContext:function(){
			return this.c;
		},		
		css : function(a, s) {
			if ($.isDefined(s))
				this.canvas.style[a] = s;
			else
				return this.canvas.style[a];
		},
		/**
		 * draw ellipse API
		 */
		ellipse : function(x, y, a, b, s, e, c, bo, bow, boc, sw, ccw, a2r, last) {
			var angle = s,a2r = !!a2r;
			this.save().gCo(last).strokeStyle(bo,bow, boc).shadowOn(sw).fillStyle(c).moveTo(x, y).beginPath();
			
			if (a2r)
				this.moveTo(x, y);
			
			while (angle <= e) {
				this.lineTo(x + a * cos(angle), y + (b * sin(angle)));
				angle += inc;
			}
			return this.lineTo(x + a * cos(e), y + (b * sin(e))).closePath().stroke(bo).fill(c).restore();
		},
		/**
		 * arc
		 */
		arc : function(x, y, r, dw, s, e, c, b, bw, bc, sw, ccw, a2r, last) {
			if(!r)return this;
			var ccw = !!ccw, a2r = !!a2r&&!dw;
			this.save().gCo(last).strokeStyle(b,bw,bc).fillStyle(c).beginPath();
			
			if(dw){
				this.moveTo(x+cos(s)*(r-dw),y+sin(s)*(r-dw)).lineTo(x+cos(s)*r,y+sin(s)*r);
				this.c.arc(x, y, r, s, e,ccw);
				this.lineTo(x+cos(e)*(r-dw),y+sin(e)*(r-dw));
				this.c.arc(x, y, r-dw, e, s,!ccw);
			}else{
				this.c.arc(x, y, r, s, e, ccw);
			}
			
			if (a2r)
				this.lineTo(x, y);
			
			this.closePath();
			
			if(!b){
				this.shadowOn(sw).fill(c);
			}else{
				this.shadowOn(sw).stroke(b).shadowOff().fill(c);
			}
			
			return this.restore();
		},
		/**
		 * draw sector
		 */
		sector : function(x, y, r, dw,s, e, c, b, bw, bc, sw, ccw) {
			if (sw)
				this.arc(x, y, r, dw, s, e, c,0,0,0,sw,ccw, true, true);
			return this.arc(x, y, r, dw, s, e, c, b, bw, bc, false, ccw, true);
		},
		sector3D : function() {
			var x0, y0,sPaint = function(x, y, a, b, s, e, ccw, h, c) {
				var Lo = function(A, h) {
					this.lineTo(x + a * cos(A), y + (h || 0) + (b * sin(A)));
				},
				angle = s;
				this.fillStyle($.dark(c)).moveTo(x + a * cos(s), y + (b * sin(s))).beginPath();
				while (angle <= e) {
					Lo.call(this, angle);
					angle = angle + inc;
				}
				Lo.call(this, e);
				this.lineTo(x + a * cos(e), (y + h) + (b * sin(e)));
				angle = e;
				while (angle >= s) {
					Lo.call(this, angle, h);
					angle = angle - inc;
				}
				Lo.call(this, s, h);
				this.lineTo(x + a * cos(s), y + (b * sin(s))).closePath().fill(true);
			}, layerDraw = function(x, y, a, b, ccw, h, A, c) {
				var x0 = x + a * cos(A);
				var y0 = y + h + (b * sin(A));
				this.moveTo(x, y).beginPath().fillStyle(c).lineTo(x, y + h).lineTo(x0, y0).lineTo(x0, y0 - h).lineTo(x, y).closePath().fill(true);
			}, layerPaint = function(x, y, a, b, s, e, ccw, h, c) {
				var q1 = $.quadrantd(s),q2 = $.quadrantd(e);
				c = $.dark(c);
				if (q1==1||q1==2)
					layerDraw.call(this, x, y, a, b, ccw, h, s, c);
				if (q2==0||q2==3)
					layerDraw.call(this, x, y, a, b, ccw, h, e, c);
			};
			var s3 = function(x, y, a, b, s, e, h, c, bo, bow, boc, sw, ccw, isw) {
				/**
				 * paint bottom layer
				 */
				this.ellipse(x, y + h, a, b, s, e, c, bo, bow, boc, sw, ccw, true);
				/**
				 * paint inside layer
				 */
				layerPaint.call(this, x, y, a, b, s, e, ccw, h, c);

				/**
				 * paint top layer
				 */
				this.ellipse(x, y, a, b, s, e, c, bo, bow, boc, false, ccw, true);
				/**
				 * paint outside layer
				 */
				sPaint.call(this, x, y, a, b, s, e, ccw, h, c);
				
				
				return this;
			}
			s3.layerPaint = layerPaint;
			s3.sPaint = sPaint;
			s3.layerDraw = layerDraw;
			return s3;
		}(),
		textStyle : function(a, l, f) {
			return this.textAlign(a).textBaseline(l).textFont(f);
		},
		strokeStyle : function(b,w, c, j) {
			if(b){
				if (w)
					this.c.lineWidth = w;
				if (c)
					this.c.strokeStyle = c;
				if (j)
					this.c.lineJoin = j;
			}
			return this;
		},
		globalAlpha : function(v) {
			if (v)
				this.c.globalAlpha = v;
			return this;
		},
		fillStyle : function(c) {
			if (c)
				this.c.fillStyle = c;
			return this;
		},
		arc2 : function(x, y, r, s, e, c) {
			if(r)
			this.c.arc(x, y, r, s, e, c);
			return this;
		},
		textAlign : function(a) {
			if (a)
				this.c.textAlign = a;
			return this;
		},
		textBaseline : function(l) {
			if (l)
				this.c.textBaseline = l;
			return this;
		},
		textFont : function(font) {
			if (font)
				this.c.font = font;
			return this;
		},
		shadowOn : function(s) {
			if (s) {
				this.c.shadowColor = s.color;
				this.c.shadowBlur = s.blur;
				this.c.shadowOffsetX = s.offsetx;
				this.c.shadowOffsetY = s.offsety;
			}
			return this;
		},
		shadowOff : function() {
			this.c.shadowColor = 'white';
			this.c.shadowBlur = this.c.shadowOffsetX = this.c.shadowOffsetY = 0;
			return this;
		},
		gradient : function(x, y, w, h, c,m) {
			m = m.toLowerCase();
			var x0=x,y0=y,f=!m.indexOf("linear");
			m = m.substring(14);
			if(f){
				switch(m)
			   　　{
			　　   case 'updown':
			 　　    y0+=h;
			 　　    break;
			　　   case 'downup':
			　　    y+=h;
			　　     break;
			   	 case 'leftright':
			 　　    x0+=w;
			 　　    break;
			　　   case 'rightleft':
				  x+=w;
			　　     break;
			　　   default:
			　　     return c[0];
			　　   }
				return this.avgLinearGradient(x,y,x0,y0,c);
			}else{
				x+=w/2;
				y+=h/2;
				if(m=='outin'){
					c.reverse();
				}
				return this.avgRadialGradient(x,y,0,x,y,(w>h?h:w)*0.8,c);
			}
		},
		avgLinearGradient : function(xs, ys, xe, ye, c) {
			var g = this.createLinearGradient(xs, ys, xe, ye);
			for ( var i = 0; i < c.length; i++)
				g.addColorStop(i / (c.length - 1), c[i]);
			return g;
		},
		createLinearGradient : function(xs, ys, xe, ye) {
			return this.c.createLinearGradient(xs, ys, xe, ye);
		},
		avgRadialGradient : function(xs, ys, rs, xe, ye, re, c) {
			var g = this.createRadialGradient(xs, ys, rs, xe, ye, re);
			for ( var i = 0; i < c.length; i++)
				g.addColorStop(i / (c.length - 1), c[i]);
			return g;
		},
		createRadialGradient : function(xs, ys, rs, xe, ye, re) {
			return this.c.createRadialGradient(xs, ys, rs, xe, ye, re);
		},
		text : function(t, x, y, max, color, align, line, font, mode, h,sw,ro) {
			if(t=='')return this;
			return this.save().textStyle(align, line, font).fillText(t, x, y, max, color, mode, h,sw,ro).restore();
		},
		fillText : function(t, x, y, max, color, mode, h,sw,ro) {
			t = t.toString();
			max = max || false;
			mode = mode || 'lr';
			h = h || 16;
			var T = t.split(mode == 'tb' ? "" : "\n");
			if(T.length>1){
				if(this.c.textBaseline=='middle'){
					y = y - (T.length-1)*h/2;
				}else if(this.c.textBaseline=='bottom'){
					y = y - (T.length-1)*h;
				}
			}
			this.save().fillStyle(color).translate(x,y).rotate(inc2*ro).shadowOn(sw);
			T.each(function(t,i) {
				try {
					if (max)
						this.c.fillText(t, 0,i*h, max);
					else
						this.c.fillText(t, 0, i*h);
				} catch (e) {
					console.log(e.message + '[' + t + ',' + x + ',' + y + ']');
				}
			}, this);
			
			return this.restore();
		},
		measureText : function(t){
			t = t.split("\n");
			var m=0;
			t.each(function(o){
				m = max(this.measureText(o).width,m);
			},this.c);
			return m;
		},
		moveTo : function(x, y) {
			x = x || 0;
			y = y || 0;
			this.c.moveTo(x, y);
			return this;
		},
		lineTo : function(x, y) {
			x = x || 0;
			y = y || 0;
			this.c.lineTo(x, y);
			return this;
		},
		save : function() {
			this.c.save();
			return this;
		},
		restore : function() {
			this.c.restore();
			return this;
		},
		beginPath : function() {
			this.c.beginPath();
			return this;
		},
		closePath : function() {
			this.c.closePath();
			return this;
		},
		stroke : function(s) {
			if(s)
			this.c.stroke();
			return this;
		},
		fill : function(f) {
			if(f)
			this.c.fill();
			return this;
		},
		/**
		 * can use cube3D instead of this?
		 */
		cube : function(x, y, xv, yv, width, height, zdeep, bg, b, bw, bc, sw) {
			x = fd(bw, x);
			y = fd(bw, y);
			zdeep = (zdeep && zdeep > 0) ? zdeep : width;
			var x1 = x + zdeep * xv, y1 = y - zdeep * yv;
			x1 = fd(bw, x1);
			y1 = fd(bw, y1);
			/**
			 * styles -> top-front-right
			 */
			if (sw) {
				this.polygon(bg, b, bw, bc, sw, false, [{x:x, y:y},{x: x1, y:y1},{x: x1 + width, y:y1},{x: x + width, y:y}]);
				this.polygon(bg, b, bw, bc, sw, false, [{x:x, y:y},{x: x, y:y + height},{x: x + width,y: y + height},{x: x + width, y:y}]);
				this.polygon(bg, b, bw, bc, sw, false, [{x:x + width, y:y},{x: x1 + width, y:y1},{x: x1 + width, y:y1 + height},{x: x + width, y:y + height}]);
			}
			/**
			 * clear the shadow on the body
			 */
			this.polygon($.dark(bg), b, bw, bc, false, false, [{x:x, y:y}, {x:x1, y:y1}, {x:x1 + width, y:y1}, {x:x + width, y:y}]);
			this.polygon(bg, b, bw, bc, false, false, [{x:x, y:y}, {x:x, y:y + height}, {x:x + width, y:y + height}, {x:x + width,y: y}]);
			this.polygon($.dark(bg), b, bw, bc, false, false, [{x:x + width, y:y}, {x:x1 + width, y:y1}, {x:x1 + width, y:y1 + height}, {x:x + width, y:y + height}]);
			return this;
		},
		cube3D : function(x, y, rotatex, rotatey, angle, w, h, zh, b, bw, bc, styles) {
			/**
			 * styles -> lowerBottom-bottom-left-right-top-front
			 */
			x = fd(bw, x);
			y = fd(bw, y);
			zh = (!zh || zh == 0) ? w : zh;

			if (angle) {
				var P = $.vectorP2P(rotatex, rotatey);
				rotatex = x + zh * P.x, rotatey = y - zh * P.y;
			} else {
				rotatex = x + zh * rotatex, rotatey = y - zh * rotatey;
			}

			while (styles.length < 6)
				styles.push(false);

			rotatex = fd(bw, rotatex);
			rotatey = fd(bw, rotatey);

			var side = [];

			if (rotatey < 0) {
				if ($.isObject(styles[4]))
					side.push($.applyIf({
						points : [{x:x,y:y - h},{x:rotatex,y:rotatey - h},{x:rotatex + w, y:rotatey - h},{x: x + w, y:y - h}]
					}, styles[4]));
			} else {
				if ($.isObject(styles[0]))
					side.push($.applyIf({
						points : [{x:x, y:y},{x: rotatex, y:rotatey},{x: rotatex + w, y:rotatey},{x: x + w,y:y}]
					}, styles[0]));
			}

			if ($.isObject(styles[1]))
				side.push($.applyIf({
					points : [{x:rotatex, y:rotatey},{x: rotatex, y:rotatey - h}, {x:rotatex + w, y:rotatey - h},{x: rotatex + w,y:rotatey}]
				}, styles[1]));

			if ($.isObject(styles[2]))
				side.push($.applyIf({
					points : [{x:x, y:y}, {x:x, y:y - h},{x: rotatex, y:rotatey - h},{x: rotatex, y:rotatey}]
				}, styles[2]));

			if ($.isObject(styles[3]))
				side.push($.applyIf({
					points : [{x:x + w, y:y}, {x:x + w, y:y - h}, {x:rotatex + w, y:rotatey - h}, {x:rotatex + w, y:rotatey}]
				}, styles[3]));

			if (rotatey < 0) {
				if ($.isObject(styles[0]))
					side.push($.applyIf({
						points : [{x:x,y: y}, {x:rotatex, y:rotatey}, {x:rotatex + w, y:rotatey}, {x:x + w, y:y}]
					}, styles[0]));
			} else {
				if ($.isObject(styles[4]))
					side.push($.applyIf({
						points : [{x:x, y:y - h}, {x:rotatex, y:rotatey - h}, {x:rotatex + w, y:rotatey - h}, {x:x + w, y:y - h}]
					}, styles[4]));
			}

			if ($.isObject(styles[5]))
				side.push($.applyIf({
					points : [{x:x, y:y}, {x:x, y:y - h}, {x:x + w, y:y - h}, {x:x + w, y:y}]
				}, styles[5]));
			
			side.each(function(s) {
				this.polygon(s.color, b, bw, bc, s.shadow, s.alpha, s.points);
			}, this);
			
			return this;
		},
		polygon : function(bg, b, bw, bc, sw, alpham, p, smooth, smo,l) {
			this.save().strokeStyle(b,bw, bc).beginPath().fillStyle(bg).globalAlpha(alpham).shadowOn(sw).moveTo(p[0].x,p[0].y);
			if (smooth) {
				this.moveTo(fd(bw,l[0].x),fd(bw,l[0].y)).lineTo(fd(bw, p[0].x), fd(bw, p[0].y));
				for ( var i = 1; i < p.length; i++)
					this.bezierCurveTo(getCurvePoint(p, p[i], i, smo));
				this.lineTo(fd(bw,l[1].x),fd(bw,l[1].y));
			} else {
				for ( var i = 1; i < p.length; i++)
					this.lineTo(fd(bw, p[i].x), fd(bw, p[i].y));
			}
			return this.closePath().stroke(b).fill(bg).restore();
		},
		lines : function(p, w, c, last) {
			this.save().gCo(last).beginPath().strokeStyle(true,w, c).moveTo(fd(w, p[0]), fd(w, p[1]));
			for ( var i = 2; i < p.length - 1; i += 2) {
				this.lineTo(fd(w, p[i]), fd(w, p[i + 1]));
			}
			return this.stroke(true).restore();
		},
		bezierCurveTo : function(r) {
			this.c.bezierCurveTo(r[0], r[1], r[2], r[3], r[4], r[5]);
			return this;
		},
		label : function(p, w, c) {
			return this.save()
				.beginPath()
				.strokeStyle(true,w, c)
				.moveTo(fd(w, p[0].x), fd(w, p[0].y))
				.bezierCurveTo([p[1].x,p[1].y,p[2].x,p[2].y,p[3].x,p[3].y])
				.stroke(true)
				.restore();
		},
		lineArray : function(p, w, c, smooth, smo) {
			this.save().beginPath().strokeStyle(true,w, c).moveTo(fd(w, p[0].x), fd(w, p[0].y));
			for ( var i = 1; i < p.length; i++){
				if (smooth) {
					this.bezierCurveTo(getCurvePoint(p, p[i], i, smo || 1.5));
				} else {
					this.lineTo(fd(w, p[i].x), fd(w, p[i].y));
				}
			}
			return this.stroke(true).restore();
		},
		manyLine : function(p, w, c, smooth, smo) {
			var T = [],Q  = false;
			smo = smo || 1.5;
			p.each(function(p0){
				if(p0.ignored&&Q){
					this.lineArray(T, w, c, smooth, smo);
					T = [];
					Q = false;
				}else if(!p0.ignored){
					T.push(p0);
					Q = true;
				}
			},this);
			if(T.length){
				this.lineArray(T, w, c, smooth, smo);
			}
		},
		dotted : function(x1, y1, x2, y2, w, c,L,f,last) {
			if (!w)
				return this;
			x1 = fd(w, x1);
			y1 = fd(w, y1);
			x2 = fd(w, x2);
			y2 = fd(w, y2);
			var d = $.distanceP2P(x1, y1, x2, y2),t;
			if(L<=0||d<=L||(x1!=x2&&y1!=y2)){
				return this.line(x1, y1, x2, y2, w, c, last);
			}
			if(x1>x2||y1>y2){
				t = x1;
				x1 = x2;
				x2 = t;
				t = y1;
				y1 = y2;
				y2 = t;
			}
			this.save().gCo(last).strokeStyle(true,w, c).beginPath().moveTo(x1,y1);
			var S = L*(f || 1),g = floor(d/(L+S)),k = (d-g*(L+S))>L,h=(y1==y2);
			g = k?g+1:g;
			for(var i=1;i<=g;i++){
				this.lineTo(h?x1+L*i+S*(i-1):x1,h?y1:y1+L*i+S*(i-1)).moveTo(h?x1+(L+S)*i:x1, h?y1:y1+(L+S)*i);
			}
			if(!k){
				this.lineTo(x2,y2);
			}
			return this.stroke(true).restore();
		},
		line : function(x1, y1, x2, y2, w, c, last) {
			if (!w)
				return this;
			this.save().gCo(last);
			return this.beginPath().strokeStyle(true,w, c).moveTo(fd(w, x1), fd(w, y1)).lineTo(fd(w, x2), fd(w, y2)).stroke(true).restore();
		},
		round : function(x, y, r, c, bw, bc) {
			return this.arc(x, y, r,0, 0, PI2, c, !!bc, bw, bc);
		},
		fillRect : function(x, y, w, h) {
			this.c.fillRect(x, y, w, h);
			return this;
		},
		translate : function(x, y) {
			this.c.translate(x, y);
			return this;
		},
		rotate : function(r) {
			this.c.rotate(r);
			return this;
		},
		clearRect : function(x, y, w, h) {
			x = x || 0;
			y = y || 0;
			w = w || this.width;
			h = h || this.height;
			this.c.clearRect(x, y, w, h);
			return this;
		},
		gCo : function(l) {
			if(l)
			return this.gCO(l);
			return this;
		},
		gCO : function(l) {
			this.c.globalCompositeOperation = l ? "destination-over" : "source-over";
			return this;
		},
		box : function(x, y, w, h, b, bg, shadow, m,last) {
			b = b || {
				enable : 0
			}
			if (b.enable) {
				var j = b.width, c = b.color, r = b.radius, f = $.isNumber(j);
				j = $.parsePadding(j);
				if(j[0]==j[1]&&j[1]==j[2]&&j[2]==j[3]){
					f = true;
				}
				m = m?1:-1;
				w += m*(j[1] + j[3]) / 2;
				h += m*(j[0] + j[2]) / 2;
				x -= m*(j[3] / 2);
				y -= m*(j[0] / 2);
				j = f ? j[0] : j;
				r = (!f ||!r|| r == 0 || r == '0') ? 0 : $.parsePadding(r);
			}
			
			this.save().gCo(last).fillStyle(bg).strokeStyle(f,j, c);
			/**
			 * draw a round corners border
			 */
			if (r) {
				this.beginPath().moveTo(fd(j,x+r[0]), fd(j, y))
				.lineTo(fd(j,x+w - r[1]), fd(j, y))
				.arc2(fd(j,x+w - r[1]), fd(j, y+r[1]), r[1], PI*3/2, PI2)
				.lineTo(fd(j, x+w), fd(j,y+h - r[2]))
				.arc2(fd(j,x+w - r[2]), fd(j, y+h-r[2]), r[2], 0, PI/2)
				.lineTo(fd(j,x+r[3]), fd(j, y+h))
				.arc2(fd(j,x+r[3]), fd(j, y+h-r[3]), r[3], PI/2, PI)
				.lineTo(fd(j,x), fd(j,y+r[0]))
				.arc2(fd(j,x+r[0]), fd(j, y+r[0]), r[0], PI, PI*3/2)
				.closePath().shadowOn(shadow).stroke(j).shadowOff().fill(bg);
			} else {
				if (!b.enable || f) {
					if (j&&b.enable){
						this.shadowOn(shadow).c.strokeRect(x, y, w, h);
						this.shadowOff();
					}
					if (bg)
						this.fillRect(x, y, w, h);
				} else {
					if(j){
						c = $.isArray(c) ? c : [c, c, c, c];
						this.shadowOn(shadow).line(x+w, y+j[0] / 2, x+w, y+h - j[0] / 2, j[1], c[1], 0).line(x, y+j[0] / 2, x, y+h - j[0] / 2, j[3], c[3], 0).line(floor(x-j[3] / 2),y, x+w + j[1] / 2, y, j[0], c[0], 0).line(floor(x-j[3] / 2), y+h, x+w + j[1] / 2, y+h, j[2], c[2], 0).shadowOff();
					}
					if (bg) {
						this.beginPath().moveTo(floor(x+j[3] / 2), floor(y+j[0] / 2)).lineTo(ceil(x+w - j[1] / 2), y+j[0] / 2).lineTo(ceil(x+w - j[1] / 2), ceil(y+h - j[2] / 2)).lineTo(floor(x+j[3] / 2), ceil(y+h - j[2] / 2)).lineTo(floor(x+j[3] / 2), floor(y+j[0] / 2)).closePath().fill(bg);
					}
				}

			}
			return this.restore();
		},
		toDataURL : function(g) {
			return this.canvas.toDataURL(g || "image/png");
		},
		addEvent : function(type, fn, useCapture) {
			$.Event.addEvent(this.canvas, type, fn, useCapture);
		}
	}
	
	/**
	 * the public method,inner use
	 */
	$.taylor = {
		light:function(_,e){
			e.highlight = false;
			_.on('mouseover',function(){
				e.highlight = true;
				_.redraw('mouseover');
			}).on('mouseout',function(){
				e.highlight = false;
				_.redraw('mouseout');
			}).on('beforedraw',function(){
				_.push('f_color',e.highlight?_.get('light_color'):_.get('f_color_'));
				return true;
			});
		}	
	}
	
	/**
	 * @overview this component use for abc
	 * @component#$.Chart
	 * @extend#$.Painter
	 */
	$.Chart = $.extend($.Painter, {
		/**
		 * @cfg {TypeName}
		 */
		configure : function() {
			/**
			 * invoked the super class's configuration
			 */
			$.Chart.superclass.configure.apply(this, arguments);

			/**
			 * indicate the element's type
			 */
			this.type = 'chart';
			/**
			 * indicate the data structure
			 */
			this.dataType = 'simple';

			this.set({
				render : '',
				/**
				 * @cfg {Array} Required,The datasource of Chart.must be not empty.
				 */
				data : [],
				/**
				 * @cfg {Number} Specifies the width of this canvas
				 */
				width : undefined,
				/**
				 * @cfg {Number} Specifies the height of this canvas
				 */
				height : undefined,
				/**
				 * @cfg {String} Specifies the default lineJoin of the canvas's context in this element.(defaults to 'round')
				 */
				lineJoin : 'round',
				/**
				 * @cfg {String} this property specifies the horizontal alignment of chart in an module (defaults to 'center') Available value are:
				 * @Option 'left'
				 * @Option 'center'
				 * @Option 'right'
				 */
				align : 'center',
				/**
				 * @cfg {Boolean} If true mouse change to a pointer when a mouseover fired.only available when use PC.(defaults to true)
				 */
				default_mouseover_css : true,
				/**
				 * @cfg {Boolean} If true ignore the event touchmove.only available when support touchEvent.(defaults to false)
				 */
				turn_off_touchmove : false,
				/**
				 * @cfg {Boolean} Specifies as true to display with percent.(default to false)
				 */
				showpercent : false,
				/**
				 * @cfg {Number} Specifies the number of decimal when use percent.(default to 1)
				 */
				decimalsnum : 1,
				/**
				 * @cfg {Object/String} Specifies the config of Title details see <link>$.Text</link>,If given a string,it will only apply the text.note:If the text is empty,then will not display
				 */
				title : {
					text : '',
					fontweight : 'bold',
					/**
					 * Specifies the font-size in pixels of title.(default to 20)
					 */
					fontsize : 20,
					/**
					 * Specifies the height of title will be take.(default to 30)
					 */
					height : 30
				},
				/**
				 * @cfg {Object/String}Specifies the config of subtitle details see <link>$.Text</link>,If given a string,it will only apply the text.note:If the title or subtitle'text is empty,then will not display
				 */
				subtitle : {
					text : '',
					fontweight : 'bold',
					/**
					 * Specifies the font-size in pixels of title.(default to 16)
					 */
					fontsize : 16,
					/**
					 * Specifies the height of title will be take.(default to 20)
					 */
					height : 20
				},
				/**
				 * @cfg {Object/String}Specifies the config of footnote details see <link>$.Text</link>,If given a string,it will only apply the text.note:If the text is empty,then will not display
				 */
				footnote : {
					text : '',
					/**
					 * Specifies the font-color of footnote.(default to '#5d7f97')
					 */
					color : '#5d7f97',
					textAlign : 'right',
					/**
					 * Specifies the height of title will be take.(default to 20)
					 */
					height : 20
				},
				/**
				 * @inner {String} Specifies how align title horizontally Available value are:
				 * @Option 'left'
				 * @Option 'center'
				 * @Option 'right'
				 */
				title_align : 'center',
				/**
				 * @inner {String} Specifies how align title vertically Available value are:
				 * @Option 'top'
				 * @Option 'middle' Only applies when title_writingmode = 'tb'
				 * @Option 'bottom'
				 */
				title_valign : 'top',
				/**
				 * @cfg {Boolean} If true element will have a animation when show, false to skip the animation.(default to false)
				 */
				animation : false,
				/**
				 * @Function {Function} the custom funtion for animation.(default to null)
				 */
				doAnimation : null,
				/**
				 * @cfg {String} (default to 'ease-in-out') Available value are:
				 * @Option 'easeIn'
				 * @Option 'easeOut'
				 * @Option 'easeInOut'
				 * @Option 'linear'
				 */
				animation_timing_function : 'easeInOut',
				/**
				 * @cfg {Number} Specifies the duration when animation complete in millisecond.(default to 1000)
				 */
				duration_animation_duration : 1000,
				/**
				 * @cfg {Number} Specifies the chart's z_index.override the default as 999 to make it at top layer.(default to 999)
				 */
				z_index:999,
				/**
				 * @cfg {Object}Specifies the config of Legend.For details see <link>$.Legend</link> Note:this has a extra property named 'enable',indicate whether legend available(default to false)
				 */
				legend : {
					enable : false
				},
				/**
				 * @cfg {Object} Specifies the config of Tip.For details see <link>$.Tip</link> Note:this has a extra property named 'enable',indicate whether tip available(default to false)
				 */
				tip : {
					enable : false
				}
			});

			/**
			 * register the common event
			 */
			this.registerEvent(
			/**
			 * @event Fires before this element Animation.Only valid when <link>animation</link> is true
			 * @paramter $.Chart#this
			 */
			'beforeAnimation',
			/**
			 * @event Fires when this element Animation finished.Only valid when <link>animation</link> is true
			 * @paramter $.Chart#this
			 */
			'afterAnimation', 'animating');

			this.T = null;
			this.RENDERED = false;
			this.animationed = false;
			this.data = [];
			this.plugins = [];
			this.oneways = [];
			this.total = 0;
		},
		toDataURL : function(g) {
			return this.T.toDataURL(g);
		},
		segmentRect : function() {
			this.T.clearRect(this.get('l_originx'), this.get('t_originy'), this.get('client_width'), this.get('client_height'));
		},
		resetCanvas : function() {
			this.T.box(this.get('l_originx'), this.get('t_originy'), this.get('client_width'), this.get('client_height'),0,this.get('f_color'),0,0,true);
		},
		animation : function(_) {
			/**
			 * clear the part of canvas
			 */
			_.segmentRect();
			
			/**
			 * doAnimation of implement
			 */
			_.doAnimation(_.variable.animation.time, _.duration,_);
			/**
			 * draw plugins
			 */
			if(_.legend)
			_.legend.draw();
			/**
			 * draw plugins
			 */
			_.plugins.each(function(p){
				if(p.A_draw){
					p.variable.animation.animating =true;
					p.variable.animation.time =_.variable.animation.time;
					p.variable.animation.duration =_.duration;
					p.draw();
					p.variable.animation.animating =false;
				}
			});
			
			/**
			 * fill the background
			 */
			_.resetCanvas();
			if (_.variable.animation.time < _.duration) {
				_.variable.animation.time++;
				$.requestAnimFrame(function() {
					_.animation(_);
				});
			} else {
				$.requestAnimFrame(function() {
					_.variable.animation.time = 0;
					_.animationed = true;
					_.draw();
					_.processAnimation = false;
					_.fireEvent(_, 'afterAnimation', [_]);
				});
			}
		},
		runAnimation : function() {
			this.fireEvent(this, 'beforeAnimation', [this]);
			this.animation(this);
		},
		doSort:function(){
			this.components.sor(function(p, q){
				return ($.isArray(p)?(p.zIndex||0):p.get('z_index'))>($.isArray(q)?(q.zIndex||0):q.get('z_index'))});
		},
		commonDraw : function(_,e) {
			$.Assert.isTrue(_.RENDERED, _.type + ' has not rendered.');
			$.Assert.isTrue(_.initialization, _.type + ' has initialize failed.');
			$.Assert.gt(_.data.length,0,_.type + '\'s data is empty.');
			
			if (!_.redraw) {
				_.doSort();
				_.oneways.eachAll(function(o) {o.draw()});
			}
			_.redraw = true;
			
			if (!_.animationed && _.get('animation')) {
				_.runAnimation();
				return;
			}
			
			_.segmentRect();

			_.components.eachAll(function(c) {
				c.draw(e);
			});
			
			_.resetCanvas();

		},
		/**
		 * @method register the customize component
		 * @paramter <link>$.Custom</link>#component 
		 * @return void
		 */
		plugin : function(c) {
			c.inject(this);
			this.components.push(c);
			this.plugins.push(c);
		},
		/**
		 * @method return the title,return undefined if unavailable
		 * @return <link>$.Text</link>#the title object
		 */
		getTitle:function(){
			return this.title;
		},
		/**
		 * @method return the subtitle,return undefined if unavailable
		 * @return <link>$.Text</link>#the subtitle object
		 */
		getSubTitle:function(){
			return this.subtitle;
		},
		/**
		 * @method return the footnote,return undefined if unavailable
		 * @return <link>$.Text</link>#the footnote object
		 */
		getFootNote:function(){
			return this.footnote;
		},
		/**
		 * @method return the main Drawing Area's dimension,return following property:
		 * x:the left-top coordinate-x
		 * y:the left-top coordinate-y
		 * width:the width of drawing area
		 * height:the height of drawing area
		 * @return Object#contains dimension info
		 */
		getDrawingArea:function(){
			return {
				x:this.get("l_originx"),
				x:this.get("t_originy"),
				width:this.get("client_width"),
				height:this.get("client_height")
			}
		},
		/**
		 * @method set up the chart by latest configruation
		 * @return void
		 */
		setUp:function(){
			this.redraw = false;
			this.T.clearRect();
			this.initialization = false;
			this.initialize();
		},
		create : function(_,shell) {
			/**
			 * fit the window
			 */
			if(_.get('fit')){
				var w = window.innerWidth,
			    	h = window.innerHeight,
			    	style = $.getDoc().body.style;
			    style.padding = "0px";
			    style.margin = "0px";
			    style.overflow = "hidden";
			    _.push(_.W, w);
			    _.push(_.H, h);
			}
			
			/**
			 * did default should to calculate the size of warp?
			 */
			_.width = _.pushIf(_.W, 400);
			_.height = _.pushIf(_.H, 300);
			_.canvasid = $.iGather(_.type);
			_.shellid = "shell-"+_.canvasid;
			
			var H = [];
			H.push("<div id='");
			H.push(_.shellid);
			H.push("' style='width:");
			H.push(_.width);
			H.push("px;height:");
			H.push(_.height);
			H.push("px;padding:0px;margin:0px;overflow:hidden;position:relative;'>");
			H.push("<canvas id= '");
			H.push(_.canvasid);
			H.push("'  width='");
			H.push(_.width);
			H.push("' height='");
			H.push(_.height);
			H.push("'><p>Your browser does not support the canvas element</p></canvas></div>");
			/**
			 * also use appendChild()
			 */
			shell.innerHTML = H.join("");
			
			_.shell = $(_.shellid);
			
			/**
			 * the base canvas wrap for draw
			 */
			_.T = _.target = new Cans(_.canvasid);
			
			_.RENDERED = true;
		},
		initialize : function() {
			
			var _ = this._(),d = _.get('data'),r = _.get('render');
			/**
			 * create dom
			 */
			if (!_.RENDERED) {
				if (typeof r == "string" && $(r))
					_.create(_,$(r));
				else if (typeof r == 'object')
					_.create(_,r);
			}
			/**
			 * set up
			 */
			if (d.length > 0 && _.RENDERED && !_.initialization){
				if(_.dataType=='simple'){
					simple.call(_,d);
				}else if(_.dataType=='complex'){
					complex.call(_,d);
				}
				_.data = d;
				_.doConfig();
				_.initialization = true;
			}
		},
		/**
		 * @method turn off the event listener
		 * @return void
		 */
		eventOff:function(){this.stopEvent = true},
		/**
		 * @method turn on the event listener
		 * @return void
		 */
		eventOn:function(){this.stopEvent = false},
		/**
		 * this method only invoked once
		 */
		oneWay:function(_){
			
			var E = _.variable.event,tot=!_.get('turn_off_touchmove'), mCSS = !$.touch&&_.get('default_mouseover_css'), O, AO,events = $.touch?['touchstart','touchmove']:['click','mousemove'];
			
			_.stopEvent = false;
			
			events.each(function(it) {
				_.T.addEvent(it, function(e) {
					if (_.processAnimation||_.stopEvent)
						return;
					
					if(e.targetTouches&&e.targetTouches.length!=1){
						return;
					}
					_.fireEvent(_, it, [_, $.Event.fix(e)]);
				}, false);
			});
			_.on(events[0], function(_, e) {
				_.components.eachAll(function(C) {
					var M = C.isMouseOver(e);
					if (M.valid){
						E.click = true;
						C.fireEvent(C,'click', [C, e, M]);
						return !e.stopPropagation;
					}
				});
				if(E.click){
					if(tot)
					e.event.preventDefault();
					E.click = false;
				}
			});
			
			if(!$.touch||tot)
			_.on(events[1], function(_, e) {
				O = AO = false;
				_.components.eachAll(function(cot) {
						var cE = cot.variable.event, M = cot.isMouseOver(e);
						if (M.valid) {
							O = true;
							AO = AO || cot.atomic;
							if (!E.mouseover) {
								E.mouseover = true;
								_.fireEvent(_, 'mouseover', [cot,e, M]);
							}
							
							if (mCSS && AO) {
								_.T.css("cursor", "pointer");
							}
							
							if (!cE.mouseover) {
								cE.mouseover = true;
								cot.fireEvent(cot, 'mouseover', [cot,e, M]);
							}
							cot.fireEvent(cot, 'mousemove', [cot,e, M]);
							if(M.stop){
								return false;
							}
						} else {
							if (cE.mouseover) {
								cE.mouseover = false;
								cot.fireEvent(cot, 'mouseout', [cot,e, M]);
							}
						}
						return !e.stopPropagation;
				});
				
				if(E.mouseover){
					e.event.preventDefault();
					if (mCSS && !AO) {
						_.T.css("cursor", "default");
					}
					if (!O && E.mouseover) {
						E.mouseover = false;
						_.fireEvent(_, 'mouseout', [_,e]);
					}
				}
			});
			_.oneWay = $.emptyFn;
		},
		getPercent:function(v){
			return this.get('showpercent') ? $.toPercent(v / this.total, this.get('decimalsnum')) : v;
		},
		doActing:function(_,d,o,i,t){
			var f=!!_.get('communal_acting');
			/**
			 * store or restore the option
			 */
			_.push(f?'sub_option':'communal_acting',$.clone(_.get(f?'communal_acting':'sub_option'),true));
			/**
			 * merge the option
			 */
			$.merge(_.get('sub_option'),d);
			
			/**
			 * merge specific option
			 */
			$.merge(_.get('sub_option'),o);
			
			/**
			 * prevent there no property background_color,use coloe instead
			 */
			_.pushIf('sub_option.background_color', d.color);
			
			if (_.get('sub_option.tip.enable')){
				_.push('sub_option.tip.text',t || (d.name + ' ' +_.getPercent(d.value)));
				_.push('sub_option.tip.name',d.name);
				_.push('sub_option.tip.value',d.value);
				_.push('sub_option.tip.total',_.total);
			}
			
		},
		doConfig : function() {
			
			$.Chart.superclass.doConfig.call(this);
			
			var _ = this._();
			
			$.Assert.isArray(_.data);
				
			_.T.strokeStyle(true,0, _.get('strokeStyle'), _.get('lineJoin'));

			_.processAnimation = _.get('animation');
			
			/**
			 * for store the option of each item in chart
			 */
			_.push('communal_acting',0);
			
			_.duration = ceil(_.get('duration_animation_duration') * $.FRAME / 1000);
			if($.isFunction(_.get('doAnimation'))){
				_.doAnimation = _.get('doAnimation');
			}
			_.variable.animation = {
				type : 0,
				time : 0,
				queue : []
			};
			
			_.components = [];
			_.oneways = [];
			
			/**
			 * push the background in it
			 */
			_.oneways.push(new $.Custom({
				drawFn:function(){
					_.T.box(0, 0, _.width, _.height, _.get('border'), _.get('f_color'),0,0,true);
				}
			}));
			
			/**
			 * make sure hold the customize plugin 
			 */
			_.plugins.each(function(o){
				_.components.push(o);
			});
			
			_.applyGradient();
			
			_.animationArithmetic = $.getAA(_.get('animation_timing_function'));
			
			/**
			_.on('afterAnimation', function() {
				var N = _.variable.animation.queue.shift();
				if (N) {
					_[N.handler].apply(_, N.arguments);
				}
			});
			*/
			
			_.oneWay(_);
			
			_.push('r_originx', _.width - _.get('padding_right'));
			_.push('b_originy', _.height - _.get('padding_bottom'));
			
			var H = 0, l = _.push('l_originx', _.get('padding_left')), t = _.push('t_originy', _.get('padding_top')), w = _.push('client_width', (_.get(_.W) - _.get('hpadding'))), h;

			if ($.isString(_.get('title'))) {
				_.push('title', $.applyIf({
					text : _.get('title')
				}, _.default_.title));
			}
			if ($.isString(_.get('subtitle'))) {
				_.push('subtitle', $.applyIf({
					text : _.get('subtitle')
				}, _.default_.subtitle));
			}
			if ($.isString(_.get('footnote'))) {
				_.push('footnote', $.applyIf({
					text : _.get('footnote')
				}, _.default_.footnote));
			}

			if (_.get('title.text') != '') {
				var st = _.get('subtitle.text') != '';
				H = st ? _.get('title.height') + _.get('subtitle.height') : _.get('title.height');
				t = _.push('t_originy', t + H);
				_.push('title.originx', l);
				_.push('title.originy', _.get('padding_top'));
				_.push('title.width', w);
				_.title = new $.Text(_.get('title'), _);
				_.oneways.push(_.title);
				if (st) {
					_.push('subtitle.originx', l);
					_.push('subtitle.originy', _.get('title.originy') + _.get('title.height'));
					_.push('subtitle.width', w);
					_.subtitle = new $.Text(_.get('subtitle'), _);
					_.oneways.push(_.subtitle);
				}
			}

			if (_.get('footnote.text') != '') {
				var g = _.get('footnote.height');
				H += g;
				_.push('b_originy', _.get('b_originy') - g);
				_.push('footnote.originx', l);
				_.push('footnote.originy', _.get('b_originy'));
				_.push('footnote.width', w);
				_.footnote = new $.Text(_.get('footnote'), _);
				_.oneways.push(_.footnote);
			}

			h = _.push('client_height', (_.get(_.H) - _.get('vpadding') - H));

			_.push('minDistance', min(w, h));
			_.push('maxDistance', max(w, h));
			_.push('minstr', w < h ? _.W : _.H);

			_.push('centerx', l + w / 2);
			_.push('centery', t + h / 2);
			
			/**
			 * clone config to sub_option
			 */
			$.applyIf(_.get('sub_option'), $.clone(['shadow', 'shadow_color', 'shadow_blur', 'shadow_offsetx', 'shadow_offsety','tip'], _.options,true));
			/**
			 * legend
			 */
			if (_.get('legend.enable')) {
				_.legend = new $.Legend($.apply({
					maxwidth : w,
					data : _.data
				}, _.get('legend')), _);
				_.components.push(_.legend);
			}
			_.push('sub_option.tip.wrap',_.push('tip.wrap', _.shell));
			
		}
	});
})($);
/**
 * @end
 */


	/**
	 * @overview this component use for abc
	 * @component#$.Custom
	 * @extend#$.Component
	 */
	$.Custom = $.extend($.Component,{
		configure:function(){
			/**
			 * invoked the super class's  configuration
			 */
			$.Custom.superclass.configure.apply(this,arguments);
			
			/**
			 * indicate the component's type
			 */
			this.type = 'custom';
			
			this.set({
				
				/**
				 * @cfg {Function} Specifies the customize function.(default to emptyFn)
				 */
				drawFn:$.emptyFn,
				/**
				 * @cfg {Function} Specifies the customize event valid function.(default to undefined)
				 */
				eventValid:undefined,
				/**
				 * @cfg {Boolean} If true when chart animating it also invoke darw.(default to true)
				 */
				animating_draw:true
			});
			
			this.registerEvent();
			
		},
		doDraw:function(_){
			_.get('drawFn').call(_,_);
		},
		isEventValid:function(e,_){
			if($.isFunction(this.get('eventValid')))
			return this.get('eventValid').call(this,e,_);
			return {valid:false};
		},
		doConfig:function(){
			$.Custom.superclass.doConfig.call(this);
			this.A_draw = this.get('animating_draw');
			this.variable.animation = {
				animating:false,	
				time : 0,
				duration:0
			};
		}
});
/**
 * @end
 */
/**
 * @overview this is inner use for axis
 * @component#$.Scale
 * @extend#$.Component
 */
$.Scale = $.extend($.Component, {
	configure : function() {

		/**
		 * invoked the super class's configuration
		 */
		$.Scale.superclass.configure.apply(this, arguments);

		/**
		 * indicate the component's type
		 */
		this.type = 'scale';

		this.set({
			/**
			 * @cfg {String} Specifies alignment of this scale.(default to 'left')
			 */
			position : 'left',
			/**
			 * @cfg {String} the axis's type(default to 'h') Available value are:
			 * @Option 'h' :horizontal
			 * @Option 'v' :vertical
			 */
			which : 'h',
			/**
			 * @cfg {Number} Specifies value of Baseline Coordinate.(default to 0)
			 */
			basic_value:0,
			/**
			 * @cfg {Boolean} indicate whether the grid is accord with scale.(default to true)
			 */
			scale2grid : true,
			/**
			 * @inner {Number}
			 */
			distance : undefined,
			/**
			 * @cfg {Number} Specifies the start coordinate scale value.(default to 0)
			 */
			start_scale : 0,
			/**
			 * @cfg {Number} Specifies the end coordinate scale value.Note either this or property of max_scale must be has the given value.(default to undefined)
			 */
			end_scale : undefined,
			/**
			 * @cfg {Number} Specifies the chart's minimal value
			 */
			min_scale : undefined,
			/**
			 * @cfg {Number} Specifies the chart's maximal value
			 */
			max_scale : undefined,
			/**
			 * @cfg {Number} Specifies the space of two scale.Note either this or property of scale_share must be has the given value.(default to undefined)
			 */
			scale_space : undefined,
			/**
			 * @cfg {Number} Specifies the number of scale on axis.(default to 5)
			 */
			scale_share : 5,
			/**
			 * @cfg {Boolean} True to display the scale line.(default to true)
			 */
			scale_enable : true,
			/**
			 * @cfg {Number} Specifies the size of brush(context.linewidth).(default to 1)
			 */
			scale_size : 1,
			/**
			 * @cfg {Number} Specifies the width(length) of scale.(default to 4)
			 */
			scale_width : 4,
			/**
			 * @cfg {String} Specifies the color of scale.(default to 4)
			 */
			scale_color : '#333333',
			/**
			 * @cfg {String} Specifies the align against axis.(default to 'center') When the property of which set to 'h',Available value are:
			 * @Option 'left'
			 * @Option 'center'
			 * @Option 'right' 
			 * When the property of which set to 'v', Available value are:
			 * @Option 'top'
			 * @Option 'center'
			 * @Option 'bottom'
			 */
			scaleAlign : 'center',
			/**
			 * @cfg {Array} the customize labels
			 */
			labels : [],
			/**
			 * @cfg {<link>$.Text</link>} Specifies label's option.
			 */
			label : {},
			/**
			 * @cfg {Number} Specifies the distance to scale.(default to 6)
			 */
			text_space : 6,
			/**
			 * @cfg {String} Specifies the align against axis.(default to 'left' or 'bottom' in v mode) When the property of which set to 'h',Available value are:
			 * @Option 'left'
			 * @Option 'right' When the property of which set to 'v', Available value are:
			 * @Option 'top'
			 * @Option 'bottom'
			 */
			textAlign : 'left',
			/**
			 * @cfg {Number} Specifies the number of decimal.this will change along with scale.(default to 0)
			 */
			decimalsnum : 0,
			/**
			 * @inner {String} the style of overlapping(default to 'none') Available value are:
			 * @Option 'square'
			 * @Option 'round'
			 * @Option 'none'
			 */
			join_style : 'none',
			/**
			 * @inner {Number}
			 */
			join_size : 2
		});

		this.registerEvent(
		/**
		 * @event Fires the event when parse text,you can return a object like this:{text:'',originx:100,originy:100} to override the given.
		 * @paramter string#text item's text
		 * @paramter int#originx coordinate-x of item's text
		 * @paramter int#originy coordinate-y of item's text
		 * @paramter int#index item's index
		 * @paramter boolean#last If last item
		 */
		'parseText');

	},
	isEventValid : function() {
		return {
			valid : false
		};
	},
	/**
	 * from left to right,top to bottom
	 */
	doDraw : function(_) {
		if (_.get('scale_enable'))
			_.items.each(function(item) {
				_.T.line(item.x0, item.y0, item.x1, item.y1, _.get('scale_size'), _.get('scale_color'), false);
			});
		_.labels.each(function(l) {
			l.draw();
		});
	},
	doLayout:function(x,y,_){
		if (_.get('scale_enable'))
			_.items.each(function(item) {
				item.x0+=x;
				item.y0+=y;
				item.x1+=x;
				item.y1+=y;
			});
		_.labels.each(function(l) {
			l.doLayout(x,y,0,l);
		});
	},
	doConfig : function() {
		$.Scale.superclass.doConfig.call(this);
		$.Assert.isNumber(this.get('distance'), 'distance');

		var _ = this._(),abs = Math.abs,customL = _.get('labels').length, min_s = _.get('min_scale'), max_s = _.get('max_scale'), s_space = _.get('scale_space'), e_scale = _.get('end_scale'), start_scale = _.get('start_scale');

		_.items = [];
		_.labels = [];
		_.number = 0;

		if (customL > 0) {
			_.number = customL - 1;
		} else {
			$.Assert.isTrue($.isNumber(max_s) || $.isNumber(e_scale), 'max_scale&end_scale');
			/**
			 * end_scale must greater than maxScale
			 */
			if (!$.isNumber(e_scale) || e_scale < max_s) {
				e_scale = _.push('end_scale', $.ceil(max_s));
			}
			/**
			 * startScale must less than minScale
			 */
			if (start_scale > min_s) {
				start_scale = _.push('start_scale', $.floor(min_s));
			}
			
			
			if (s_space && abs(s_space) < abs(e_scale - start_scale)) {
				_.push('scale_share', (e_scale - start_scale) / s_space);
			}
			
			_.number = _.push('scale_share', abs(_.get('scale_share')));
			
			/**
			 * value of each scale
			 */
			if (!s_space || s_space >( e_scale - start_scale)) {
				s_space = _.push('scale', (e_scale - start_scale) / _.get('scale_share'));
			}
			
			if (parseInt(s_space)!=s_space && _.get('decimalsnum') == 0) {
				var dec = s_space+"";
				dec =  dec.substring(dec.indexOf('.')+1);
				_.push('decimalsnum', dec.length);
			}
		}
		
		/**
		 * the real distance of each scale
		 */
		_.push('distanceOne', _.get('valid_distance') / _.number);

		var text, x, y, x1 = 0, y1 = 0, x0 = 0, y0 = 0, tx = 0, ty = 0, w = _.get('scale_width'), w2 = w / 2, sa = _.get('scaleAlign'), ta = _.get('position'), ts = _.get('text_space'), tbl = '',aw = _.get('coo').get('axis.width');
		
		_.push('which', _.get('which').toLowerCase());
		_.isH = _.get('which') == 'h';
		if (_.isH) {
			if (sa == _.O) {
				y0 = -w;
			} else if (sa == _.C) {
				y0 = -w2;
				y1 = w2;
			} else {
				y1 = w;
			}

			if (ta == _.O) {
				ty = -ts-aw[0];
				tbl = _.B;
			} else {
				ty = ts+aw[2];
				tbl = _.O;
			}
			ta = _.C;
		} else {
			if (sa == _.L) {
				x0 = -w;
			} else if (sa == _.C) {
				x0 = -w2;
				x1 = w2;
			} else {
				x1 = w;
			}
			tbl = 'middle';
			if (ta == _.R) {
				ta = _.L;
				tx = ts+aw[1];
			} else {
				ta = _.R;
				tx = -ts-aw[3];
			}
		}
		/**
		 * valid width only applies when there is h,then valid_height only applies when there is v
		 */
		for ( var i = 0; i <= _.number; i++) {
			text = customL ? _.get('labels')[i] : (s_space * i + start_scale).toFixed(_.get('decimalsnum'));
			x = _.isH ? _.get('valid_x') + i * _.get('distanceOne') : _.x;
			y = _.isH ? _.y : _.get('valid_y') + _.get('distance') - i * _.get('distanceOne');

			_.items.push({
				x : x,
				y : y,
				x0 : x + x0,
				y0 : y + y0,
				x1 : x + x1,
				y1 : y + y1
			});

			/**
			 * put the label into a Text?
			 */
			_.labels.push(new $.Text($.applyIf($.apply(_.get('label'), $.merge({
				text : text,
				x : x,
				y : y,
				originx : x + tx,
				originy : y + ty
			}, _.fireEvent(_, 'parseText', [text, x + tx, y + ty, i, _.number == i]))), {
				textAlign : ta,
				textBaseline : tbl
			}), _));

			/**
			 * maxwidth = Math.max(maxwidth, _.T.measureText(text));
			 */
		}
	}
});

/**
 * @end
 */
$.Coordinate = {
	coordinate_ : function() {
		var _ = this._(),scale = _.get('coordinate.scale'),li=_.get('scaleAlign'),f=true;
		if($.isObject(scale)){
			scale = [scale];
		}
		if($.isArray(scale)){
			scale.each(function(s){
				if(s.position ==li){
					f  = false;
					return false;
				}
			});
			if(f){
				if(li==_.L){
					li = _.R;
				}else if(li==_.R){
					li = _.L;
				}else if(li==_.O){
					li = _.B;
				}else{
					li = _.O;
				}
				_.push('scaleAlign',li);
			}
			scale.each(function(s){
				if(s.position ==li){
					if(!s.start_scale)
						s.min_scale = _.get('minValue');
					if(!s.end_scale)
						s.max_scale = _.get('maxValue');
					return false;
				}
			});
		}else{
			_.push('coordinate.scale',{
				position : li,
				scaleAlign : li,
				max_scale : _.get('maxValue'),
				min_scale : _.get('minValue')
			});
		}
		
		if (_.is3D()) {
			_.push('coordinate.xAngle_', _.get('xAngle_'));
			_.push('coordinate.yAngle_', _.get('yAngle_'));
			/**
			 * the Coordinate' Z is same as long as the column's
			 */
			_.push('coordinate.zHeight', _.get('zHeight') * _.get('bottom_scale'));
		}
		
		return new $[_.is3D()?'Coordinate3D':'Coordinate2D'](_.get('coordinate'), _);
	},
	coordinate : function() {
		/**
		 * calculate chart's measurement
		 */
		var _ = this._(), f = 0.8, 
			_w = _.get('client_width'), 
			_h = _.get('client_height'), 
			w = _.push('coordinate.width',$.parsePercent(_.get('coordinate.width'),_w)), 
			h = _.push('coordinate.height',$.parsePercent(_.get('coordinate.height'),_h)), 
			vw = _.get('coordinate.valid_width'), 
			vh = _.get('coordinate.valid_height');
		
		if (!h || h > _h) {
			h = _.push('coordinate.height', Math.floor(_h * f));
		}
		
		if (!w || w > _w) {
			w = _.push('coordinate.width', Math.floor(_w * f));
		}
		
		vw = _.push('coordinate.valid_width',$.parsePercent(vw,w));
		vh = _.push('coordinate.valid_height',$.parsePercent(vh,h));
		
		if (_.is3D()) {
			var a = _.get('coordinate.pedestal_height');
			var b = _.get('coordinate.board_deep');
			a = $.isNumber(a)?a:22;
			b = $.isNumber(b)?b:20;
			h = _.push('coordinate.height', h - a - b);
		}
		
		/**
		 * calculate chart's alignment
		 */
		if (_.get('align') == _.L) {
			_.push(_.X, _.get('l_originx'));
		} else if (_.get('align') == _.R) {
			_.push(_.X, _.get('r_originx') - w);
		} else {
			_.push(_.X, _.get('centerx') - w / 2);
		}

		_.x = _.push(_.X, _.get(_.X) + _.get('offsetx'));
		_.y = _.push(_.Y, _.get('centery') - h / 2 + _.get('offsety'));
		
		if (!vw || vw > w) {
			_.push('coordinate.valid_width', w);
		}
		
		if (!vh || vh > h) {
			_.push('coordinate.valid_height', h);
		}
		
		_.push('coordinate.originx', _.x);
		_.push('coordinate.originy', _.y);
		
	}
}
/**
 * @overview this component use for abc
 * @component#$.Coordinate2D
 * @extend#$.Component
 */
$.Coordinate2D = $.extend($.Component, {
	configure : function() {
		/**
		 * invoked the super class's configurationuration
		 */
		$.Coordinate2D.superclass.configure.apply(this, arguments);

		/**
		 * indicate the component's type
		 */
		this.type = 'coordinate2d';

		this.set({
			/**
			 * @inner {Number}
			 */
			sign_size : 12,
			/**
			 * @inner {Number}
			 */
			sign_space : 5,
			/**
			 * @cfg {Array} the option for scale.For details see <link>$.Scale</link>
			 */
			scale : [],
			/**
			 * @cfg {String/Number} Here,specify as '80%' relative to client width.(default to '80%')
			 */
			width:'80%',
			/**
			 * @cfg {String/Number} Here,specify as '80%' relative to client height.(default to '80%')
			 */
			height:'80%',
			/**
			 * @cfg {String/Number} Specifies the valid width,less than the width of coordinate.you can applies a percent value relative to width.(default to '100%')
			 */
			valid_width : '100%',
			/**
			 * @cfg {String/Number} Specifies the valid height,less than the height of coordinate.you can applies a percent value relative to width.(default to '100%')
			 */
			valid_height : '100%',
			/**
			 * @cfg {Number} Specifies the linewidth of the grid.(default to 1)
			 */
			grid_line_width : 1,
			/**
			 * @cfg {String} Specifies the color of the grid.(default to '#dbe1e1')
			 */
			grid_color : '#dbe1e1',
			/**
			 * @cfg {Object} Specifies the stlye of horizontal grid.(default to empty object).Available property are:
			 * @Option solid {Boolean} True to draw a solid line.else draw a dotted line.(default to true)
			 * @Option size {Number} Specifies size of line segment when solid is false.(default to 10)
			 * @Option fator {Number} Specifies the times to size(default to 1)
			 * @Option width {Number} Specifies the width of grid line.(default to 1)
			 * @Option color {String} Specifies the color of grid line.(default to '#dbe1e1')
			 */
			gridHStyle : {},
			/**
			 * @cfg {Object} Specifies the stlye of horizontal grid.(default to empty object).Available property are:
			 * @Option solid {Boolean} True to draw a solid line.else draw a dotted line.(default to true)
			 * @Option size {Number} Specifies size of line segment when solid is false.(default to 10)
			 * @Option fator {Number} Specifies the times to size(default to 1)
			 * @Option width {Number} Specifies the width of grid line.(default to 1)
			 * @Option color {String} Specifies the color of grid line.(default to '#dbe1e1')
			 */
			gridVStyle : {},
			/**
			 * @cfg {Boolean} True to display grid line.(default to true)
			 */
			gridlinesVisible : true,
			/**
			 * @cfg {Boolean} indicate whether the grid is accord with scale,on the premise of grids is not specify. this just give a convenient way bulid grid for default.and actual value depend on scale's scale2grid
			 */
			scale2grid : true,
			/**
			 * @cfg {Object} this is grid config for custom.there has two valid property horizontal and vertical.the property's sub property is: way:the manner calculate grid-line (default to 'share_alike') Available property are:
			 * @Option share_alike
			 * @Option given_value value: when property way apply to 'share_alike' this property mean to the number of grid's line.
			 *  when apply to 'given_value' this property mean to the distance each grid line(unit:pixel) . 
			 *  code will like: 
			 *  { 
			 *   horizontal: {way:'share_alike',value:10},
			 *   vertical: { way:'given_value', value:40 }
			 *   }
			 */
			grids : undefined,
			/**
			 * @cfg {Boolean} If True the grid line will be ignored when gird and axis overlap.(default to true)
			 */
			ignoreOverlap : true,
			/**
			 * @cfg {Boolean} If True the grid line will be ignored when gird and coordinate's edge overlap.(default to false)
			 */
			ignoreEdge : false,
			/**
			 * @inner {String} Specifies the label on x-axis
			 */
			xlabel : '',
			/**
			 * @inner {String} Specifies the label on y-axis
			 */
			ylabel : '',
			/**
			 * @cfg {String} Here,specify as false to make background transparent.(default to null)
			 */
			background_color : 0,
			/**
			 * @cfg {Boolean} True to stripe the axis.(default to true)
			 */
			striped : true,
			/**
			 * @cfg {String} Specifies the direction apply striped color.(default to 'v')Available value are:
			 * @Option 'h' horizontal
			 * @Option 'v' vertical
			 */
			striped_direction : 'v',
			/**
			 * @cfg {float(0.01 - 0.5)} Specifies the factor make color dark striped,relative to background-color,the bigger the value you set,the larger the color changed.(defaults to '0.01')
			 */
			striped_factor : 0.01,
			/**
			 * @cfg {Object} Specifies config crosshair.(default enable to false).For details see <link>$.CrossHair</link> Note:this has a extra property named 'enable',indicate whether crosshair available(default to false)
			 */
			crosshair : {
				enable : false
			},
			/**
			 * @cfg {Number} Required,Specifies the width of this coordinate.(default to undefined)
			 */
			width : undefined,
			/**
			 * @cfg {Number} Required,Specifies the height of this coordinate.(default to undefined)
			 */
			height : undefined,
			/**
			 * @cfg {Number}Override the default as -1 to make sure it at the bottom.(default to -1)
			 */
			z_index : -1,
			/**
			 * @cfg {Object} Specifies style for axis of this coordinate. Available property are:
			 * @Option enable {Boolean} True to display the axis.(default to true)
			 * @Option color {String} Specifies the color of each axis.(default to '#666666')
			 * @Option width {Number/Array} Specifies the width of each axis, If given the a array,there must be have have 4 element, like this:[1,0,0,1](top-right-bottom-left).(default to 1)
			 */
			axis : {
				enable : true,
				color : '#666666',
				width : 1
			}
		});
		
		this.scale = [];
		this.gridlines = [];
	},
	getScale : function(p) {
		for ( var i = 0; i < this.scale.length; i++) {
			var k = this.scale[i];
			if (k.get('position') == p) {
				var u = [k.get('basic_value'),k.get('start_scale'),k.get('end_scale'),k.get('end_scale') - k.get('start_scale'),0];
				u[4] = $.inRange(u[1],u[2]+1,u[0])||$.inRange(u[2]-1,u[1],u[0]);
				return {
					range:u[4],
					basic:u[4]?(u[0]-u[1]) / u[3]:0,
					start : u[4]?u[0]:u[1],
					end : u[2],
					distance : u[3]
				};
			}
		}
		return {
			start : 0,
			end : 0,
			distance : 0
		};
	},
	isEventValid : function(e,_) {
		return {
			valid : e.x > _.x && e.x < (_.x + _.get(_.W)) && e.y < _.y + _.get(_.H) && e.y > _.y
		};
	},
	doDraw : function(_) {
		_.T.box(_.x, _.y, _.get(_.W), _.get(_.H), 0, _.get('f_color'));
		if (_.get('striped')) {
			var x, y, f = false, axis = _.get('axis.width'), c = $.dark(_.get('background_color'), _.get('striped_factor'),0);
		}
		var v = (_.get('striped_direction') == 'v');
		_.gridlines.each(function(g,i) {
			if (_.get('striped')) {
				if (f) {
					if (v)
						_.T.box(g.x1, g.y1 + g.width, g.x2 - g.x1, y - g.y1 - g.width, 0, c);
					else
						_.T.box(x + g.width, g.y2, g.x1 - x, g.y1 - g.y2, 0, c);
				}
				x = g.x1;
				y = g.y1;
				f = !f;
			}
		}).each(function(g) {
			if(!g.overlap){
				if(g.solid){
					_.T.line(g.x1, g.y1, g.x2, g.y2, g.width, g.color);
				}else{
					_.T.dotted(g.x1, g.y1, g.x2, g.y2, g.width, g.color,g.size,g.fator);
				}
			}
		});
		_.T.box(_.x, _.y, _.get(_.W), _.get(_.H), _.get('axis'), false, _.get('shadow'),true);
		_.scale.each(function(s) {
			s.draw()
		});
	},
	doConfig : function() {
		$.Coordinate2D.superclass.doConfig.call(this);

		var _ = this._();

		$.Assert.isNumber(_.get(_.W), _.W);
		$.Assert.isNumber(_.get(_.H), _.H);

		/**
		 * this element not atomic because it is a container,so this is a particular case.
		 */
		_.atomic = false;

		/**
		 * apply the gradient color to f_color
		 */
		if (_.get('gradient') && $.isString(_.get('f_color'))) {
			_.push('f_color', _.T.avgLinearGradient(_.x, _.y, _.x, _.y + _.get(_.H), [_.get('dark_color'), _.get('light_color')]));
		}
		
		if (_.get('axis.enable')) {
			var aw = _.get('axis.width');
			if (!$.isArray(aw))
				_.push('axis.width', [aw, aw, aw, aw]);
		}else{
			_.push('axis.width', [0, 0, 0, 0]);
		}

		if (_.get('crosshair.enable')) {
			_.push('crosshair.wrap', _.container.shell);
			_.push('crosshair.height', _.get(_.H));
			_.push('crosshair.width', _.get(_.W));
			_.push('crosshair.top', _.y);
			_.push('crosshair.left', _.x);

			_.crosshair = new $.CrossHair(_.get('crosshair'), _);
		}

		var jp, cg = !!(_.get('gridlinesVisible') && _.get('grids')), hg = cg && !!_.get('grids.horizontal'), vg = cg && !!_.get('grids.vertical'), h = _.get(_.H), w = _.get(_.W), vw = _.get('valid_width'), vh = _.get('valid_height'), k2g = _.get('gridlinesVisible')
				&& _.get('scale2grid') && !(hg && vg), sw = (w - vw) / 2, sh = (h - vh) / 2, axis = _.get('axis.width');
		
		_.push('x_start', _.x+(w - vw) / 2);
		_.push('x_end', _.x + (w + vw) / 2);
		_.push('y_start', _.y+(h - vh) / 2);
		_.push('y_end', _.y + (h + vh) / 2);
		
		if (!$.isArray(_.get('scale'))) {
			if ($.isObject(_.get('scale')))
				_.push('scale', [_.get('scale')]);
			else
				_.push('scale', []);
		}
		
		_.get('scale').each(function(kd, i) {
			jp = kd['position'];
			jp = jp || _.L;
			jp = jp.toLowerCase();
			kd[_.X] = _.x;
			kd['coo'] = _;
			kd[_.Y] = _.y;
			kd['valid_x'] = _.x + sw;
			kd['valid_y'] = _.y + sh;
			kd['position'] = jp;
			/**
			 * calculate coordinate,direction,distance
			 */
			if (jp == _.O) {
				kd['which'] = 'h';
				kd['distance'] = w;
				kd['valid_distance'] = vw;
			} else if (jp == _.R) {
				kd['which'] = 'v';
				kd['distance'] = h;
				kd['valid_distance'] = vh;
				kd[_.X] += w;
				kd['valid_x'] += vw;
			} else if (jp == _.B) {
				kd['which'] = 'h';
				kd['distance'] = w;
				kd['valid_distance'] = vw;
				kd[_.Y] += h;
				kd['valid_y'] += vh;
			} else {
				kd['which'] = 'v';
				kd['distance'] = h;
				kd['valid_distance'] = vh;
			}
			_.scale.push(new $.Scale(kd, _.container));
		}, _);

		var iol = _.push('ignoreOverlap', _.get('ignoreOverlap') && _.get('axis.enable') || _.get('ignoreEdge'));

		if (iol) {
			if (_.get('ignoreEdge')) {
				var ignoreOverlap = function(w, x, y) {
					return w == 'v' ? (y == _.y) || (y == _.y + h) : (x == _.x) || (x == _.x + w);
				}
			} else {
				var ignoreOverlap = function(wh, x, y) {
					return wh == 'v' ? (y == _.y && axis[0] > 0) || (y == (_.y + h) && axis[2] > 0) : (x == _.x && axis[3] > 0) || (x == (_.x + w) && axis[1] > 0);
				}
			}
		}
		var g = {
				solid : true,
				size : 10,
				fator : 1,
				width : _.get('grid_line_width'),
				color : _.get('grid_color')
			},
			ghs = $.applyIf(_.get('gridHStyle'),g),
			gvs = $.applyIf(_.get('gridVStyle'),g);
		
		if (k2g) {
			var scale, x, y, p;
			_.scale.each(function(scale) {
				p = scale.get('position');
				/**
				 * disable,given specfiy grid will ignore scale2grid
				 */
				if ($.isFalse(scale.get('scale2grid')) || hg && scale.get('which') == 'v' || vg && scale.get('which') == 'h') {
					return;
				}
				x = y = 0;
				if (p == _.O) {
					y = h;
				} else if (p == _.R) {
					x = -w;
				} else if (p == _.B) {
					y = -h;
				} else {
					x = w;
				}
				
				scale.items.each(function(item) {
					if (iol)
					_.gridlines.push($.applyIf({
						overlap:ignoreOverlap.call(_, scale.get('which'), item.x, item.y),
						x1 : item.x,
						y1 : item.y,
						x2 : item.x + x,
						y2 : item.y + y
					},scale.isH?gvs:ghs));
				});
			});
		}
		if (vg) {
			var gv = _.get('grids.vertical');
			$.Assert.gt(gv['value'],0, 'value');
			var d = w / gv['value'], n = gv['value'];
			if (gv['way'] == 'given_value') {
				n = d;
				d = gv['value'];
				d = d > w ? w : d;
			}

			for ( var i = 0; i <= n; i++) {
				if (iol)
				_.gridlines.push($.applyIf({
					overlap:ignoreOverlap.call(_, 'h', _.x + i * d, _.y),
					x1 : _.x + i * d,
					y1 : _.y,
					x2 : _.x + i * d,
					y2 : _.y + h,
					H : false,
					width : gvs.width,
					color : gvs.color
				},gvs));
			}
		}
		if (hg) {
			var gh = _.get('grids.horizontal');
			$.Assert.gt(gh['value'],0,'value');
			var d = h / gh['value'], n = gh['value'];
			if (gh['way'] == 'given_value') {
				n = d;
				d = gh['value'];
				d = d > h ? h : d;
			}

			for ( var i = 0; i <= n; i++) {
				if (iol)
				_.gridlines.push($.applyIf({
					overlap:ignoreOverlap.call(_, 'v', _.x, _.y + i * d),
					x1 : _.x,
					y1 : _.y + i * d,
					x2 : _.x + w,
					y2 : _.y + i * d,
					H : true,
					width : ghs.width,
					color : ghs.color
				},ghs));
			}
		}
	}
});
/**
 * @end
 */
/**
 * @overview this component use for abc
 * @component#$.Coordinate3D
 * @extend#$.Coordinate2D
 */
$.Coordinate3D = $.extend($.Coordinate2D, {
	configure : function() {
		/**
		 * invoked the super class's configurationuration
		 */
		$.Coordinate3D.superclass.configure.apply(this, arguments);

		/**
		 * indicate the component's type
		 */
		this.type = 'coordinate3d';
		this.dimension = $._3D;

		this.set({
			/**
			 * @cfg {Number} Three-dimensional rotation X in degree(angle).socpe{0-90},Normally, this will accord with the chart.(default to 60)
			 */
			xAngle : 60,
			/**
			 * @cfg {Number} Three-dimensional rotation Y in degree(angle).socpe{0-90},Normally, this will accord with the chart.(default to 20)
			 */
			yAngle : 20,
			xAngle_ : undefined,
			yAngle_ : undefined,
			/**
			 * @cfg {Number} Required,Specifies the z-axis deep of this coordinate,Normally, this will given by chart.(default to 0)
			 */
			zHeight : 0,
			/**
			 * @cfg {Number} Specifies pedestal height of this coordinate.(default to 22)
			 */
			pedestal_height : 22,
			/**
			 * @cfg {Number} Specifies board deep of this coordinate.(default to 20)
			 */
			board_deep : 20,
			/**
			 * @cfg {Boolean} If true display the left board.(default to true)
			 */
			left_board:true,
			/**
			 * @cfg {Boolean} Override the default as true
			 */
			gradient : true,
			/**
			 * @cfg {float} Override the default as 0.18.
			 */
			color_factor : 0.18,
			/**
			 * @cfg {Boolean} Override the default as true.
			 */
			ignoreEdge : true,
			/**
			 * @cfg {Boolean} Override the default as false.
			 */
			striped : false,
			/**
			 * @cfg {String} Override the default as '#a4ad96'.
			 */
			grid_color : '#a4ad96',
			/**
			 * @cfg {String} Override the default as '#d6dbd2'.
			 */
			background_color : '#d6dbd2',
			/**
			 * @cfg {Number} Override the default as 4.
			 */
			shadow_offsetx : 4,
			/**
			 * @cfg {Number} Override the default as 2.
			 */
			shadow_offsety : 2,
			/**
			 * @cfg {Array} Specifies the style of board(wall) of this coordinate. 
			 * the length of array will be 6,if less than 6,it will instead of <link>background_color</link>.and each object option has two property. Available property are:
			 * @Option color the color of wall
			 * @Option alpha the opacity of wall
			 */
			wall_style : [],
			/**
			 * @cfg {Boolean} Override the default as axis.enable = false.
			 */
			axis : {
				enable : false
			}
		});
	},
	doDraw : function(_) {
		var w = _.get(_.W), h = _.get(_.H), xa = _.get('xAngle_'), ya = _.get('yAngle_'), zh = _.get('zHeight'), offx = _.get('z_offx'), offy = _.get('z_offy');
		/**
		 * bottom
		 */
		if(_.get('pedestal_height'))
		_.T.cube3D(_.x, _.y + h + _.get('pedestal_height'), xa, ya, false, w, _.get('pedestal_height'), zh * 3 / 2, _.get('axis.enable'), _.get('axis.width'), _.get('axis.color'), _.get('bottom_style'));
		/**
		 * board_style
		 */
		if(_.get('board_deep'))
		_.T.cube3D(_.x +offx, _.y+h - offy, xa, ya, false, w, h, _.get('board_deep'), _.get('axis.enable'), _.get('axis.width'), _.get('axis.color'), _.get('board_style'));
		
		_.T.cube3D(_.x, _.y + h, xa, ya, false, w, h, zh, _.get('axis.enable'), _.get('axis.width'), _.get('axis.color'), _.get('wall_style'));
		
		_.gridlines.each(function(g) {
			if(g.solid){
				if(_.get('left_board'))
				_.T.line(g.x1, g.y1, g.x1 + offx, g.y1 - offy,g.width, g.color);
				_.T.line(g.x1 + offx, g.y1 - offy, g.x2 + offx, g.y2 - offy, g.width, g.color);
			}else{
				if(_.get('left_board'))
				_.T.dotted(g.x1, g.y1, g.x1 + offx, g.y1 - offy,g.width, g.color,g.size,g.fator);
				_.T.dotted(g.x1 + offx, g.y1 - offy, g.x2 + offx, g.y2 - offy, g.width, g.color,g.size,g.fator);
			}
		});
		_.scale.each(function(s) {
			s.draw();
		});
	},
	doConfig : function() {
		$.Coordinate3D.superclass.doConfig.call(this);

		var _ = this._(),
			ws = _.get('wall_style'),
			bg = _.get('background_color'),
			h = _.get(_.H),
			w = _.get(_.W),
			f = _.get('color_factor'),
			offx = _.push('z_offx',_.get('xAngle_') * _.get('zHeight')),
			offy = _.push('z_offy',_.get('yAngle_') * _.get('zHeight'));
			/**
			 * bottom-lower bottom-left
			 */
			while(ws.length < 6){
				ws.push({color : bg});
			}
			if(!_.get('left_board')){
				ws[2] = false;
				_.scale.each(function(s){
					s.doLayout(offx,-offy,s);
				});
			}
			
			/**
			 * right-front
			 */
			_.push('bottom_style', [{
				color : _.get('shadow_color'),
				shadow : _.get('shadow')
			}, false, false, {
				color : ws[3].color
			},false, {
				color : ws[3].color
			}]);
			
			/**
			 * right-top
			 */
			_.push('board_style', [false, false, false,{
				color : ws[4].color
			},{
				color : ws[5].color
			}, false]);
			
			/**
			 * lowerBottom-bottom-left-right-top-front
			 */
			if (_.get('gradient')) {
				if ($.isString(ws[0].color)) {
					ws[0].color = _.T.avgLinearGradient(_.x, _.y + h, _.x + w, _.y + h, [$.dark(ws[0].color,f/2+0.06),$.dark(ws[0].color,f/2+0.06)]);
				}
				if ($.isString(ws[1].color)) {
					ws[1].color = _.T.avgLinearGradient(_.x + offx, _.y - offy, _.x + offx, _.y + h - offy, [$.dark(ws[1].color,f),$.light(ws[1].color,f)]);
				}
				if ($.isString(ws[2].color)) {
					ws[2].color = _.T.avgLinearGradient(_.x, _.y, _.x, _.y + h, [$.light(ws[2].color,f/3),$.dark(ws[2].color,f)]);
				}
				_.get('bottom_style')[5].color = _.T.avgLinearGradient(_.x, _.y + h, _.x, _.y + h + _.get('pedestal_height'), [$.light(ws[3].color,f/2+0.06),$.dark(ws[3].color,f/2,0)]);
			}
			_.push('wall_style', [ws[0],ws[1],ws[2]]);
			
	}
});
/*
 * @end
 */


	/**
	 * @overview this component use for abc
	 * @component#$.Rectangle
	 * @extend#$.Component
	 */
	$.Rectangle = $.extend($.Component,{
		configure:function(){
			/**
			 * invoked the super class's  configuration
			 */
			$.Rectangle.superclass.configure.apply(this,arguments);
			
			/**
			 * indicate the component's type
			 */
			this.type = 'rectangle';
			
			this.set({
				/**
				 * @cfg {Number} Specifies the width of this element in pixels,Normally,this will given by chart.(default to 0)
				 */
				width:0,
				/**
				 * @cfg {Number} Specifies the height of this element in pixels,Normally,this will given by chart.(default to 0)
				 */
				height:0,
				/**
				 * @cfg {Number} the distance of column's edge and value in pixels.(default to 4)
				 */
				value_space:4,
				/**
				 * @cfg {String} Specifies the text of this element,Normally,this will given by chart.(default to '')
				 */
				value:'',
				/**
				 * @cfg {<link>$.Text</link>} Specifies the config of label,set false to make label disabled.
				 */
				label : {},
				/**
				 * @cfg {String} Specifies the name of this element,Normally,this will given by chart.(default to '')
				 */
				name:'',
				/**
				 * @cfg {String} Specifies the tip alignment of chart(defaults to 'top').Available value are:
				 * @Option 'left'
				 * @Option 'right'
				 * @Option 'top'
				 * @Option 'bottom'
				 */
				tipAlign:'top',
				/**
				 * @cfg {String} Specifies the value's text alignment of chart(defaults to 'top') Available value are:
				 * @Option 'left'
				 * @Option 'right'
				 * @Option 'top'
				 * @Option 'bottom'
				 */
				valueAlign:'top',
				/**
				 * @cfg {Number} Override the default as 3
				 */
				shadow_blur:3,
				/**
				 * @cfg {Number} Override the default as -1
				 */
				shadow_offsety:-1
			});
			
			/**
			 * this element support boxMode
			 */
			this.atomic = true;
			
			this.registerEvent(
					/**
					 * @event Fires when parse this label's data.Return value will override existing.
					 * @paramter <link>$.Rectangle</link>#rect
					 * @paramter string#text the current label's text
					 */
					'parseText');
			
			this.label = null;
		},
		doDraw:function(_){
			_.drawRectangle();
			if(_.label)
				_.label.draw();
		},
		doConfig:function(){
			$.Rectangle.superclass.doConfig.call(this);
			var _ = this._(),v = _.variable.event,vA=_.get('valueAlign');
			$.Assert.gt(_.get(_.W),0,_.W);
			
			/**
			 * mouseover light
			 */
			$.taylor.light(_,v);
			
			_.width = _.get(_.W);
			_.height = _.get(_.H);
			
			var x = _.push('centerx',_.x + _.width/2),
				y = _.push('centery',_.y + _.height/2),
				a = _.C,
				b = 'middle',
				s=_.get('value_space');
			
			_.push('value',_.fireString(_, 'parseText', [_, _.get('value')], _.get('value')));
			
			if(vA==_.L){
				a = _.R;
				x = _.x - s;
			}else if(vA==_.R){
				a = _.L;
				x =_.x + _.width + s;
			}else if(vA==_.B){
				y = _.y  + _.height + s;
				b = _.O;
			}else{
				y = _.y  - s;
				b = _.B;
			}
			
			if(_.get('label')){
				_.push('label.originx', x);
				_.push('label.originy', y);
				_.push('label.text',_.get('value'));
				$.applyIf(_.get('label'),{
					textAlign : a,
					textBaseline : b,
					color:_.get('color')
				});
				_.label = new $.Text(_.get('label'), _);
			}
			
			if(_.get('tip.enable')){
				if(_.get('tip.showType')!='follow'){
					_.push('tip.invokeOffsetDynamic',false);
				}
				_.tip = new $.Tip(_.get('tip'),_);
			}
		}
});
/**
 *@end
 */	
	/**
	 * @overview this component use for abc
	 * @component#$.Rectangle2D
	 * @extend#$.Rectangle
	 */
	$.Rectangle2D = $.extend($.Rectangle,{
		configure:function(){
			/**
			 * invoked the super class's  configuration
			 */
			$.Rectangle2D.superclass.configure.apply(this,arguments);
			
			/**
			 * indicate the component's type
			 */
			this.type = 'rectangle2d';
			
			this.set({
				/**
				 * @cfg {Number} Override the default as -2
				 */
				shadow_offsety:-2
			});
			
		},
		drawRectangle:function(){
			var _ = this._();
			_.T.box(
				_.get(_.X),
				_.get(_.Y),
				_.get(_.W),
				_.get(_.H),
				_.get('border'),
				_.get('f_color'),
				_.get('shadow'));
		},
		isEventValid:function(e,_){
			return {valid:e.x>_.x&&e.x<(_.x+_.width)&&e.y<(_.y+_.height)&&e.y>(_.y)};
		},
		tipInvoke:function(){
			var _ = this._();
			/**
			 * base on event?
			 */
			return function(w,h){
				return {
					left:_.tipX(w,h),
					top:_.tipY(w,h)
				}
			}
		},
		doConfig:function(){
			$.Rectangle2D.superclass.doConfig.call(this);
			var _ = this._(),tipAlign = _.get('tipAlign');
			if(tipAlign==_.L||tipAlign==_.R){
				_.tipY = function(w,h){return _.get('centery') - h/2;};
			}else{
				_.tipX = function(w,h){return _.get('centerx') -w/2;};
			}
			
			if(tipAlign==_.L){
				_.tipX = function(w,h){return _.x - _.get('value_space') -w;};
			}else if(tipAlign==_.R){
				_.tipX = function(w,h){return _.x + _.width + _.get('value_space');};
			}else if(tipAlign==_.B){
				_.tipY = function(w,h){return _.y  +_.height+3;};
			}else{
				_.tipY = function(w,h){return _.y  - h -3;};
			}
			
			_.applyGradient();
			
			
		}
});
/**
 *@end
 */	
	/**
	 * @overview this component use for abc
	 * @component#$.Rectangle3D
	 * @extend#$.Rectangle
	 */
	$.Rectangle3D = $.extend($.Rectangle,{
		configure:function(){
			/**
			 * invoked the super class's  configuration
			 */
			$.Rectangle3D.superclass.configure.apply(this,arguments);
			
			/**
			 * indicate the component's type
			 */
			this.type = 'rectangle3d';
			this.dimension = $._3D;
			
			this.set({
				/**
				 * @cfg {Number} Specifies Three-dimensional z-axis deep in pixels.Normally,this will given by chart.(default to undefined)
				 */
				zHeight:undefined,
				/**
				 * @cfg {Number} Three-dimensional rotation X in degree(angle).socpe{0-90}.Normally,this will given by chart.(default to 60)
				 */
				xAngle:60,
				/**
				 * @cfg {Number} Three-dimensional rotation Y in degree(angle).socpe{0-90}.Normally,this will given by chart.(default to 20)
				 */
				yAngle:20,
				xAngle_:undefined,
				yAngle_:undefined,
				/**
				 * @cfg {Number} Override the default as 2
				 */
				shadow_offsetx:2
			});
			
		},
		drawRectangle:function(){
			var _ = this._();
			_.T.cube(
				_.get(_.X),
				_.get(_.Y),
				_.get('xAngle_'),
				_.get('yAngle_'),
				_.get(_.W),
				_.get(_.H),
				_.get('zHeight'),
				_.get('f_color'),
				_.get('border.enable'),
				_.get('border.width'),
				_.get('light_color'),
				_.get('shadow')
			);
		},
		isEventValid:function(e,_){
			return {valid:e.x>_.x&&e.x<(_.x+_.get(_.W))&&e.y<_.y+_.get(_.H)&&e.y>_.y};
		},
		tipInvoke:function(){
			var _ = this._();
			return function(w,h){
				return {
					left:_.topCenterX - w/2,
					top:_.topCenterY - h
				}
			}
		},
		doConfig:function(){
			$.Rectangle3D.superclass.doConfig.call(this);
			var _ = this._();
			_.pushIf("zHeight",_.get(_.W));
			
			_.topCenterX=_.x+(_.get(_.W)+_.get(_.W)*_.get('xAngle_'))/2;
			_.topCenterY=_.y-_.get(_.W)*_.get('yAngle_')/2;
			
			if(_.get('valueAlign')==_.O&&_.label){
				_.label.push('textx',_.topCenterX);
				_.label.push('texty',_.topCenterY);
			}
			
		}
});
/**
 *@end
 */	
/**
 * @overview this component use for config sector,this is a abstract class.
 * @component#$.Sector
 * @extend#$.Component
 */
$.Sector = $.extend($.Component, {
	configure : function() {
		/**
		 * invoked the super class's configuration
		 */
		$.Sector.superclass.configure.apply(this, arguments);

		/**
		 * indicate the component's type
		 */
		this.type = 'sector';

		this.set({
			/**
			 * @cfg {String} Specifies the value of this element,Normally,this will given by chart.(default to '')
			 */
			value : '',
			/**
			 * @cfg {String} Specifies the name of this element,Normally,this will given by chart.(default to '')
			 */
			name : '',
			/**
			 * @cfg {Boolean} True will not darw.(default to false)
			 */
			ignored : false,
			/**
			 * @inner {Boolean} True to make sector counterclockwise.(default to false)
			 */
			counterclockwise : false,
			/**
			 * @cfg {Number} Specifies the start angle of this sector.Normally,this will given by chart.(default to 0)
			 */
			startAngle : 0,
			/**
			 * @cfg {Number} middleAngle = (endAngle - startAngle)/2.Normally,this will given by chart.(default to 0)
			 */
			middleAngle : 0,
			/**
			 * @cfg {Number} Specifies the end angle of this sector.Normally,this will given by chart.(default to 0)
			 */
			endAngle : 0,
			/**
			 * @cfg {Number} Specifies total angle of this sector,totalAngle = (endAngle - startAngle).Normally,this will given by chart.(default to 0)
			 */
			totalAngle : 0,
			/**
			 * @inner {String} the event's name trigger pie bound(default to 'click').
			 */
			bound_event : 'click',
			/**
			 * @cfg {Boolean} True to bound this sector.(default to false)
			 */
			expand : false,
			/**
			 * @cfg {Number} Specifies the width when show a donut.only applies when it not 0.(default to 0)
			 */
			donutwidth : 0,
			/**
			 * @inner {Boolean} If true means just one piece could bound at same time.(default to false)
			 */
			mutex : false,
			/**
			 * @inner {Number} Specifies the offset when bounded.Normally,this will given by chart.(default to undefined)
			 */
			increment : undefined,
			/**
			 * @cfg {String} Specifies the gradient mode of background.(defaults to 'RadialGradientOutIn')
			 * @Option 'RadialGradientOutIn'
			 * @Option 'RadialGradientInOut'
			 */
			gradient_mode : 'RadialGradientOutIn',
			/**
			 * @cfg {Number} Specifies the threshold value in angle that applies mini_label.(default to 15)
			 */
			mini_label_threshold_angle : 15,
			/**
			 * @cfg {<link>$.Text</link>} Specifies the config of label.when mini_label is a object,there will as a <link>$.Text</link>.(default to false) note:set false to make minilabel disabled.
			 */
			mini_label : false,
			/**
			 * @cfg {<link>$.Label</link>} Specifies the config of label.when mini_label is unavailable,there will as a <link>$.Label</link>. note:set false to make label disabled.
			 */
			label : {}
		});

		/**
		 * this element support boxMode
		 */
		this.atomic = true;

		this.registerEvent('changed',
		/**
		 * @event Fires when parse this label's data.Return value will override existing. Only valid when label is available
		 * @paramter <link>$.Sector</link>#sector the sector object
		 * @paramter string#text the current label's text
		 */
		'parseText');

		this.label = null;
		this.tip = null;
	},
	bound : function() {
		if (!this.expanded)
			this.toggle();
	},
	rebound : function() {
		if (this.expanded)
			this.toggle();
	},
	toggle : function() {
		this.fireEvent(this, this.get('bound_event'), [this]);
	},
	/**
	 * @method get the sector's dimension,return hold following property
	 * @property x:the x-coordinate of the center of the sector
	 * @property y:the y-coordinate of the center of the sector
	 * @property startAngle:The starting angle, in radians (0 is at the 3 o'clock position of the arc's circle)
	 * @property endAngle:the ending angle, in radians
	 * @property middleAngle:the middle angle, in radians
	 * @return object
	 */
	getDimension : function() {
		var _ = this._();
		return {
			x : _.x,
			x : _.y,
			startAngle : _.get("startAngle"),
			middleAngle : _.get("middleAngle"),
			endAngle : _.get("endAngle")
		}
	},
	doDraw : function(_) {
		if (!_.get('ignored')) {
			if (_.label&&!_.get('mini_label')){
				_.label.draw();
			}
			_.drawSector();
			if (_.label&&_.get('mini_label')){
				_.label.draw();
			}
		}
	},
	doText : function(_, x, y) {
		_.push('label.originx', x);
		_.push('label.originy', y);
		_.push('label.textBaseline', 'middle');
		_.label = new $.Text(_.get('label'), _);
	},
	doLabel : function(_, x, y, Q, p, x0, y0,L) {
		_.push('label.originx', x);
		_.push('label.originy', y);
		_.push('label.quadrantd', Q);
		_.push('label.line_points', p);
		_.push('label.labelx', x0);
		_.push('label.labely', y0);
		_.push('label.smooth', L);
		_.push('label.angle', _.get('middleAngle')%(Math.PI*2));
		_.label = new $.Label(_.get('label'), _);
	},
	isLabel : function() {
		return this.get('label') && !this.get('mini_label');
	},
	doConfig : function() {
		$.Sector.superclass.doConfig.call(this);

		var _ = this._(), v = _.variable.event, f = _.get('label'),event=_.get('bound_event'),g;
		
		/**
		 * mouseover light
		 */
		$.taylor.light(_,v);
		
		_.push('totalAngle', _.get('endAngle') - _.get('startAngle'));

		if (f) {
			if (_.get('mini_label')) {
				if ((_.get('mini_label_threshold_angle') * Math.PI / 180) > _.get('totalAngle')) {
					_.push('mini_label', false);
				} else {
					$.apply(_.get('label'),_.get('mini_label'));
				}
			}
			
			_.push('label.text', _.fireString(_, 'parseText', [_,_.get('label.text')], _.get('label.text')));

			_.pushIf('label.border.color', _.get('border.color'));
			/**
			 * make the label's color in accord with sector
			 */
			_.push('label.scolor', _.get('background_color'));
		}

		_.variable.event.status = _.expanded = _.get('expand');
		
		if (_.get('tip.enable')) {
			if (_.get('tip.showType') != 'follow') {
				_.push('tip.invokeOffsetDynamic', false);
			}
			_.tip = new $.Tip(_.get('tip'), _);
		}

		v.poped = false;
		
		/**
		 *need test profile/time
		 */
		_.on(event, function() {
			v.poped = true;
			_.expanded = !_.expanded;
			_.redraw(event);
			v.poped = false;
		});
		
		_.on('beforedraw', function(a,b) {
			if(b==event){
				g = false;
				_.x = _.get(_.X);
				_.y = _.get(_.Y);
				if (_.expanded) {
					if (_.get('mutex') && !v.poped) {
						_.expanded = false;
						g = true;
					} else {
						_.x += _.get('inc_x');
						_.y -= _.get('inc_y');
					}
				}
				if (v.status != _.expanded) {
					_.fireEvent(_, 'changed', [_, _.expanded]);
					g = true;
					v.status = _.expanded;
				}
				if (f&&g)
					_.label.doLayout(_.get('inc_x') * (_.expanded ? 1 : -1), -_.get('inc_y') * (_.expanded ? 1 : -1),2,_.label);
			}
			return true;
		});

	}
});
/**
 * @end
 */
	/**
	 * @overview this component use for abc
	 * @component#$.Sector2D
	 * @extend#$.Sector
	 */
	$.Sector2D = $.extend($.Sector,{
		configure:function(){
			/**
			 * invoked the super class's  configuration
			 */
			$.Sector2D.superclass.configure.apply(this,arguments);
			
			/**
			 * indicate the component's type
			 */
			this.type = 'sector2d';
			
			this.set({
				/**
				 * @cfg {Float (0~)} Specifies the sector's radius.Normally,this will given by chart.(default to 0)
				 */
				radius:0
			});
			
		},
		drawSector:function(){
			this.T.sector(
					this.x,
					this.y,
					this.r,
					this.get('donutwidth'),
					this.get('startAngle'),
					this.get('endAngle'),
					this.get('f_color'),
					this.get('border.enable'),
					this.get('border.width'),
					this.get('border.color'),
					this.get('shadow'),
					this.get('counterclockwise'));
		},
		isEventValid:function(e,_){
			if(!_.get('ignored')){
				if(_.isLabel()&&_.label.isEventValid(e,_.label).valid){
					return {valid:true};
				}
				
				var r = $.distanceP2P(_.x,_.y,e.x,e.y),b=_.get('donutwidth');	
				if(_.r<r||(b&&(_.r-b)>r)){
					return {valid:false};
				}
				if($.angleInRange(_.get('startAngle'),_.get('endAngle'),$.atan2Radian(_.x,_.y,e.x,e.y))){
					return {valid:true};
				}
			}
			return {valid:false};
		},
		tipInvoke:function(){
			var _ = this;
			return function(w,h){
				var P = $.p2Point(this.x,this.y,this.get('middleAngle'),this.r*0.8),Q  = $.quadrantd(this.get('middleAngle'));
				return {
					left:(Q>=2&&Q<=3)?(P.x - w):P.x,
					top:Q>=3?(P.y - h):P.y
				}
			}
		},
		doConfig:function(){
			$.Sector2D.superclass.doConfig.call(this);
			var _ = this._();
			_.r = _.get('radius');
			
			$.Assert.gt(_.r,0);
			
			if(_.get('donutwidth')>_.r){
				_.push('donutwidth',0);
			}
			_.applyGradient(_.x-_.r,_.y-_.r,2*_.r,2*_.r);
			
			
			var A = _.get('middleAngle'),L = _.pushIf('increment',$.lowTo(5,_.r/10)),p2;
			_.push('inc_x',L * Math.cos(2 * Math.PI -A));
			_.push('inc_y',L * Math.sin(2 * Math.PI - A));
			L *=2;
			if(_.get('label')){
				if(_.get('mini_label')){
					P2 = $.p2Point(_.x,_.y,A,_.get('donutwidth')?_.r - _.get('donutwidth')/2:_.r/2);
					_.doText(_,P2.x,P2.y);
				}else{
					var Q  = $.quadrantd(A),
						P = $.p2Point(_.x,_.y,A,_.r + L),
						C1 = $.p2Point(_.x,_.y,A,_.r + L*0.6);
						P2 = $.p2Point(_.x,_.y,A,_.r);
					_.doLabel(_,P2.x,P2.y,Q,[{x:P2.x,y:P2.y},{x:C1.x,y:C1.y},{x:P.x,y:P.y}],P.x,P.y,L*0.4);
				}
			}
		}
});
/**
 * @end
 */
	/**
	 * @overview this component use for abc
	 * @component#$.Sector3D
	 * @extend#$.Sector
	 */
	$.Sector3D = $.extend($.Sector,{
		configure:function(){
			/**
			 * invoked the super class's  configuration
			 */
			$.Sector3D.superclass.configure.apply(this,arguments);
			
			/**
			 * indicate the component's type
			 */
			this.type = 'sector3d';
			this.dimension = $._3D;
			
			this.set({
				/**
				 * @cfg {Number}  Specifies major semiaxis of ellipse.Normally,this will given by chart.(default to 0)
				 */
				semi_major_axis:0,
				/**
				 * @cfg {Number} Specifies minor semiaxis of ellipse.Normally,this will given by chart.(default to 0)
				 */
				semi_minor_axis:0,
				/**
				 * @cfg {Float (0~)} Specifies the sector's height(thickness).Normally,this will given by chart.(default to 0)
				 */
				cylinder_height:0
			});
			
			
		},
		drawSector:function(){
			this.T.sector3D(
					this.x,
					this.y,
					this.a,
					this.b,
					this.get('startAngle'),
					this.get('endAngle'),
					this.h,
					this.get('f_color'),
					this.get('border.enable'),
					this.get('border.width'),
					this.get('border.color'),
					this.get('shadow'),
					this.get('shadow_color'),
					this.get('shadow_blur'),
					this.get('shadow_offsetx'),
					this.get('shadow_offsety'),
					this.get('counterclockwise'));
		},
		isEventValid:function(e,_){
			if(!_.get('ignored')){
				if(_.isLabel()&&_.label.isEventValid(e,_.label).valid){
						return {valid:true};
				}
				if(!$.inEllipse(e.x - _.x,e.y-_.y,_.a,_.b)){
					return {valid:false};
				}
				if($.angleZInRange(_.sA,_.eA,$.atan2Radian(_.x,_.y,e.x,e.y))){
					return {valid:true};
				}
			}
			return {valid:false};
		},
		p2p:function(x,y,a,z){
			return {
				x:x+this.a*Math.cos(a)*z,
				y:y+this.b*Math.sin(a)*z
			};
		},
		tipInvoke:function(){
			var _ =  this,A =  _.get('middleAngle'),Q  = $.quadrantd(A);
			return function(w,h){
				var P = _.p2p(_.x,_.y,A,0.6);
				return {
					left:(Q>=2&&Q<=3)?(P.x - w):P.x,
					top:Q>=3?(P.y - h):P.y
				}
			}
		},
		doConfig:function(){
			$.Sector3D.superclass.doConfig.call(this);
			var _ = this._(),ccw = _.get('counterclockwise'),mA = _.get('middleAngle');
			
			_.a = _.get('semi_major_axis');
			_.b = _.get('semi_minor_axis');
			_.h = _.get('cylinder_height');
			
			$.Assert.gt(_.a,0);
			$.Assert.gt(_.b,0);
			
			
			var pi2 = 2 * Math.PI,toAngle = function(A){
				while(A<0)A+=pi2;
				return Math.abs($.atan2Radian(0,0,_.a*Math.cos(A),ccw?(-_.b*Math.sin(A)):(_.b*Math.sin(A))));
			},
			L = _.pushIf('increment',$.lowTo(5,_.a/10));
			_.sA = toAngle.call(_,_.get('startAngle'));
			_.eA = toAngle.call(_,_.get('endAngle'));
			_.mA = toAngle.call(_,mA);
			
			_.push('inc_x',L * Math.cos(pi2 -_.mA));
			_.push('inc_y',L * Math.sin(pi2 - _.mA));
			L *=2;
			if(_.get('label')){
				if(_.get('mini_label')){
					var P3 = _.p2p(_.x,_.y,mA,0.5);
					_.doText(_,P3.x,P3.y);
				}else{
					var Q  = $.quadrantd(mA),
						P =  _.p2p(_.x,_.y,mA,L/_.a+1),
						C1 = _.p2p(_.x,_.y,mA,L*0.6/_.a+1),
						P2 = _.p2p(_.x,_.y,mA,1);
						_.doLabel(_,P2.x,P2.y,Q,[{x:P2.x,y:P2.y},{x:C1.x,y:C1.y},{x:P.x,y:P.y}],P.x,P.y,L*0.4);
					
				}
			}
		}
});
/**
 *@end
 */	
/**
 * @overview this component use for abc
 * @component#$.Pie
 * @extend#$.Chart
 */
$.Pie = $.extend($.Chart, {
	/**
	 * initialize the context for the pie
	 */
	configure : function() {
		/**
		 * invoked the super class's configuration
		 */
		$.Pie.superclass.configure.call(this);
		
		this.type = 'pie';

		this.set({
			/**
			 * @cfg {Float/String} Specifies the pie's radius.If given a percentage,it will relative to minDistance.(default to '100%')
			 */
			radius : '100%',
			/**
			 * @cfg {Number} initial angle for first sector.(default to 0)
			 */
			offset_angle : 0,
			/**
			 * @cfg {Number(0~90)} separate angle of all sector.(default to 0)
			 */
			separate_angle:0,
			/**
			 * @cfg {String} the event's name trigger pie pop(default to 'click')
			 */
			bound_event : 'click',
			/**
			 * @inner {Boolean} True to make sector counterclockwise.(default to false)
			 */
			counterclockwise : false,
			/**
			 * @cfg {Boolean} when label's position in conflict.auto layout.(default to true).
			 */
			intellectLayout : true,
			/**
			 * @cfg {Number} Specifies the distance in pixels when two label is incompatible with each other.(default 4),
			 */
			layout_distance : 4,
			/**
			 * @inner {Boolean} if it has animate when a piece popd (default to false)
			 */
			pop_animate : false,
			/**
			 * @cfg {Boolean} Specifies as true it means just one piece could pop (default to false)
			 */
			mutex : false,
			/**
			 * @cfg {Number} Specifies the length when sector bounded.(default to 1/8 radius,and minimum is 5),
			 */
			increment : undefined,
			/**
			 * @cfg {<link>$.Sector</link>} option of sector.Note,Pie2d depend on Sector2d and pie3d depend on Sector3d.For details see <link>$.Sector</link>
			 */
			sub_option : {
				label : {}
			}
		});

		this.registerEvent(
		/**
		 * @event Fires when this element' sector bounded
		 * @paramter <link>$.Sector2d</link>#sector
		 * @paramter string#name
		 * @paramter int#index
		 */
		'bound',
		/**
		 * @event Fires when this element' sector rebounded
		 * @paramter <link>$.Sector2d</link>#sector
		 * @paramter string#name
		 * @paramter int#index
		 */
		'rebound');

	},
	/**
	 * @method Toggle sector bound or rebound by a specific index.
	 * @paramter int#i the index of sector
	 * @return void
	 */
	toggle : function(i) {
		this.sectors[i || 0].toggle();
	},
	/**
	 * @method bound sector by a specific index.
	 * @paramter int#i the index of sector
	 * @return void
	 */
	bound : function(i) {
		this.sectors[i || 0].bound();
	},
	/**
	 * @method rebound sector by a specific index.
	 * @paramter int#i the index of sector
	 * @return void
	 */
	rebound : function(i) {
		this.sectors[i || 0].rebound();
	},
	/**
	 * @method Returns an array containing all sectors of this pie
	 * @return Array#the collection of sectors
	 */
	getSectors : function() {
		return this.sectors;
	},
	doAnimation : function(t, d,_) {
		var si = 0, cs = _.oA;
		_.sectors.each(function(s, i) {
			si = _.animationArithmetic(t, 0, s.get('totalAngle'), d);
			s.push('startAngle', cs);
			s.push('endAngle', cs + si);
			cs += si;
			if (!_.is3D())
				s.drawSector();
		});
		
		if (_.is3D()) {
			_.proxy.drawSector();
		}
	},
	parse : function(_) {
		_.data.each(function(d,i){
			_.doParse(_,d,i);
		},_);
		/**
		 * layout the label
		 */
		_.localizer(_);
	},
	doParse : function(_,d, i) {
		var t = d.name + ' ' +_.getPercent(d.value);
		
		_.doActing(_,d,i,t);
		
		_.push('sub_option.id', i);
		
		if(_.get('sub_option.label'))
		_.push('sub_option.label.text', t);
		
		_.push('sub_option.listeners.changed', function(se, st, i) {
			_.fireEvent(_, st ? 'bound' : 'rebound', [_, se.get('name')]);
		});
		_.sectors.push(_.doSector(_,d));
	},
	dolayout : function(_,x,y,l,d,Q) {
		if(_.is3D()?$.inEllipse(_.get(_.X) - x,_.topY-y,_.a,_.b):$.distanceP2P(_.get(_.X),_.topY,x,y)<_.r){
			y=_.topY-y;
			l.push('labelx',_.get(_.X)+(Math.sqrt(_.r*_.r-y*y)*2+d)*(Q==0||Q==3?1:-1));
			l.localizer(l);
		}
	},
	localizer:function(_){
		if (_.get('intellectLayout')) {
			var unlayout = [],layouted = [],d = _.get('layout_distance'),Q,x,y;
			
			_.sectors.each(function(f, i) {
				if(f.isLabel())
				unlayout.push(f.label);
			});
			
			unlayout.sor(function(p, q) {
				return Math.abs(Math.sin(p.get('angle'))) - Math.abs(Math.sin(q.get('angle')))>0;
			});
			
			unlayout.each(function(la) {
				layouted.each(function(l) {
					x = l.labelx, y = l.labely;
					if ((la.labely <= y && (y - la.labely-1) < la.get(_.H)) || (la.labely > y && (la.labely - y-1) < l.get(_.H))) {
						if ((la.labelx < x && (x - la.labelx) < la.get(_.W)) || (la.labelx > x && (la.labelx - x) < l.get(_.W))) {
							Q = la.get('quadrantd');
							la.push('labely', (la.get('labely')+ y - la.labely) + (la.get(_.H)  + d)*(Q>1?-1:1));
							la.localizer(la);
							_.dolayout(_,la.get('labelx'),la.get('labely')+la.get(_.H)/2*(Q<2?-1:1),la,d,Q);
						}
					}
				}, _);
				layouted.push(la);
			});
		}
	},
	doConfig : function() {
		$.Pie.superclass.doConfig.call(this);
		$.Assert.gt(this.total,0,'this.total');
		var _ = this._(),r = _.get('radius'), f = _.get('sub_option.label') ? 0.35 : 0.44,pi2=Math.PI*2;
		_.sub = _.is3D()?'Sector3D':'Sector2D';
		_.sectors = [];
		_.sectors.zIndex = _.get('z_index');
		_.components.push(_.sectors);
		_.oA = $.angle2Radian(_.get('offset_angle'))%pi2;
		//If 3D,let it bigger
		if (_.is3D())
			f += 0.06;
		
		f = Math.floor(_.get('minDistance') * f);
		
		var L = _.data.length,sepa = $.angle2Radian($.between(0,90,_.get('separate_angle'))),PI = pi2-sepa,sepa=sepa/L,eA = _.oA+sepa, sA = eA;
		
		_.data.each(function(d, i) {
			eA += (d.value / _.total) * PI;
			if (i == (L - 1)) {
				eA = pi2 + _.oA;
			}
			d.startAngle = sA;
			d.endAngle = eA;
			d.totalAngle = eA - sA;
			d.middleAngle = (sA + eA) / 2;
			sA = eA+sepa;
		}, _);
		
		r = $.parsePercent(r,f);
		/**
		 * calculate pie chart's radius
		 */
		if (r <= 0 || r > f) {
			r = _.push('radius',f);
		}
		_.r = r;
		
		/**
		 * calculate pie chart's alignment
		 */
		if (_.get('align') == _.L) {
			_.push(_.X, r + _.get('l_originx') + _.get('offsetx'));
		} else if (_.get('align') == _.R) {
			_.push(_.X, _.get('r_originx') - r + _.get('offsetx'));
		} else {
			_.push(_.X, _.get('centerx') + _.get('offsetx'));
		}
		_.topY = _.push(_.Y, _.get('centery') + _.get('offsety'));
		
		$.apply(_.get('sub_option'),$.clone([_.X, _.Y, 'bound_event','mutex','increment'], _.options));
		
	}
});
/** @end */

/**
 * @overview this component use for abc
 * @component#@chart#$.Pie2D
 * @extend#$.Pie
 */
$.Pie2D = $.extend($.Pie, {
	/**
	 * initialize the context for the pie2d
	 */
	configure : function() {
		/**
		 * invoked the super class's configuration
		 */
		$.Pie2D.superclass.configure.call(this);

		this.type = 'pie2d';

	},
	doSector:function(_){
		return  new $[_.sub](_.get('sub_option'), _);
	},
	doConfig : function() {
		$.Pie2D.superclass.doConfig.call(this);
		var _ = this._();
		/**
		 * quick config to all rectangle
		 */
		_.push('sub_option.radius',_.r)
		_.parse(_);
		
		
	}
});
/**
 * @end
 */
/**
 * @overview this component use for abc
 * @component#@chart#$.Pie3D
 * @extend#$.Pie
 */
$.Pie3D = $.extend($.Pie, {
	configure : function() {
		/**
		 * invoked the super class's configuration
		 */
		$.Pie3D.superclass.configure.apply(this, arguments);

		this.type = 'pie3d';
		this.dimension = $._3D;

		this.set({
			/**
			 * @cfg {Number} Three-dimensional rotation Z in degree(angle).socpe{0-90}.(default to 45)
			 */
			zRotate : 45,
			/**
			 * @cfg {Number} Specifies the pie's thickness in pixels.(default to 30)
			 */
			yHeight : 30
		});

	},
	doSector : function(_,d) {
		_.push('sub_option.cylinder_height', (d.cylinder_height ? d.cylinder_height * Math.cos($.angle2Radian(_.get('zRotate'))) : _.get('cylinder_height')));
		var s = new $[_.sub](_.get('sub_option'), _);
		s.proxy = true;
		return s;
	},
	doConfig : function() {
		$.Pie3D.superclass.doConfig.call(this);
		var _ = this._(), z = _.get('zRotate');
		_.push('zRotate', $.between(0, 90, 90 - z));
		_.push('cylinder_height', _.get('yHeight') * Math.cos($.angle2Radian(z)));
		_.a = _.push('sub_option.semi_major_axis', _.r);
		_.b = _.push('sub_option.semi_minor_axis', _.r * z / 90);
		_.topY = _.push('sub_option.originy', _.get(_.Y) - _.get('yHeight') / 2);
		
		_.parse(_);

		var layer,spaint,L = [],c = _.get('counterclockwise'), abs = function(n,M) {
			/**
			 * If M,close to pi/2,else pi*3/2
			 */
			return 1 + Math.sin(M?(n+Math.PI):n);
		}, t = 'startAngle', d = 'endAngle',Q,s,e
		/**
		 * If the inside layer visibile
		 */
		lay =function(C,g,z,f){
			Q = $.quadrantd(g);
			if (C &&(Q ==0 || Q ==3) || (!C && (Q ==2 || Q ==1))) {
				layer.push({
					g : g,
					z : g==z,
					x : f.x,
					y : f.y,
					a : f.a,
					b : f.b,
					color : $.dark(f.get('background_color')),
					h : f.h,
					F : f
				});
			}
		};

		_.proxy = new $.Custom({
			z_index : _.get('z_index') + 1,
			drawFn : function() {
				this.drawSector();
				L = [];
				_.sectors.each(function(s) {
					if (s.get('label')) {
						if (s.expanded)
							L.push(s.label);
						else
							s.label.draw();
					}
				});
				L.each(function(l) {
					l.draw()
				});
			}
		});
		_.proxy.drawSector = function() {
			/**
			 * paint bottom layer
			 */
			_.sectors.each(function(s, i) {
				_.T.ellipse(s.x, s.y + s.h, s.a, s.b, s.get(t), s.get(d), 0, s.get('border.enable'), s.get('border.width'), s.get('border.color'), s.get('shadow'), c, true);
			}, _);
			layer = [];
			spaint = [];
			/**
			 * sort layer
			 */
			_.sectors.each(function(f) {
				lay(c,f.get(t),f.get(d),f);
				lay(!c,f.get(d),f.get(t),f);
				spaint = spaint.concat($.visible(f.get(t),f.get(d),f));
			}, _);
			
			/**
			 * realtime sort
			 */
			layer.sor(function(p, q) {
				var r = abs(p.g) - abs(q.g);
				return r==0?p.z:r > 0;
			});

			/**
			 * paint inside layer
			 */
			layer.each(function(f, i) {
				_.T.sector3D.layerDraw.call(_.T, f.x, f.y, f.a + 0.5, f.b + 0.5, c, f.h, f.g, f.color);
			}, _);
			
			if(!_.processAnimation){	
				/**
				 * realtime sort
				 */
				spaint.sor(function(p, q) {
					return abs((p.s+p.e)/2,1) - abs((q.s+q.e)/2,1)<0;
				});
			}
			/**
			 * paint outside layer
			 */
			spaint.each(function(s, i) {
				_.T.sector3D.sPaint.call(_.T, s.f.x, s.f.y, s.f.a, s.f.b, s.s, s.e, c, s.f.h, s.f.get('f_color'));
			}, _);

			/**
			 * paint top layer
			 */
			_.sectors.each(function(s, i) {
				_.T.ellipse(s.x, s.y, s.a, s.b, s.get(t), s.get(d), s.get('f_color'), s.get('border.enable'), s.get('border.width'), s.get('border.color'), false, false, true);
			}, _);
		}

		_.components.push(_.proxy);
	}
});
/**
 * @end
 */

/**
 * @overview this component use for show a donut chart
 * @component#@chart#$.Donut2D
 * @extend#$.Pie
 */
$.Donut2D = $.extend($.Pie, {
	/**
	 * initialize the context for the pie2d
	 */
	configure : function() {
		/**
		 * invoked the super class's configuration
		 */
		$.Donut2D.superclass.configure.call(this);
		
		this.type = 'donut2d';
		
		this.set({
			/**
			 * @cfg {Number} Specifies the width when show a donut.If the value lt 1,It will be as a percentage,value will be radius*donutwidth.only applies when it not 0.(default to 0.3)
			 */
			donutwidth : 0.3,
			/**
			 * @cfg {Object/String} Specifies the config of Center Text details see <link>$.Text</link>,If given a string,it will only apply the text.note:If the text is empty,then will not display
			 */
			center : {
				text:'',
				line_height:24,
				fontweight : 'bold',
				/**
				 * Specifies the font-size in pixels of center text.(default to 24)
				 */
				fontsize : 24
			}
		});
	},
	doSector:function(){
		return  new $.Sector2D(this.get('sub_option'), this);
	},
	doConfig : function() {
		$.Donut2D.superclass.doConfig.call(this);
		
		var _ = this._(),d='donutwidth',r = _.r;
		/**
		 * quick config to all rectangle
		 */
		_.push('sub_option.radius',r)
		if(_.get(d)>0){
			if(_.get(d)<1){
				_.push(d,Math.floor(r*_.get(d)));
			}else if(_.get(d)>=r){
				_.push(d,0);
			}
			_.push('sub_option.donutwidth',_.get(d));
		}
		if ($.isString(_.get('center'))) {
			_.push('center', $.applyIf({
				text : _.get('center')
			}, _.default_.center));
		}
		
		if (_.get('center.text') != '') {
			_.push('center.originx',_.get(_.X));
			_.push('center.originy',_.get(_.Y));
			_.push('center.textBaseline','middle');
			_.components.push(new $.Text(_.get('center'), _));
		}
		
		_.parse(_);
	}
});
/**
 * @end
 */
/**
 * @overview this class is abstract,use for config column
 * @component#$.Column
 * @extend#$.Chart
 */
$.Column = $.extend($.Chart, {
	/**
	 * initialize the context for the Column
	 */
	configure : function(config) {
		/**
		 * invoked the super class's configuration
		 */
		$.Column.superclass.configure.call(this);

		this.type = 'column';
		
		this.set({
			/**
			 * @cfg {<link>$.Coordinate2D</link>} the option for coordinate.
			 */
			coordinate : {},
			/**
			 * @cfg {Number} the width of each column(default to calculate according to coordinate's width)
			 */
			colwidth : undefined,
			/**
			 * @cfg {Number} the distance of column's bottom and text(default to 6)
			 */
			text_space : 6,
			/**
			 * @cfg {String} the align of scale(default to 'left') Available value are:
			 * @Option 'left'
			 * @Option 'right'
			 */
			scaleAlign : 'left',
			/**
			 * @cfg {<link>$.Rectangle</link>} Specifies option of rectangle.
			 */
			sub_option : {},
			/**
			 * @cfg {<link>$.Text</link>} Specifies option of label at bottom.
			 */
			label:{}
		});

		this.registerEvent();

	},
	doAnimation : function(t, d,_) {
		var h;
		_.coo.draw();
		_.labels.each(function(l){
			l.draw();
		});
		_.rectangles.each(function(r){
			h = Math.ceil(_.animationArithmetic(t, 0, r.height, d));
			r.push(_.Y, r.y + (r.height - h));
			r.push(_.H, h);
			r.drawRectangle();
		});
	},
	/**
	 * @method Returns the coordinate of this element.
	 * @return $.Coordinate2D
	 */
	getCoordinate:function(){
		return this.coo;
	},
	doLabel:function(_,id,text,x, y){
		_.labels.push(new $.Text($.apply(_.get('label'),{
			id : id,
			text : text,
			originx : x,
			originy : y
		}), _));
	},
	doParse : function(_,d, i, o) {
		_.doActing(_,d,o,i);
	},
	doConfig : function() {
		$.Column.superclass.doConfig.call(this);
		
		var _ = this._(),c = 'colwidth',z = 'z_index';
		
		_.sub = _.is3D()?'Rectangle3D':'Rectangle2D';
		
		_.rectangles = [];
		_.labels = [];
		
		_.components.push(_.labels);
		_.components.push(_.rectangles);
		
		/**
		 * apply the coordinate feature
		 */
		$.Coordinate.coordinate.call(_);
		
		_.rectangles.zIndex = _.get(z);
		
		_.labels.zIndex = _.get(z) + 1;
		
		var L = _.data.length, W = _.get('coordinate.valid_width'),w_,hw,KL;
		
		if (_.dataType == 'simple') {
			w_= Math.floor(W*2 / (L * 3 + 1));
			hw = _.pushIf(c, w_);
			KL = L+1;
		}else{
			KL = _.get('labels').length;
			L = KL * L + (_.is3D()?(L-1)*KL*_.get('group_fator'):0);
			w_= Math.floor(W / (KL + 1 + L));
			hw = _.pushIf(c,w_);
			KL +=1;
		}
		
		if (hw * L > W) {
			hw = _.push(c, w_);
		}
		/**
		 * the space of two column
		 */
		_.push('hispace', (W - hw * L) / KL);
		
		if (_.is3D()) {
			_.push('zHeight', _.get(c) * _.get('zScale'));
			_.push('sub_option.zHeight', _.get('zHeight'));
			_.push('sub_option.xAngle_', _.get('xAngle_'));
			_.push('sub_option.yAngle_', _.get('yAngle_'));
		}
		/**
		 * use option create a coordinate
		 */
		_.coo = $.Coordinate.coordinate_.call(_);
		
		_.components.push(_.coo);
		
		_.push('sub_option.width', _.get(c));
	}

});
/**
 * @end
 */
/**
 * @overview the column2d componment
 * @component#@chart#$.Column2D
 * @extend#$.Column
 */
$.Column2D = $.extend($.Column, {
	/**
	 * initialize the context for the Column2D
	 */
	configure : function() {
		/**
		 * invoked the super class's configuration
		 */
		$.Column2D.superclass.configure.call(this);

		this.type = 'column2d';
		
	},
	doConfig : function() {
		$.Column2D.superclass.doConfig.call(this);
		/**
		 * get the max/min scale of this coordinate for calculated the height
		 */
		var _ = this._(),
			c = _.get('colwidth'),
			s = _.get('hispace'),
			S = _.coo.getScale(_.get('scaleAlign')),
			H = _.coo.get(_.H), 
			h2 = c / 2, 
			gw = c + s, 
			h,
			y0 = _.coo.get(_.Y) +  H,
			y = y0 - S.basic*H - (_.is3D()?(_.get('zHeight') * (_.get('bottom_scale') - 1) / 2 * _.get('yAngle_')):0),
			x = s+_.coo.get('x_start');
			y0 = y0 + _.get('text_space') + _.coo.get('axis.width')[2];
		_.data.each(function(d, i) {
			h = (d.value - S.start) * H / S.distance;
			_.doParse(_,d, i, {
				id : i,
				originx :x + i * gw,
				originy : y  - (h>0? h :0),
				height : Math.abs(h)
			});
			_.rectangles.push(new $[_.sub](_.get('sub_option'), _));
			_.doLabel(_,i, d.name, x + gw * i + h2, y0);
		}, _);
	}
});
/**
 *@end 
 */
/**
 * @overview this component use for abc
 * @component#@chart#$.Column3D
 * @extend#$.Column2D
 */
$.Column3D = $.extend($.Column2D, {
	/**
	 * initialize the context for the Column3D
	 */
	configure : function() {
		/**
		 * invoked the super class's configuration
		 */
		$.Column3D.superclass.configure.call(this);

		this.type = 'column3d';
		this.dimension = $._3D;

		this.set({
			/**
			 * @cfg {<link>$.Coordinate3D</link>} the option for coordinate.
			 */
			coordinate : {},
			/**
			 * @cfg {Number(0~90)} Three-dimensional rotation X in degree(angle).(default to 60)
			 */
			xAngle : 60,
			/**
			 * @cfg {Number(0~90)} Three-dimensional rotation Y in degree(angle).(default to 20)
			 */
			yAngle : 20,
			/**
			 * @cfg {Number} Three-dimensional z-axis deep factor.frame of reference is width.(default to 1)
			 */
			zScale : 1,
			/**
			 * @cfg {Number(1~)} Three-dimensional z-axis deep factor of pedestal.frame of reference is width.(default to 1.4)
			 */
			bottom_scale : 1.4
		});
	},
	doConfig : function() {
		$.Column3D.superclass.doConfig.call(this);
	}

});
/**
 *@end 
 */

/**
 * @overview this component will draw a cluster column2d chart.
 * @component#@chart#$.ColumnMulti2D
 * @extend#$.Column
 */
$.ColumnMulti2D = $.extend($.Column, {
	/**
	 * initialize the context for the ColumnMulti2D
	 */
	configure : function() {
		/**
		 * invoked the super class's configuration
		 */
		$.ColumnMulti2D.superclass.configure.call(this);

		this.type = 'columnmulti2d';
		this.dataType = 'complex';

		this.set({
			/**
			 * @cfg {Array} the array of labels close to the axis
			 */
			labels : []
		});

	},
	doConfig : function() {
		$.ColumnMulti2D.superclass.doConfig.call(this);

		/**
		 * get the max/min scale of this coordinate for calculated the height
		 */
		var _ = this._(),
			s = _.get('hispace'),
			bw = _.get('colwidth'), 
			H = _.coo.get(_.H), 
			S = _.coo.getScale(_.get('scaleAlign')), 
			q = bw * (_.get('group_fator') || 0), 
			gw = _.data.length * bw + s + (_.is3D() ? (_.data.length - 1) * q : 0), 
			h,
			x = _.coo.get('x_start') + s,
			y = _.coo.get(_.Y) - S.basic * H + H,
			y0=_.coo.get(_.Y) + H + _.get('text_space')+ _.coo.get('axis.width')[2];
		
		_.columns.each(function(column, i) {
			column.item.each(function(d, j) {
				h = (d.value - S.start) * H / S.distance;
				_.doParse(_, d, j, {
					id : i + '-' + j,
					originx : x + j * (bw + q) + i * gw,
					originy : y - (h > 0 ? h : 0),
					height : Math.abs(h)
				});
				_.rectangles.push(new $[_.sub](_.get('sub_option'), this));
			}, _);

			_.doLabel(_, i, column.name, x - s * 0.5 + (i + 0.5) * gw, y0);
		}, _);

	}
});
/**
 * @end
 */

/**
 * @overview this component will draw a cluster column3d chart.
 * @component#@chart#$.ColumnMulti3D
 * @extend#$.ColumnMulti2D
 */
$.ColumnMulti3D = $.extend($.ColumnMulti2D, {
	/**
	 * initialize the context for the ColumnMulti3D
	 */
	configure : function() {
		/**
		 * invoked the super class's configuration
		 */
		$.ColumnMulti3D.superclass.configure.call(this);

		this.type = 'columnmulti3d';
		this.dataType = 'complex';
		this.dimension = $._3D;

		this.set({
			/**
			 * @cfg {Number(0~90)} Three-dimensional rotation X in degree(angle).(default to 60)
			 */
			xAngle : 60,
			/**
			 * @cfg {Number(0~90)} Three-dimensional rotation Y in degree(angle).(default to 20)
			 */
			yAngle : 20,
			/**
			 * @cfg {Number} Three-dimensional z-axis deep factor.frame of reference is width.(default to 1)
			 */
			zScale : 1,
			group_fator : 0.3,
			/**
			 * @cfg {Number(1~)} Three-dimensional z-axis deep factor of pedestal.frame of reference is width.(default to 1.4)
			 */
			bottom_scale : 1.4
		});
	},
	doConfig : function() {
		$.ColumnMulti3D.superclass.doConfig.call(this);

		

	}
});
/**
 * @end
 */

/**
 * @overview this class is abstract,use for config bar
 * @component#$.Bar
 * @extend#$.Chart
 */
$.Bar = $.extend($.Chart, {
	/**
	 * initialize the context for the bar
	 */
	configure : function() {
		/**
		 * invoked the super class's configuration
		 */
		$.Bar.superclass.configure.call(this);

		this.type = 'bar';
		this.set({
			/**
			 * @cfg {<link>$.Coordinate2D</link>} the option for coordinate.
			 */
			coordinate : {
				striped_direction : 'h'
			},
			/**
			 * @cfg {Number} Specifies the width of each bar(default to calculate according to coordinate's height)
			 */
			barheight : undefined,
			/**
			 * @cfg {Number} Specifies the distance of bar's bottom and text(default to 6)
			 */
			text_space : 6,
			/**
			 * @cfg {String} Specifies the align of scale(default to 'bottom') Available value are:
			 * @Option 'bottom'
			 */
			scaleAlign : 'bottom',
			/**
			 * @cfg {<link>$.Rectangle</link>} Specifies option of rectangle.
			 */
			sub_option : {},
			/**
			 * @cfg {<link>$.Text</link>} Specifies option of label at left.
			 */
			label : {}
		});
	},
	/**
	 * @method Returns the coordinate of this element.
	 * @return $.Coordinate2D
	 */
	getCoordinate : function() {
		return this.coo;
	},
	doLabel : function(id, text, x, y) {
		this.labels.push(new $.Text($.apply(this.get('label'), {
			id : id,
			text : text,
			textAlign : 'right',
			textBaseline : 'middle',
			originx : x,
			originy : y
		}), this));
	},
	doParse : function(_, d, i, o) {
		_.doActing(_, d, o,i);
	},
	doAnimation : function(t, d,_) {
		_.coo.draw();
		_.labels.each(function(l) {
			l.draw();
		});
		_.rectangles.each(function(r) {
			r.push(_.W, Math.ceil(_.animationArithmetic(t, 0, r.width, d)));
			r.drawRectangle();
		});
	},
	doConfig : function() {
		$.Bar.superclass.doConfig.call(this);

		var _ = this._(), b = 'barheight', z = 'z_index';
		/**
		 * Apply the coordinate feature
		 */
		$.Coordinate.coordinate.call(_);

		_.rectangles = [];
		_.labels = [];
		_.rectangles.zIndex = _.get(z);
		_.labels.zIndex = _.get(z) + 1;
		_.components.push(_.labels);
		_.components.push(_.rectangles);

		var L = _.data.length, H = _.get('coordinate.valid_height'),h_,bh,KL;
		
		if (_.dataType == 'simple') {
			h_= Math.floor(H*2 / (L * 3 + 1));
			bh = _.pushIf(b, h_);
			KL = L+1;
		}else{
			KL = _.get('labels').length;
			L = KL * L + (_.is3D()?(L-1)*KL*_.get('group_fator'):0);
			h_= Math.floor(H / (KL + 1 + L));
			bh = _.pushIf(b,h_);
			KL +=1;
		}
		
		if (bh * L > H) {
			bh = _.push(b, h_);
		}
		/**
		 * the space of two bar
		 */
		_.push('barspace', (H - bh * L) / KL);

		/**
		 * use option create a coordinate
		 */
		_.coo = $.Coordinate.coordinate_.call(_);

		_.components.push(_.coo);

		/**
		 * quick config to all rectangle
		 */
		_.push('sub_option.height', bh);
		_.push('sub_option.valueAlign', _.R);
		_.push('sub_option.tipAlign', _.R);
	}

});
/**
 * @end
 */

/**
 * @overview this component will draw a bar2d chart.
 * @component#@chart#$.Bar2D
 * @extend#$.Bar
 */
$.Bar2D = $.extend($.Bar, {
	/**
	 * initialize the context for the pie
	 */
	configure : function() {
		/**
		 * invoked the super class's configuration
		 */
		$.Bar2D.superclass.configure.call(this);

		this.type = 'bar2d';

	},
	doConfig : function() {
		$.Bar2D.superclass.doConfig.call(this);
		/**
		 * get the max/min scale of this coordinate for calculated the height
		 */
		var _ = this._(),
			h = _.get('barheight'),
			b = _.get('barspace'),
			S = _.coo.getScale(_.get('scaleAlign')),
			W = _.coo.get(_.W),
			h2 = h / 2,
			gw = h + b,
			w,
			I = _.coo.get(_.X) + S.basic * W,
			x0 = _.coo.get(_.X) - _.get('text_space')-_.coo.get('axis.width')[3], 
			y0 = _.coo.get('y_start')+ b;
		
		_.data.each(function(d, i) {
			w = (d.value - S.start) * W / S.distance;
			_.doParse(_, d, i, {
				id : i,
				originy : y0 + i * gw,
				width : Math.abs(w),
				originx : I + (w > 0 ? 0 : -Math.abs(w))
			});

			_.rectangles.push(new $.Rectangle2D(_.get('sub_option'), _));
			_.doLabel(i, d.name, x0, y0 + i * gw + h2);
		}, _);
	}

});
/**
 * @end
 */

/**
 * @overview this component will draw a cluster bar2d chart.
 * @component#@chart#$.BarMulti2D
 * @extend#$.Bar
 */
$.BarMulti2D = $.extend($.Bar, {
	/**
	 * initialize the context for the BarMulti2D
	 */
	configure : function() {
		/**
		 * invoked the super class's configuration
		 */
		$.BarMulti2D.superclass.configure.call(this);

		this.type = 'barmulti2d';
		this.dataType = 'complex';

		this.set({
			/**
			 * @cfg {Array} the array of labels close to the axis
			 */
			labels : []
		});
	},
	doConfig : function() {
		$.BarMulti2D.superclass.doConfig.call(this);

		/**
		 * get the max/min scale of this coordinate for calculated the height
		 */
		var _ = this._(), L = _.data.length,W = _.coo.get(_.W), b = 'barheight', s = 'barspace',bh=_.get(b),
		S = _.coo.getScale(_.get('scaleAlign')), gw = L * bh + _.get(s), h2 = _.get(b) / 2,w,
		I = _.coo.get(_.X) + S.basic*W,x = _.coo.get(_.X)-_.get('text_space')-_.coo.get('axis.width')[3],
		y = _.coo.get('y_start')+ _.get(s);
		
		_.columns.each(function(column, i) {
			column.item.each(function(d, j) {
				w = (d.value - S.start) * W / S.distance;
				_.doParse(_, d, j, {
					id : i + '-' + j,
					originy : y + j * bh + i * gw,
					width : Math.abs(w),
					originx: I+(w>0?0:-Math.abs(w))
				});
				_.rectangles.push(new $.Rectangle2D(_.get('sub_option'), _));
			}, _);
			_.doLabel(i, column.name, x, y - _.get(s) * 0.5 + (i + 0.5) * gw);
		}, _);
	}

});
/**
 * @end
 */

/**
 * Line ability for real-time show
 * 
 * @overview this component use for abc
 * @component#$.LineSegment
 * @extend#$.Component
 */
$.LineSegment = $.extend($.Component, {
	configure : function() {
		/**
		 * invoked the super class's configuration
		 */
		$.LineSegment.superclass.configure.apply(this, arguments);

		/**
		 * indicate the component's type
		 */
		this.type = 'linesegment';

		this.set({
			/**
			 * @cfg {Number} Specifies the default linewidth of the canvas's context in this element.(defaults to 1)
			 */
			brushsize : 1,
			/**
			 * @cfg {Boolean} If true there show a point when Line-line intersection(default to true)
			 */
			intersection : true,
			/**
			 * @cfg {<link>$.Text</link>} Specifies the config of label,set false to make label disabled.
			 */
			label : {},
			/**
			 * @cfg {String} Specifies the shape of two line segment' point(default to 'round').Only applies when intersection is true Available value are:
			 * @Option 'round'
			 */
			sign : 'round',
			/**
			 * @cfg {Boolean} If true the centre of point will be hollow.(default to true)
			 */
			hollow : true,
			/**
			 * @cfg {Boolean} If true the color of the centre of point will be hollow_color.else will be background_color.(default to true)
			 */
			hollow_inside:true,
			/**
			 * @cfg {String} Specifies the bgcolor when hollow applies true.(default to '#FEFEFE')
			 */
			hollow_color : '#FEFEFE',
			/**
			 * @cfg {Boolean} If true Line will smooth.(default to false)
			 */
			smooth : false,
			/**
			 * @cfg {Number} Specifies smoothness of line will be.(default to 1.5)
			 * 1 means control points midway between points, 2 means 1/3 from the point,formula is 1/(smoothing + 1) from the point
			 */
			smoothing : 1.5,
			/**
			 * @cfg {Number} Specifies the size of point.(default size 6).Only applies when intersection is true
			 */
			point_size : 6,
			/**
			 * @inner {Array} the set of points to compose line segment
			 */
			points : [],
			/**
			 * @inner {Boolean} If true the event accord width coordinate.(default to false)
			 */
			keep_with_coordinate : false,
			/**
			 * @cfg {Number} Override the default as 1
			 */
			shadow_blur : 1,
			/**
			 * @cfg {Number} Override the default as 1
			 */
			shadow_offsety : 1,
			/**
			 * @inner {Number} Specifies the space between two point
			 */
			point_space : 0,
			/**
			 * @inner {Object} reference of coordinate
			 */
			coordinate : null,
			/**
			 * @cfg {Number} Specifies the valid range of x-direction.(default to 0)
			 */
			event_range_x : 0,
			/**
			 * @cfg {Boolean} If true tip show when the mouse must enter the valid distance of axis y.(default to false)
			 */
			limit_y : false,
			/**
			 * @cfg {Number} Specifies the space between the tip and point.(default to 2)
			 */
			tip_offset : 2,
			/**
			 * @cfg {Number} Specifies the valid range of y-direction.(default to 0)
			 */
			event_range_y : 0
		});
		
		this.registerEvent(
				/**
				 * @event Fires when parse this label's data.Return value will override existing.
				 * @paramter <link>$.LineSegment</link>#seg
				 * @paramter string#text the current label's text
				 */
				'parseText');
		
		this.tip = null;
		this.ignored_ = false;
	},
	drawSegment : function() {
		var _ = this._(),p = _.get('points'),b=_.get('f_color'),h=_.get('brushsize');
		if (_.get('area')) {
			_.T.polygon(_.get('light_color2'), false, 1, '', false,_.get('area_opacity'),  _.get('smooth')?p:[{x:_.x,y:_.y}].concat(p.concat([{x:_.x + _.get(_.W),y:_.y}])), _.get('smooth'), _.get('smoothing'),[{x:_.x,y:_.y},{x:_.x + _.get(_.W),y:_.y}]);
		}
		
		_.T.shadowOn(_.get('shadow'));
		
		_.T[_.ignored_?"manyLine":"lineArray"](p,h, b, _.get('smooth'), _.get('smoothing'));
		
		if (_.get('intersection')) {
			var f = _.getPlugin('sign'),s=_.get('point_size'),j = _.get('hollow_color');
			if(_.get('hollow_inside')){
				j=b;
				b = _.get('hollow_color');
			}
			
			p.each(function(q,i){
				if(!q.ignored){
					if(!f||!f.call(_,_.T,_.get('sign'),q.x, q.y,s,b,j)){
						if (_.get('hollow')) {
							_.T.round(q.x, q.y, s/2-h,b,h+1,j);
						} else {
							_.T.round(q.x, q.y, s/2,b);
						}
					}
				}
			},_);
		}
		
		if (_.get('shadow')) {
			_.T.shadowOff();
		}
	},
	doDraw : function(_) {
		_.drawSegment();
		if (_.get('label')) {
			_.labels.each(function(l){
				l.draw();
			});
		}
	},
	isEventValid : function() {
		return {
			valid : false
		};
	},
	tipInvoke : function() {
		var x = this.x, y = this.y, o = this.get('tip_offset'), s = this.get('point_size') + o, _ = this;
		return function(w, h, m) {
			var l = m.left, t = m.top;
			l = ((_.tipPosition < 3 && (l - w - x - o > 0)) || (_.tipPosition > 2 && (l - w - x - o < 0))) ? l - (w + o) : l + o;
			t = _.tipPosition % 2 == 0 ? t + s : t - h - s;
			return {
				left : l,
				top : t
			}
		}
	},
	doConfig : function() {
		$.LineSegment.superclass.doConfig.call(this);
		$.Assert.gt(this.get('point_space'),0,'point_space');

		var _ = this._(),L = !!_.get('label'),ps = _.get('point_size') * 3 / 2,sp = _.get('point_space'), ry = _.get('event_range_y'), rx = _.get('event_range_x'), heap = _.get('tipInvokeHeap'), p = _.get('points'),N=_.get('name');
		
		_.labels = [];
		
		p.each(function(q){
			q.x_ = q.x;
			q.y_ = q.y;
			if(q.ignored)_.ignored_ = true;
			if(!q.ignored&&L){
				_.push('label.originx', q.x);
				_.push('label.originy', q.y-ps);
				_.push('label.text',_.fireString(_, 'parseText', [_, q.value],q.value));
				$.applyIf(_.get('label'),{
					textBaseline : 'bottom',
					color:_.get('f_color')
				});
				_.labels.push(new $.Text(_.get('label'), _))
			}
		});
		
		if (rx <= 0||rx > sp / 2) {
			rx = _.push('event_range_x', sp / 2);
		}
		
		if (ry == 0) {
			ry = _.push('event_range_y', ps/2);
		}
		
		if (_.get('tip.enable')) {
			/**
			 * _ use for tip coincidence
			 */
			_.on('mouseover', function(c,e, m) {
				heap.push(_);
				_.tipPosition = heap.length;
			}).on('mouseout', function(c,e, m) {
				heap.pop();
			});
			_.push('tip.invokeOffsetDynamic', true);
			_.tip = new $.Tip(_.get('tip'), _);
		}

		var c = _.get('coordinate'), ly = _.get('limit_y'), k = _.get('keep_with_coordinate'), valid = function(p0, x, y) {
			if (!p0.ignored&&Math.abs(x - (p0.x)) < rx && (!ly || (ly && Math.abs(y - (p0.y)) < ry))) {
				return true;
			}
			return false;
		}, to = function(i) {
			return {
				valid : true,
				name : N,
				value : p[i].value,
				text : p[i].text,
				top : p[i].y,
				left : p[i].x,
				i:i,
				hit : true
			};
		};
		
		/**
		 * override the default method
		 */
		_.isEventValid = function(e) {
			if (c && !c.isEventValid(e,c).valid) {
				return {
					valid : false
				};
			}
			
			var ii = Math.floor((e.x - _.x) / sp);
			
			if (ii < 0 || ii >= (p.length - 1)) {
				ii = $.between(0, p.length - 1, ii);
				if (valid(p[ii], e.x, e.y))
					return to(ii);
				else
					return {
						valid : k
					};
			}
			
			/**
			 * calculate the pointer's position will between which two point?this function can improve location speed
			 */
			for ( var i = ii; i <= ii + 1; i++) {
				if (valid(p[i], e.x, e.y))
					return to(i);
			}
			return {
				valid : k
			};
		}

	}
});
/**
 *@end
 */	

/**
 * @overview this class is abstract,use for config line
 * @component#$.Line
 * @extend#$.Chart
 */
$.Line = $.extend($.Chart, {
	/**
	 * initialize the context for the line
	 */
	configure : function() {
		/**
		 * invoked the super class's configuration
		 */
		$.Line.superclass.configure.call(this);

		this.type = 'line';

		this.set({
			/**
			 * @cfg {Number} Specifies the default linewidth of the canvas's context in this element.(defaults to 1)
			 */
			brushsize : 1,
			/**
			 * @cfg {Object} the option for coordinate
			 */
			coordinate : {
				axis : {
					width : [0, 0, 2, 2]
				}
			},
			/**
			 * @cfg {Object} Specifies config crosshair.(default enable to false).For details see <link>$.CrossHair</link> Note:this has a extra property named 'enable',indicate whether crosshair available(default to false)
			 */
			crosshair : {
				enable : false
			},
			/**
			 * @cfg {Function} when there has more than one linesegment,you can use tipMocker make them as a tip.(default to null)
			 * @paramter Array tips the array of linesegment's tip
			 * @paramter int the index of data
			 * @return String
			 */
			tipMocker:null,
			/**
			 * @cfg {Number(0.0~1.0)} If null,the position there will follow the points.If given a number,there has a fixed postion,0 is top,and 1 to bottom.(default to null)
			 */
			tipMockerOffset:null,
			/**
			 * @cfg {String} the align of scale.(default to 'left') Available value are:
			 * @Option 'left'
			 * @Option 'right'
			 */
			scaleAlign : 'left',
			/**
			 * @cfg {String} the align of label.(default to 'bottom') Available value are:
			 * @Option 'top,'bottom'
			 */
			labelAlign : 'bottom',
			/**
			 * @cfg {Array} the array of labels close to the axis
			 */
			labels : [],
			/**
			 * @inner {Number} the distance of column's bottom and text.(default to 6)
			 */
			label_space : 6,
			/**
			 * @inner {Boolean} if the point are proportional space.(default to true)
			 */
			proportional_spacing : true,
			/**
			 * @inner {Number} the space of each label
			 */
			label_spacing : 0,
			/**
			 * @cfg {<link>$.LineSegment</link>} the option for linesegment.
			 */
			sub_option : {},
			/**
			 * {Object} the option for legend.
			 */
			legend : {
				sign : 'bar'
			},
			/**
			 * @cfg {<link>$.Text</link>} Specifies option of label at bottom.
			 */
			label:{}
		});

		this.registerEvent(
		/**
		 * @event Fires when parse this element'data.Return value will override existing.
		 * @paramter object#data the data of one linesegment
		 * @paramter object#v the point's value
		 * @paramter int#x coordinate-x of point
		 * @paramter int#y coordinate-y of point
		 * @paramter int#index the index of point
		 * @return Object object Detail:
		 * @property text the text of point
		 * @property x coordinate-x of point
		 * @property y coordinate-y of point
		 */
		'parsePoint');

	},
	/**
	 * @method Returns the coordinate of this element.
	 * @return $.Coordinate2D
	 */
	getCoordinate : function() {
		return this.coo;
	},
	doConfig : function() {
		$.Line.superclass.doConfig.call(this);
		var _ = this._(), s = _.data.length == 1;
		
		/**
		 * apply the coordinate feature
		 */
		$.Coordinate.coordinate.call(_);
		
		var vw = _.get('coordinate.valid_width'),vh = _.get('coordinate.valid_height');
		_.lines = [];
		_.lines.zIndex = _.get('z_index');
		_.components.push(_.lines);
		
		if (_.get('proportional_spacing'))
			_.push('label_spacing', vw / (_.get('maxItemSize') - 1));
		
		_.push('sub_option.width', vw);
		_.push('sub_option.height', vh);
		_.pushIf('sub_option.keep_with_coordinate',s);
		
		if (_.get('crosshair.enable')) {
			_.push('coordinate.crosshair', _.get('crosshair'));
			_.push('coordinate.crosshair.hcross', s);
			_.push('coordinate.crosshair.invokeOffset', function(e, m) {
				/**
				 * TODO how fire muti line?now fire by first line
				 */
				var r = _.lines[0].isEventValid(e);
				return r.valid ? r : false;
			});
		}
		
		_.pushIf('coordinate.scale',[{
			position : _.get('scaleAlign'),
			max_scale : _.get('maxValue')
		}, {
			position : _.get('labelAlign'),
			start_scale : 1,
			scale : 1,
			end_scale : _.get('maxItemSize'),
			labels : _.get('labels'),
			label:_.get('label')
		}]);
		
		/**
		 * use option create a coordinate
		 */
		_.coo = $.Coordinate.coordinate_.call(_);
		
		_.push('sub_option.originx', _.coo.get('x_start'));
		_.push('sub_option.originy', _.coo.get(_.Y) + _.coo.get(_.H));
		
		_.components.push(_.coo);
		
		if (_.get('tip.enable')){
			if($.isFunction(_.get('tipMocker'))){
				_.push('sub_option.tip.enable', false);
				_.push('tip.invokeOffsetDynamic', true);
				var U,x=_.coo.get(_.X),y=_.coo.get(_.Y),H=_.coo.get(_.H),f = _.get('tipMockerOffset'),r0,r,r1;
				f = $.isNumber(f)?(f<0?0:(f>1?1:f)):null;
				_.push('tip.invokeOffset',function(w,h,m){
					if(f!=null){
						m.top = y+(H-h)*f;
					}else{
						m.top = m.maxTop-(m.maxTop-m.minTop)/3-h;
						if(h>H||y>m.top){
							m.top = y;
						}
					}
					return {
						left:(m.left - w - x  > 5)?m.left-w-5:m.left+5,
						top:m.top
					}
				});
				/**
				 * proxy the event parseText
				 */
				var p = _.get('tip.listeners.parseText');
				if(p)
				delete _.get('tip.listeners').parseText;
				var mocker = new $.Custom({
					eventValid:function(e){
						r = _.lines[0].isEventValid(e);
						r.hit = r0 != r.i;
						if(r.valid){
							r0 = r.i;
							U = [];
							_.lines.each(function(l,i){
								r1 = l.isEventValid(e);
								if(i==0){
									r.minTop = r.maxTop = r1.top;
								}else{
									r.minTop = Math.min(r.minTop,r1.top);
									r.maxTop = Math.max(r.maxTop,r1.top);
								}
								U.push(p?p(null,r1.name,r1.value,r1.text,r1.i):(r1.name+' '+r1.value));
							});
							r.text = _.get('tipMocker').call(_,U,r.i)||'tipMocker not return';
						}
						return r.valid ? r : false;
					}
				});
				new $.Tip(_.get('tip'),mocker);
				_.components.push(mocker);
			}
		}
		
		/**
		 * quick config to all linesegment
		 */
		$.applyIf(_.get('sub_option'), $.clone(['area_opacity'], _.options));
	}

});
/**
 * @end
 */

/**
 * @overview this component will draw a line2d chart.
 * @component#@chart#$.LineBasic2D
 * @extend#$.Line
 */
$.LineBasic2D = $.extend($.Line, {
	/**
	 * initialize the context for the LineBasic2D
	 */
	configure : function() {
		/**
		 * invoked the super class's configuration
		 */
		$.LineBasic2D.superclass.configure.call(this);

		this.type = 'basicline2d';

		this.tipInvokeHeap = [];
	},
	doAnimation : function(t, d,_) {
		_.coo.draw();
		_.lines.each(function(l){
			l.get('points').each(function(p){
				p.y = l.y - Math.ceil(_.animationArithmetic(t, 0, l.y - p.y_, d));
			});
			l.drawSegment();
		});
	},
	doConfig : function() {
		$.LineBasic2D.superclass.doConfig.call(this);
		var _ = this._();
		
		/**
		 * get the max/min scale of this coordinate for calculated the height
		 */
		var S = _.coo.getScale(_.get('scaleAlign')), H = _.get('coordinate.valid_height'), sp = _.get('label_spacing'), points, x, y, 
		ox = _.get('sub_option.originx'), oy = _.get('sub_option.originy')- S.basic*H, p;
		
		_.push('sub_option.tip.showType', 'follow');
		_.push('sub_option.coordinate', _.coo);
		_.push('sub_option.tipInvokeHeap', _.tipInvokeHeap);
		_.push('sub_option.point_space', sp);
		
		
		_.data.each(function(d, i) {
			points = [];
			d.value.each(function(v, j) {
				x = sp * j;
				y = (v - S.start) * H / S.distance;
				p = {
					x : ox + x,
					y : oy - y,
					value : v,
					text : d.name+' '+v
				};
				$.merge(p, _.fireEvent(_, 'parsePoint', [d, v, x, y, j]));
				points.push(p);
			}, _);
			
			_.push('sub_option.name', d.name);
			_.push('sub_option.points', points);
			_.push('sub_option.brushsize', d.linewidth || d.line_width || 1);
			_.push('sub_option.background_color', d.background_color || d.color);
			_.lines.push(new $.LineSegment(_.get('sub_option'), _));
		}, this);
	}

});
/**
 * @end
 */

/**
 * @overview this component use for abc
 * @component#@chart#$.Area2D
 * @extend#$.LineBasic2D
 */
$.Area2D = $.extend($.LineBasic2D, {
	/**
	 * initialize the context for the area2d
	 */
	configure : function() {
		/**
		 * invoked the super class's configuration
		 */
		$.Area2D.superclass.configure.call(this);

		this.type = 'area2d';

		this.set({
			/**
			 * @cfg {Float} Specifies the opacity of this area.(default to 0.3)
			 */
			area_opacity : 0.3
		});

	},
	doConfig : function() {
		/**
		 * must apply the area's config before
		 */
		this.push('sub_option.area', true);
		$.Area2D.superclass.doConfig.call(this);
	}
});
/**
 * @end
 */

})(iChart);