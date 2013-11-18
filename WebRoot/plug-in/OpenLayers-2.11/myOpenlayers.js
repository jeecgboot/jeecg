var mapServerIP = "localhost";// 地图服务器ip地址
var mapServerPort = "8080";// 地图服务器端口号
var map;// 地图id
var tiled;// 基础图层
var format = 'image/png';// 图层格式
var popup;// 浮云
var selectLayer;// 选择层
var hightLayer;// 高亮显示层
var drawLayer;// 绘画层
var markers;// marker层
var bufferLayer;// buffer层
var drawBtufferPoint;// 点缓冲控件
var drawBufferLine;// 线缓冲控件
var snap;// 断开控制
var editfeature;// 编辑控件
var dragfeature;// 拖动控件
var deletefeature;// 删除控件
// 圆选
var findCircle;
// 点选
var findPoint;
// 四边形选
var findSquare;
// 多边形选
var findPolygon;
// 线选
var findLine;
// 画点
var drawPoint;
// 画面
var drawPolygon;
// 画线.
var drawLine;
// 添加标注事件
var markClick;
// 添加标注层
var lableLayer;
// 距离量算
var measureDistance;
// 面积量算
var measureArea;
var jsondata;
// 设置代理服务器
OpenLayers.ProxyHost = "cgi/proxy.cgi?url=";

// 创建测试层
var testLayer = null;

// 定义渲染图形开始
OpenLayers.Renderer.symbol.lightning = [ 0, 0, 4, 2, 6, 0, 10, 5, 6, 3, 4, 5,
		0, 0 ];
OpenLayers.Renderer.symbol.rectangle = [ 0, 0, 10, 0, 10, 4, 0, 4, 0, 0 ];
OpenLayers.Renderer.symbol.church = [ 4, 0, 6, 0, 6, 4, 10, 4, 10, 6, 6, 6, 6,
		14, 4, 14, 4, 6, 0, 6, 0, 4, 4, 4, 4, 0 ];
// 定义渲染图形结束
function init() {
	// allow testing of specific renderers via "?renderer=Canvas", etc开始
	var renderer = OpenLayers.Util.getParameters(window.location.href).renderer;
	renderer = (renderer) ? [ renderer ]
			: OpenLayers.Layer.Vector.prototype.renderers;
	// allow testing of specific renderers via "?renderer=Canvas", etc 结束
	var bounds = new OpenLayers.Bounds(-124.73142200000001,24.955967,-66.969849,49.371735);
	var options = {
		controls : [],
		maxExtent : bounds,	//最大地图边界
		//maxResolution : 984018,	//最大解析度
		projection : "EPSG:4326",
		//maxScale : 1,
		//numZoomLevels : 6,
		//maxExtent: new OpenLayers.Bounds(-200000, -200000, 200000, 200000),
		maxResolution: 20,
		units : 'm'
	};
	map = new OpenLayers.Map("map", options);
	// 定义基本图层开始
	tiled = new OpenLayers.Layer.WMS("states", "http://" + mapServerIP
			+ ":" + mapServerPort + "/geoserver/topp/wms?layers=states", {
		LAYERS : 'states',
		STYLES : '',
		format : format,
		tiled : true,
		tileSize : new OpenLayers.Size(256, 256),
		tilesOrigin : map.maxExtent.left + ',' + map.maxExtent.bottom
	}, {
		buffer : 0,
		displayOutsideMaxExtent : true,
		isBaseLayer : true,
		yx : {
			'EPSG:2326' : true
		}
	});
	map.addLayers([ tiled ]);
	// 定义基本图层结束

	// 定义测试层开始
	testLayer = new OpenLayers.Layer.Vector('testLayer');
	map.addLayers([ testLayer ]);
	// 定义测试层结束

	// 定义选择层开始
	// 定义选择图层的样式
	var sketchSymbolizers = {
		"Point" : {
			pointRadius : 4,
			fillColor : "white",
			fillOpacity : 1,
			strokeWidth : 1,
			strokeOpacity : 1,
			strokeColor : "#333333"
		},
		"Line" : {
			strokeWidth : 3,
			strokeOpacity : 1,
			strokeColor : "#666666",
			strokeDashstyle : "dash"
		},
		"Polygon" : {
			strokeWidth : 2,
			strokeOpacity : 1,
			strokeColor : "#666666",
			fillColor : "blue",
			fillOpacity : 0.3
		}
	};
	var style = new OpenLayers.Style();
	style.addRules([ new OpenLayers.Rule({
		symbolizer : sketchSymbolizers
	}) ]);
	var styleMap = new OpenLayers.StyleMap({
		"default" : style
	});
	selectLayer = new OpenLayers.Layer.Vector("selectLayer", {
		styleMap : styleMap
	});
	map.addLayers([ selectLayer ]);
	// 定义选择层结束

	// 定义高亮显示层开始
	hightLayer = new OpenLayers.Layer.Vector("hightLayer");
	map.addLayers([ hightLayer ]);
	// 定义高亮显示曾结束

	// 定义缓冲区层开始
	// 定义缓冲区层样式
	var bufferSketchSymbolizers = {
		"Point" : {
			pointRadius : 2,
			strokeWidth : 0.5,
			strokeOpacity : 0.15,
			strokeColor : "#FFFFFF",
			fillColor : "red",
			fillOpacity : 0.8
		},
		"Line" : {
			strokeWidth : 0.8,
			strokeOpacity : 1,
			strokeColor : "red",
			fillColor : "red",
			fillOpacity : 0.8
		},
		"Polygon" : {
			strokeWidth : 0.8,
			strokeOpacity : 0.15,
			strokeColor : "#666666",
			fillColor : "blue",
			fillOpacity : 0.1
		}
	};
	var bufferStyle = new OpenLayers.Style();
	bufferStyle.addRules([ new OpenLayers.Rule({
		symbolizer : bufferSketchSymbolizers
	}) ]);
	var bufferStyleMap = new OpenLayers.StyleMap({
		"default" : bufferStyle
	});
	bufferLayer = new OpenLayers.Layer.Vector("bufferLayer", {
		styleMap : bufferStyleMap
	});
	map.addLayers([ bufferLayer ]);
	// 定义缓冲区层结束

	// 定义绘图层开始
	// 保存绘制的图
	var saveStrategy = new OpenLayers.Strategy.Save();
	// 注册保存成功事件
	saveStrategy.events.register("success", '', showSuccessMsg);
	// 注册保存失败事件
	saveStrategy.events.register("fail", '', showFailureMsg);

	drawLayer = new OpenLayers.Layer.Vector(
			"drawLayer",
			{
				strategies : [ new OpenLayers.Strategy.BBOX(), saveStrategy ],
				projection : new OpenLayers.Projection("EPSG:2362"),
				protocol : new OpenLayers.Protocol.WFS(
						{
							version : "1.1.0",
							srsName : "EPSG:2362",
							url : "http://" + mapServerIP + ":" + mapServerPort
									+ "/geoserver/wfs",
							featureNS : "zhengzhou",
							featurePrefix : "zhengzhou",
							featureType : "m_test",
							geometryName : "geom",
							schema : "http://"
									+ mapServerIP
									+ ":"
									+ mapServerPort
									+ "/geoserver/wfs?service=wfs&request=DescribeFeatureType&version=1.1.0&typename=m_test"
						})
			});
	map.addLayers([ drawLayer ]);
	// 定义绘图层开始

	// 定义标注层开始
	// 标注层样式
	var lableSketchSymbolizers = {
		pointRadius : "${pointRadius}",
		graphicName : "${graphicName}",
		externalGraphic : "${imp}",
		fillColor: "${fillColor}",
		fillOpacity: 1,
		pointerEvents : "visiblePainted",
		label : "${type}",
		fontColor : "${favColor}",
		fontSize : "${fontsize}px",
		fontFamily : "Courier New, monospace",
		fontWeight : "bold",
		labelAlign : "${align}",
		labelXOffset : "${xOffset}",
		labelYOffset : "${yOffset}",
		labelOutlineColor : "black",
		labelOutlineWidth : 3
	};

	var lableStyle = new OpenLayers.Style();
	lableStyle.addRules([ new OpenLayers.Rule({
		symbolizer : lableSketchSymbolizers
	}) ]);
	var lableStyleMap = new OpenLayers.StyleMap({
		"default" : lableStyle
	});

	lableLayer = new OpenLayers.Layer.Vector("lableLayer", {
		styleMap : lableStyleMap,
		renderers : renderer
	});
	map.addLayers([ lableLayer ]);
	// 定义标注层结束

	// 定义markers层开始
	markers = new OpenLayers.Layer.Markers("Markers",
		{maxResolution : 150.546875,
		projection : "EPSG:2362",
		units : 'm'}
	);
	map.addLayers([ markers ]);
	// 定义markers层结束

	// 配置断开控件开始
	// configure the snapping agent
	snap = new OpenLayers.Control.Snapping({
		layer : drawLayer,
		targets : [ drawLayer, lableLayer ],
		greedy : false
	});
	snap.activate();
	// 配置断开控件结束

	// 导航
	var navigate = new OpenLayers.Control.Navigation({
		title : "Pan Map"
	});
	var container = document.getElementById("panel");
	var panel = new OpenLayers.Control.Panel({
		div : container
	});
	// 圆԰选
	findCircle = new OpenLayers.Control.DrawFeature(selectLayer,
			OpenLayers.Handler.RegularPolygon, {
				title : "Draw circle Feature",
				displayClass : "olControlFindFeatureCircle",
				handlerOptions : {
					sides : 40,
					irregular : false,
					layerOptions : {
						styleMap : styleMap
					}
				},
				multi : true
			});
	// 点选
	findPoint = new OpenLayers.Control.DrawFeature(selectLayer,
			OpenLayers.Handler.Point, {
				title : "Draw Point Feature",
				displayClass : "olControlFindFeaturePoint",
				handlerOptions : {
					layerOptions : {
						styleMap : styleMap
					}
				}
			});

	// 四边形选
	findSquare = new OpenLayers.Control.DrawFeature(selectLayer,
			OpenLayers.Handler.RegularPolygon, {
				title : "Draw Square Feature",
				displayClass : "olControlFindFeatureSquare",
				handlerOptions : {
					sides : 4,
					irregular : 'checked',
					layerOptions : {
						styleMap : styleMap
					}
				},
				multi : true
			});
	// 多边形选
	findPolygon = new OpenLayers.Control.DrawFeature(selectLayer,
			OpenLayers.Handler.Polygon, {
				title : "Draw Polygon Feature",
				displayClass : "olControlFindFeaturePolygon",
				multi : true,
				handlerOptions : {
					layerOptions : {
						styleMap : styleMap
					}
				}
			});
	// 线选
	findLine = new OpenLayers.Control.DrawFeature(selectLayer,
			OpenLayers.Handler.Path, {
				title : "Draw Line Feature",
				displayClass : "olControlFindFeatureLine",
				multi : true,
				handlerOptions : {
					layerOptions : {
						styleMap : styleMap
					}
				}
			});

	// 画点
	drawPoint = new OpenLayers.Control.DrawFeature(drawLayer,
			OpenLayers.Handler.Point, {
				title : "Draw Point Feature",
				displayClass : "olControlDrawFeaturePoint",
				multi : false
			});

	// 画缓冲区点
	drawBufferPoint = new OpenLayers.Control.DrawFeature(
			bufferLayer,
			OpenLayers.Handler.Point,
			{
				title : "Draw PointBuffer Feature",
				multi : false,
				featureAdded : function(feature) {
					document.getElementById('biaodian').innerHTML = "已标点";
					document.getElementById('biaodiangeo').value = feature.geometry;
					drawBufferPoint.deactivate();
				}
			});
	// 画线.
	drawLine = new OpenLayers.Control.DrawFeature(drawLayer,
			OpenLayers.Handler.Path, {
				title : "Draw Line Feature",
				displayClass : "olControlDrawFeaturePath",
				multi : true
			});
	drawLine.handler.stopDown = null;
	drawLine.handler.stopUp = null;
	// 画缓冲区线
	drawBufferLine = new OpenLayers.Control.DrawFeature(
			bufferLayer,
			OpenLayers.Handler.Path,
			{
				title : "Draw LineBuffer Feature",
				multi : true,
				featureAdded : function(feature) {
					document.getElementById('huaxian').innerHTML = "已画线";
					document.getElementById('huaxiangeo').value = feature.geometry;
					drawBufferLine.deactivate();
				}
			});

	// 画面
	drawPolygon = new OpenLayers.Control.DrawFeature(drawLayer,
			OpenLayers.Handler.Polygon, {
				title : "Draw Polygon Feature",
				displayClass : "olControlDrawFeaturePolygon",
				featureAdded : function(feature) {
					// addFeaturePopup(feature);
				},
				multi : true
			});
	drawPolygon.handler.stopDown = null;
	drawPolygon.handler.stopUp = null;

	// 移动图
	dragfeature = new OpenLayers.Control.DragFeature(drawLayer, {
		title : "Drag Feature",
		displayClass : "olControlMoveFeature"
	});

	// 编辑
	editfeature = new OpenLayers.Control.ModifyFeature(drawLayer, {
		title : "Modify Feature",
		displayClass : "olControlModifyFeature"
	});
	// 删除
	deletefeature = new DeleteFeature(drawLayer, {
		title : "Delete Feature"
	});
	// 保存
	var savefeature = new OpenLayers.Control.Button({
		title : "Save Changes",
		trigger : function() {
			$.messager.progress({
				text : '页面加载中....',
				interval : 100
			});
			if (editfeature.feature) {
				editfeature.selectControl.unselectAll();
			}
			saveStrategy.save();
			$.messager.progress('close');
		},
		displayClass : "olControlSaveFeatures"
	});
	// 清除绘画层上画的东西
	var clearAll = new OpenLayers.Control.Button({
		title : "clear all feature",
		trigger : function() {
			setDeactivate();// 禁用控件
			clearFeatur("lableLayer,drawLayer");// 清空层上的要素
			clearAllMarks();
		},
		displayClass : "olControlClearAll"
	});

	// 距离量算
	measureDistance = new OpenLayers.Control.Measure(OpenLayers.Handler.Path, {
		title : "标尺",
		displayClass : "olControlMeasureDistance",
		persist : true,
		handlerOptions : {
			layerOptions : {
				styleMap : styleMap
			}
		}
	});
	measureDistance.events.on({
		"measure" : handleMeasurements,
		"measurepartial" : handleMeasurements
	});
	map.addControl(measureDistance);
	// 面积量算

	measureArea = new OpenLayers.Control.Measure(OpenLayers.Handler.Polygon, {
		title : "Measure Area",
		displayClass : "olControlMeasureArea",
		persist : true,
		handlerOptions : {
			layerOptions : {
				styleMap : styleMap
			}
		}
	});

	measureArea.events.on({
		"measure" : handleMeasurements,
		"measurepartial" : handleMeasurements
	});
	map.addControl(measureArea);

	panel.addControls([ navigate, findPoint, findLine, findSquare, findPolygon,
			findCircle, measureDistance, measureArea, drawPoint, drawLine,
			drawPolygon, dragfeature, editfeature, deletefeature, savefeature,
			clearAll ]);
	panel.defaultControl = navigate;

	// 尺度缩放控件
	map.addControl(new OpenLayers.Control.PanZoomBar({
		position : new OpenLayers.Pixel(2, 10)
	}));
	// map.addControl(new OpenLayers.Control.Scale());
	//鼠标移动，获取度坐标
	map.addControl(new OpenLayers.Control.MousePosition());
	// map.addControl(new OpenLayers.Control.LayerSwitcher());
	map.addControl(panel);

	map.addControl(drawBufferPoint);
	map.addControl(drawBufferLine);
	markClick = new OpenLayers.Control.MarkClick();
	map.addControl(markClick);


	map.setCenter(new OpenLayers.LonLat(38468045.3952319, 3850465.45737641), 7);

	selectLayer.events.on({
		beforefeatureadded : function(event) {
			$.messager.progress({
				text : '页面加载中....',
				interval : 100
			});

			// 获得图层
			var tcxz = $("#tcxz").val();
			// 设置要查询的typename
			var tc = "zhengzhou:" + tcxz;
			geometry = event.feature.geometry;
			var operatType = geometry.CLASS_NAME;// 定义操作类型，点选，线选，面选等
			var filter = new OpenLayers.Filter.Logical({
				type : OpenLayers.Filter.Logical.AND,
				filters : [ new OpenLayers.Filter.Spatial({
					type : OpenLayers.Filter.Spatial.INTERSECTS, // INTERSECTS,//相交OK
					value : geometry,
					projection : "EPSG:2362"
				}) ]
			});
			// 获得ajax参数
			var xmlPara = getXmlPara(tc, filter);
			// 获得ajax url
			var url = "http://" + mapServerIP + ":" + mapServerPort
					+ "/geoserver/wfs?";
			var request = OpenLayers.Request.POST({
				url : url,
				data : xmlPara,
				callback : function(req) {
					if (operatType == "OpenLayers.Geometry.Point") {// 若为点选
						selectQueryPoint(req);
					} else {// 不是点选
						selectQueryList(req, tcxz);
					}
				}
			});
		}
	});

}

// 函数名称：getXmlPara
// 描述：获得ajax参数
// 参数：tc 图层，geometry 要素geometry
function getXmlPara(tc, filter) {

	var filter_1_0 = new OpenLayers.Format.Filter.v1_0_0();
	var xml = new OpenLayers.Format.XML();
	var xmlPara = "<?xml version='1.0' encoding='UTF-8'?>"
			+ "<wfs:GetFeature service='WFS' version='1.0.0' "
			+ "xmlns:wfs='http://www.opengis.net/wfs' "
			+ "xmlns:gml='http://www.opengis.net/gml' "
			+ "xmlns:ogc='http://www.opengis.net/ogc' "
			+ "xmlns:xsi='http://www.w3.org/2001/XMLSchema-instance' "
			+ "xsi:schemaLocation='http://www.opengis.net/wfs http://schemas.opengis.net/wfs/1.0.0/wfs.xsd'>"
			+ "<wfs:Query typeName='" + tc + "' srsName='EPSG:2362'>"
			+ xml.write(filter_1_0.write(filter)) + "</wfs:Query>"
			+ "</wfs:GetFeature>";
	return xmlPara;
}
// 处理点选返回的结果
function selectQueryPoint(req) {
	// 清除buffer层上的浮云
	clearAllFeaturPopups("bufferLayer");
	// 清除图层的要素
	clearFeatur("selectLayer,bufferLayer,hightLayer,drawLayer");
	// 清除markers
	clearAllMarks();
	// 设置消息栏为空
	document.getElementById('message').innerHTML = "";
	var gmlParse = new OpenLayers.Format.GML();
	var features = gmlParse.read(req.responseText);
	if (features.length == 0) {
		$.messager.progress('close');
		alert("该范围内没有要查找的信息！");
		return false;
	}
	// 创建浮云
	createPopup(features);

}
// 处理线选，面选，多边形选返回的结果
function selectQueryList(req, tcxz) {

	// 清除buffer层上的浮云
	clearAllFeaturPopups("bufferLayer");
	// 清除图层的要素
	clearFeatur("selectLayer,bufferLayer,hightLayer,drawLayer");
	// 清除markers
	clearAllMarks();
	// 设置消息栏为空
	document.getElementById('message').innerHTML = "";
	var result = "";
	var gmlParse = new OpenLayers.Format.GML();
	var features = gmlParse.read(req.responseText);
	var feature;

	var i = 0;
	for ( var feat in features) {
		feature = features[feat];
		if (i == 0) {
			var temp = feature.fid.split(".");
			result += temp[1];
		} else {
			var temp = feature.fid.split(".");
			result += "," + temp[1];
		}
		i++;
		// 高亮显示
		hightLayer.addFeatures([ feature ]);
	}
	// 查询数据
	$('#mapQueryList').datagrid({
		url : 'mapController.do?queryFromMap&field=gid,name',
		queryParams : {
			param : result,
			tcxz : tcxz
		}
	});
	// 清空原来选中的
	$('#mapQueryList').datagrid('clearSelections');
	// 切换到结果标签
	switchlabels('tabs', '结果');
	$.messager.progress('close');
}
// 函数名称：createPopup
// 描述：弹出点选详细信息
// 参数：features 要素
function createPopup(features) {
	for ( var feat in features) {
		var result = "<table id=\"tt\" class=\"featureInfo\"  style=\"width:200px;height:auto;\"> "
				+ "<thead> "
				+ "<tr>"
				+ "<th field=\"name2\" width=\"10\" >名称</th>  "
				+ "</tr>"
				+ "</thead>" + "<tbody>";
		feature = features[feat];
		hightLayer.addFeatures([ feature ]);
		var geometry = feature.geometry;
		var featureid = feature.fid;
		var attributes = feature.attributes;
		result += "<tr onclick='alert(1)' value=" + feature.fid
				+ "> </td> <td>" + attributes['name'] + "</td></tr>";
		result += "</tbody>" + "</table>";
		var popup = new OpenLayers.Popup.FramedCloud("chicken",
				feature.geometry.getBounds().getCenterLonLat(), null, result,
				null, true);
		feature.popup = popup;
		map.addPopup(popup);
	}
	$.messager.progress('close');
}
// 量算处理--显示量算结果--OK
function handleMeasurements(event) {
	var geometry = event.geometry;
	var units = event.units;
	var order = event.order;
	var measure = event.measure;
	var out = "";
	if (order == 1) {
		out += "距离: " + measure.toFixed(3) + " " + units;
	} else {
		out += "面积: " + measure.toFixed(3) + " " + units + "<sup>2</" + "sup>";
	}
	document.getElementById('message').innerHTML = out;

}

// 删除图元--OK
var DeleteFeature = OpenLayers.Class(OpenLayers.Control, {
	initialize : function(layer, options) {
		OpenLayers.Control.prototype.initialize.apply(this, [ options ]);
		this.layer = layer;
		this.handler = new OpenLayers.Handler.Feature(this, layer, {
			click : this.clickFeature
		});
	},
	clickFeature : function(feature) {
		// if feature doesn't have a fid, destroy it
		if (feature.fid == undefined) {
			this.layer.destroyFeatures([ feature ]);
		} else {
			feature.state = OpenLayers.State.DELETE;
			this.layer.events.triggerEvent("afterfeaturemodified", {
				feature : feature
			});
			feature.renderIntent = "select";
			this.layer.drawFeature(feature);
		}
	},
	setMap : function(map) {
		this.handler.setMap(map);
		OpenLayers.Control.prototype.setMap.apply(this, arguments);
	},
	CLASS_NAME : "OpenLayers.Control.DeleteFeature"
});

function showSuccessMsg() {
	showMsg("保存成功");
};

function showFailureMsg() {
	showMsg("保存失败");
};

function showMsg(szMessage) {
	document.getElementById('message').innerHTML = szMessage;
	// 切换到结果标签
	switchlabels('tabs', '结果');
}
// 高亮显示定位的要素开始
function showHightLight(fids, tcxz) {
	$.messager.progress({
		text : '页面加载中....',
		interval : 100
	});
	var tc = "zhengzhou:" + tcxz;
	var temp = fids.split(",");
	var my_filter = new OpenLayers.Filter.FeatureId({
		fids : temp
	});
	var xmlPara = getXmlPara(tc, my_filter);
	var url = "http://" + mapServerIP + ":" + mapServerPort + "/geoserver/wfs?"
	var request = OpenLayers.Request.POST({
		url : url,
		data : xmlPara,
		callback : showHight
	});
}
// 高亮显示定位的要素结束
// 高亮显示
function showHight(req) {

	var gmlParse = new OpenLayers.Format.GML();
	var features = gmlParse.read(req.responseText);
	var feature;
	for ( var feat in features) {
		feature = features[feat];
		// 高亮显示
		hightLayer.addFeatures([ feature ]);
		var tcxz = $("#tcxz").val();
		addMarkerAndPopup(feature, tcxz);
		// 获得当前地图bounds
		var currentBonds = map.getExtent();
		// 获得feature bounds
		var featurebounds = feature.geometry.getBounds();
		if (!currentBonds.containsBounds(featurebounds, false, true)) {// 判断featurebouns是否在当前bounds内，若在内不重新定位，若不在内，重新定位
			// 获得当前缩放级别
			var level = map.getZoom();
			// 重新定位
			// map.setCenter(new OpenLayers.LonLat(feature.geometry.getBounds()
			// .getCenterLonLat().lon, feature.geometry.getBounds()
			// .getCenterLonLat().lat), level);
			var lonlat = feature.geometry.getBounds().getCenterLonLat();
			locateMap(lonlat, level);
		}

	}
	$.messager.progress('close');
}
function addMarkerAndPopup(feature, tcxz) {
	// 定位中心位置经度

	var lon = feature.geometry.getBounds().getCenterLonLat().lon;

	// 定位中心位置纬度
	var lat = feature.geometry.getBounds().getCenterLonLat().lat;
	// 定位标签大小
	var size = new OpenLayers.Size(20, 25);
	// 偏移量
	var offset = new OpenLayers.Pixel(-(size.w / 2), -size.h);
	// 图片地址
	var icon = new OpenLayers.Icon("plug-in/OpenLayers-2.11/img/marker.png",
			size, offset);
	// 创建marker
	var marker = new OpenLayers.Marker(new OpenLayers.LonLat(lon, lat), icon);
	// 注册map事件当点击地图任意地方时隐藏popup
	map.events.register('mousedown', map, function(evt) {
		if (popup != null) {
			map.removePopup(popup);
		}
	});
	marker.events
			.register(
					'mousedown',
					marker,
					function(evt) {
						// 当点击其他marker时隐藏popop
						if (popup != null) {
							map.removePopup(popup);
						}
						var geometry = feature.geometry;
						var attributes = feature.attributes;
						var result = "<table id=\"tt\" class=\"featureInfo\"  style=\"width:200px;height:auto;\"> "
								+ "<thead> "
								+ "<tr>"
								+ "<th field=\"name2\" width=\"10\" >名称</th>  "
								+ "</tr>" + "</thead>" + "<tbody>";
						result += "<tr onclick='alert(1)' value=" + feature.fid
								+ "> </td> <td>" + attributes['name']
								+ "</td></tr>";
						result += "</tbody>" + "</table>";
						popup = new OpenLayers.Popup.FramedCloud("chicken",
								feature.geometry.getBounds().getCenterLonLat(),
								null, result, null, true);
						popup.closeOnMove = true;
						// feature.popup = popup;
						map.addPopup(popup);
						OpenLayers.Event.stop(evt);
					});

	markers.addMarker(marker);
}

// 函数名称：locateMap
// 描述：定位地图
// 参数：lonlat 经纬度，level 缩放级别

function locateMap(lonlat, level) {
	// 当没有传入中心经纬度时取当前中心点经纬度
	if (lonlat == null || lonlat == "") {
		lonlat = new OpenLayers.LonLat(map.getCenter().lon, map.getCenter().lat);
	}
	// 当没有传入级别时获得当前缩放级别
	if (level == null || level == "") {
		level = map.getZoom();
	}
	map.setCenter(lonlat, level);

}
// 函数名称：switchlabels
// 描述：切换标签
// 参数：tabs easyui-tabs id,title 标签标题

function switchlabels(tabs, title) {
	$('#' + tabs + '').tabs('select', title);
}
// 函数名称：clearAllFeaturPopups
// 描述：清除某层上的全部feature popup
// 参数：lay 层
function clearAllFeaturPopups(lay) {
	var myfeatures;
	if (lay == "bufferLayer") {
		myfeatures = bufferLayer.features;
	} else if (lay == "drawLayer") {
		myfeatures = drawLayer.features;
	} else if (lay == "hightLayer") {
		myfeatures = hightLayer.features;
	}
	for ( var i = myfeatures.length - 1; i >= 0; i--) {
		var feature = myfeatures[i];
		if (feature.popup != null) {
			map.removePopup(feature.popup);
			feature.popup.destroy();
			feature.popup = null;
		}

	}
}
// 函数名称：clearFeatur
// 描述：清除给定层上的全部feature
// 参数：lay层，以逗号分开
function clearFeatur(lay) {
	if (lay != null && lay != "") {
		var lays = lay.split(",");
		for ( var i = 0; i < lays.length; i++) {
			if (lays[i] == "selectLayer") {
				selectLayer.removeAllFeatures();
			}
			if (lays[i] == "bufferLayer") {
				bufferLayer.removeAllFeatures();
			}
			if (lays[i] == "hightLayer") {
				hightLayer.removeAllFeatures();
			}
			if (lays[i] == "drawLayer") {
				drawLayer.removeAllFeatures();
			}
			if (lays[i] == "lableLayer") {
				lableLayer.removeAllFeatures();
			}
		}
	}
}

// 高亮显示buffer选中的信息，并返回信息列表开始
function showBuffer(req, tcxz) {
	var gmlParse = new OpenLayers.Format.GML();
	var features = gmlParse.read(req.responseText);
	var feature;
	var result = "-1";
	var i = 0;
	for ( var feat in features) {
		feature = features[feat];
		var temp = feature.fid.split(".");
		result += "," + temp[1];
		i++;
		hightLayer.addFeatures([ feature ]);

	}
	// 查询数据
	$('#mapQueryList').datagrid({
		url : 'mapController.do?queryFromMap&field=gid,name',
		queryParams : {
			param : result,
			tcxz : tcxz
		}
	});
	// 清空原来选中的
	$('#mapQueryList').datagrid('clearSelections');
	// 切换到结果标签
	switchlabels('tabs', '结果');
	$.messager.progress('close');
}
// 高亮显示buffer选中的信息，并返回信息列表结束
// 缓冲区查询开始
// 线缓冲区查询
function bufferQuerey(tcxz, geomstr, radius) {
	$.messager.progress({
		text : '页面加载中....',
		interval : 100
	});
	// 设置要查询的typename
	var tc = "zhengzhou:" + tcxz;
	$.ajax({
		async : false,
		cache : false,
		type : 'POST',
		dataType : 'html',
		url : "mapController.do?getBuffer&geomstr=" + geomstr + "&radius="
				+ radius,// 请求的action路径
		error : function() {// 请求失败处理函数
		},
		success : function(data) {
			var featurecollection = data;
			var geojson_format = new OpenLayers.Format.GeoJSON();
			var plg = geojson_format.read(featurecollection, "Geometry");
			bufferLayer.addFeatures(geojson_format.read(featurecollection));

			var filter = new OpenLayers.Filter.Logical({
				type : OpenLayers.Filter.Logical.AND,
				filters : [ new OpenLayers.Filter.Spatial({
					type : OpenLayers.Filter.Spatial.WITHIN,
					value : plg,
					projection : "EPSG:2362"
				}) ]
			});
			var xmlPara = getXmlPara(tc, filter);
			// 获得ajax url
			var url = "http://" + mapServerIP + ":" + mapServerPort
					+ "/geoserver/wfs?";
			var request = OpenLayers.Request.POST({
				url : url,
				data : xmlPara,
				callback : function(req) {
					showBuffer(req, tcxz);
				}
			});
		}
	});
}
// 缓冲区查询结束


// 注册添加添加标注Handler
// 注册添加标注Event
OpenLayers.Control.MarkClick = OpenLayers.Class(OpenLayers.Control, {
	defaultHandlerOptions : {
		'single' : true,
		'double' : false,
		'pixelTolerance' : 0,
		'stopSingle' : false,
		'stopDouble' : false
	},
	initialize : function(options) {
		this.handlerOptions = OpenLayers.Util.extend({},
				this.defaultHandlerOptions);
		OpenLayers.Control.prototype.initialize.apply(this, arguments);
		this.handler = new OpenLayers.Handler.Click(this, {
			'click' : this.trigger
		}, this.handlerOptions);
	},
	trigger : function(e) {
		var lonlat = map.getLonLatFromPixel(e.xy);
		createBiaozhu(lonlat);
	}
});
// 函数名称：reformStr
// 格式化字符串，实现换行功能
// 参数：str 杨格式化的字符串，len 长度
function reformStr(str, len) {
	var retStr = "";
	var l = str.length;
	if (l > len) {
		var tl = Math.ceil(l / len);
		for ( var i = 0; i < tl; i++) {
			if (i == 0) {
				if ((i * len + len) < l) {
					retStr += str.substring(i * len, (i * len + len));
				} else {
					retStr += str.substring(i * len, l);
				}
			} else {
				if ((i * len + len) < l) {
					retStr += "\n" + str.substring(i * len, (i * len + len));
				} else {
					retStr += "\n" + str.substring(i * len, l);
				}
			}
		}
	} else {
		retStr = str;
	}
	return retStr;
}
function createBiaozhu(lonlat) {
	
	
	var imgType = $("#imgType").val();
	var fhys = $("#fhys").val();
	var fhdz = $("#fhdz").val();
	if(fhdz==""){
		fhdz=0;
	}
	var markerTitle = $("#markerTitle").val();// 描述
	var markerztsize = $("#markerztsize").val();// 字体大小
	if(markerztsize==""){
		markerztsize=0;
	}
	var markerweizhix = $("#markerweizhix").val();// 位置x
	if(markerweizhix==""){
		markerweizhix=0;
	}
	var markerweizhy = $("#markerweizhiy").val();// 位置y
	if(markerweizhy==""){
		markerweizhy=0
	}
	var markeryanse = $("#markeryanse").val();// 设置颜色
	var point = new OpenLayers.Geometry.Point(lonlat.lon, lonlat.lat);
	var layFeature = new OpenLayers.Feature.Vector(point);
	if (imgType == "tp") {
		var url = $("#imgpath").val();
		layFeature.attributes = {
			pointRadius : fhdz,
			graphicName : "",
			fillColor: "#ee9900",
			imp : url,
			type : reformStr(markerTitle, 5),
			favColor : markeryanse,
			fontsize : markerztsize,
			xOffset : markerweizhix,
			yOffset : markerweizhy,
			align : "lb"
		};
	} else if(imgType == "fh") {
		var url = $("#imgpath").val();
		layFeature.attributes = {
			pointRadius : fhdz,
			fillColor: fhys,
			graphicName : url,
			imp : "",
			type : reformStr(markerTitle, 5),
			favColor : markeryanse,
			fontsize : markerztsize,
			xOffset : markerweizhix,
			yOffset : markerweizhy,
			align : "lb"
		}
	}else{
		layFeature.attributes = {
			pointRadius : 6,
			graphicName : "",
			fillColor: "#ee9900",
			imp : "",
			type : reformStr(markerTitle, 5),
			favColor : markeryanse,
			fontsize : markerztsize,
			xOffset : markerweizhix,
			yOffset : markerweizhy,
			align : "lb"
		};
	}
	lableLayer.addFeatures(layFeature);
	markClick.deactivate();
}

// 区域查询
function regionSelect(fids, tcxz) {
	$.messager.progress({
		text : '页面加载中....',
		interval : 100
	});
	var tc = "zhengzhou:" + tcxz
	// 获得区域信息
	var my_filter = new OpenLayers.Filter.FeatureId({
		fids : [ fids ]
	});
	var xmlPara = getXmlPara(tc, my_filter);
	var url = "http://" + mapServerIP + ":" + mapServerPort + "/geoserver/wfs?"
	var request = OpenLayers.Request.POST({
		url : url,
		data : xmlPara,
		callback : showRegion
	});
}
// 显示区域信息
function showRegion(req) {

	var gmlParse = new OpenLayers.Format.GML();
	var features = gmlParse.read(req.responseText);
	// 获得图层
	var tcxz = $("#tcxz").val();
	// 设置要查询的typename
	var tc = "zhengzhou:" + tcxz;
	var feature;
	for ( var feat in features) {
		feature = features[feat];
		// 高亮显示
		bufferLayer.addFeatures([ feature ]);
		// 定位中心位置经度
		var lon = feature.geometry.getBounds().getCenterLonLat().lon;
		// 定位中心位置纬度
		var lat = feature.geometry.getBounds().getCenterLonLat().lat;
		var currentBonds = map.getExtent();
		// 获得feature bounds
		var featurebounds = feature.geometry.getBounds();
		if (!currentBonds.containsBounds(featurebounds, false, true)) {// 判断featurebouns是否在当前bounds内，若在内不重新定位，若不在内，重新定位
			// 获得当前缩放级别
			var level = map.getZoom();
			// 重新定位
			var lonlat = new OpenLayers.LonLat(lon, lat);
			locateMap(lonlat, 2);
		}
		// 到数据库取数据
		if (tcxz == "m_building") {
			// 查询数据
			$('#mapQueryList').datagrid({
				url : 'mapController.do?getRegionInfo&field=gid,name',
				queryParams : {
					param : feature.fid.split(".")[1],
					tcxz : tcxz
				}
			});
			// 清空原来选中的
			$('#mapQueryList').datagrid('clearSelections');
			// 切换到结果标签
			switchlabels('tabs', '结果');
			$.messager.progress('close');
		} else {
			// 查询区域内信息
			var filter = new OpenLayers.Filter.Logical({
				type : OpenLayers.Filter.Logical.AND,
				filters : [ new OpenLayers.Filter.Spatial({
					type : OpenLayers.Filter.Spatial.WITHIN, // INTERSECTS,
					// //相交OK
					value : feature.geometry, // geometry,
					projection : "EPSG:2362"
				}) ]
			});
			var xmlPara = getXmlPara(tc, filter);
			var url = "http://" + mapServerIP + ":" + mapServerPort
					+ "/geoserver/wfs?"
			var request = OpenLayers.Request.POST({
				url : url,
				data : xmlPara,
				callback : function(req) {
					showBuffer(req, tcxz);
				}
			});
		}
	}
}
// 清理marker层开始
function clearAllMarks() {
	var mymarks = markers.markers;
	for ( var i = mymarks.length - 1; i >= 0; i--) {
		markers.removeMarker(mymarks[i]);
	}
}
// 清理marker层结束

// 关闭弹出的信息
function onPopupClose(evt) {
	clearAllFeaturPopups("drawLayer");// 关闭弹出的窗口
	clearFeatur("drawLayer");// 清除文字标注层
}

// 选择图层开始
// 函数名称：selectTuCeng
// 描述：选择图层
// 参数：tuceng图层
function selectTuCeng(tuceng) {
	locateMap("", "");// 重新定位地图
	queryTuCeng(tuceng);// 查询图层
}
// 选择图层结束

// 查询图层开始
// 函数名称：queryTuCeng
// 描述：查询图层
// 参数：tuceng图层
function queryTuCeng(tuceng) {
	// 清除buffer层上的浮云
	clearAllFeaturPopups("bufferLayer");
	// 清除图层的要素
	clearFeatur("selectLayer,bufferLayer,hightLayer,drawLayer");
	// 清除markers
	clearAllMarks();
	// 设置消息栏为空
	document.getElementById('message').innerHTML = "";
	var param = $.trim($("#param").val());
	if (param == "") {
		param = "-1";
	}
	$('#mapQueryList').datagrid({
		url : 'mapController.do?querymap&field=gid,name',
		queryParams : {
			param : param,
			tcxz : tuceng
		}
	});
	$('#mapQueryList').datagrid('clearSelections');
	// 切换到结果标签
	switchlabels('tabs', '结果');
}
// 查询图层结束
// 清除缓冲查询层上的全部Features 开始
function ClearBufferLayer() {
	clearFeatur("bufferLayer");
}
// 清除缓冲查询层上的全部Features 结束

// 函数名称：bufferActive
// 描述：激活缓冲区查询开始
// 参数：type 激活控件类型，dian 点缓冲，xian 线缓冲
function bufferActive(type) {
	clearFeatur("selectLayer,bufferLayer,hightLayer,drawLayer");// 清空层上的要素
	clearAllMarks();// 清空marker层
	setDeactivate();// 停用其它控件
	if (type == "dian") {
		drawBufferPoint.activate();
	} else if (type == "xian") {
		drawBufferLine.activate();
	}
}
// 激活缓冲区查询结束
// 停用控件开始
function setDeactivate() {
	findCircle.deactivate();
	findPoint.deactivate();
	findSquare.deactivate();
	findPolygon.deactivate();
	findLine.deactivate();
	drawPoint.deactivate();
	drawPolygon.deactivate();
	drawLine.deactivate();
	measureDistance.deactivate();
	measureArea.deactivate();
}
// 停用控件结束

// 函数名称：querenBuffer
// 描述：缓冲区查询
// 参数：type 查询类型，dian 点缓冲查询，xian 线缓冲查询
function querenBuffer(type) {
	// 获得图层
	var tcxz = $("#tcxz").val();
	if (type == "dian") {
		var biaodian = $("#biaodian").text();
		var radius = $("#fanwei").val();
		var geomstr = $("#biaodiangeo").val();
		if (biaodian == "已标点") {
			bufferQuerey(tcxz, geomstr, radius);
		} else {
			alert("请标点！");
			return false;
		}
		document.getElementById('biaodian').innerHTML = "未标点";
	} else if (type == "xian") {
		var huaxian = $("#huaxian").text();
		var radius = $("#fanweiLine").val();
		var geomstr = $("#huaxiangeo").val();
		if (huaxian == "已画线") {
			bufferQuerey(tcxz, geomstr, radius);
		} else {
			alert("请画线！");
			return false;
		}
		document.getElementById('huaxian').innerHTML = "未画线";
	}
}
// 区域查询开始
function onClickRowregionList() {
	// 清除buffer层上的浮云
	clearAllFeaturPopups("bufferLayer");
	// 清除图层的要素
	clearFeatur("selectLayer,bufferLayer,hightLayer,drawLayer");
	// 清除markers
	clearAllMarks();
	// 设置消息栏为空
	document.getElementById('message').innerHTML = "";
	var row = $('#regionList').datagrid('getSelected');// 获得选中的区域
	var fid = row["gid"];
	fid = "m_xingzhengqujie." + fid;
	var tcxz = "m_xingzhengqujie";
	regionSelect(fid, tcxz);
}
// 区域查询结束
// 精确定位地图开始
function onClickRowmapQueryList() {
	dingwei();
}
// 精确定位地图结束
// 地图定位开始
function dingwei() {
	setDeactivate();// 停用控件
	// 清除buffer层上的浮云
	clearAllFeaturPopups("bufferLayer");
	// 清除图层的要素
	clearFeatur("selectLayer,hightLayer,drawLayer");
	// 清除markers
	clearAllMarks();
	// 设置消息栏为空
	document.getElementById('message').innerHTML = "";
	var fids = "";
	var tcxz = $("#tcxz").val();
	var fid = getmapQueryListSelections('gid') + "";
	var temp = fid.split(",");
	for (i = 0; i < temp.length; i++) {
		if (i == 0) {
			fids += tcxz + "." + temp[i];
		} else {
			fids += "," + tcxz + "." + temp[i];
		}
	}
	showHightLight(fids, tcxz);
}
// 地图定位结束

// 添加文字标注开始
function addBiaoZhu() {
	setDeactivate();// 停用控件
	var bztype=$("#imgType").val();//标注类型
	if(bztype=="wb"){
		var markerTitle = $("#markerTitle").val();
		if (markerTitle == "") {
			alert("请输入标注内容！");
			return false;
		}
	}else{
		var imgpath = $("#imgpath").val();
		if (imgpath == "") {
			alert("请选择符号！");
			return false;
		}
	}
	markClick.activate();
}
// 添加文字标注结束

// 选择要标注的图标开始
function xuanzetubiao(type, imgurl) {
	if (type == 'tp') {
		$("#imgpath").val(imgurl.substring(imgurl.indexOf("images")));
		$("#imgType").val('tp');
	} else if(type == 'fh') {
		$("#imgpath").val(imgurl);
		$("#imgType").val('fh');
	}else{
		$("#imgType").val('wb');
	}
}
// 选择要标注的图标结束

// 清除标注开始
function ClearBiaoZhu() {
	clearFeatur("lableLayer");// 清除文字标注层
	clearAllMarks();// 清除图片标注层
}
// 清除标注结束
// 保存屏幕开始
function baocunpingmu() {
	var drawid = $.trim($("#drawid").val());
	var drawName = $.trim($("#drawName").val());
	var note = $("#note").val();
	if (drawName == "") {
		alert("规划名称不能为空！");
		return false;
	}
	var savefeatures = [];
	var drawfeatures = drawLayer.features;
//	if (drawfeatures != null) {
//		for ( var i = 0; i < drawfeatures.length; i++) {
//			savefeatures.push(drawfeatures[i])
//		}
//	}
	var lablefeatures = lableLayer.features;
//	if (lablefeatures != null) {
//		for ( var i = 0; i < lablefeatures.length; i++) {
//			savefeatures.push(lablefeatures[i])
//		}
//	}

	var format = new OpenLayers.Format.GeoJSON(new OpenLayers.Projection(
			"EPSG:2362"));
	var drawjsonstr = format.write(drawfeatures, false);
	var lablejsonstr = format.write(lablefeatures, false);
	var url = "mapController.do?saveDraws";
	$('#drawjsonstr').val(drawjsonstr);
	$('#lablejsonstr').val(lablejsonstr);
	$('#daw').form('submit', {
		type : 'POST',
		url : url,// 请求的action路径
		error : function() {// 请求失败处理函数
			alert("保存失败请重试！");
		},
		success : function(data) {
			var d = $.parseJSON(data);
			if (d.success) {
				$("#draws").val("");
				alert("保存成功！");
				reloaddrawList();
			}
		}
	});
}
// 保存屏幕结束
// 删除屏幕开始
function shanchupingmu() {
	var draws = getdrawListSelections('id') + "";
	if (draws == null || draws == "") {
		alert("请选择规划记录！");
		return false;
	}
	var url = "mapController.do?deleteDraws&drawids=" + draws;
	$.ajax({
		type : 'POST',
		url : url,// 请求的action路径
		error : function() {// 请求失败处理函数
			alert("删除失败请重试！");
		},
		success : function(data) {
			var d = $.parseJSON(data);
			if (d.success) {
				alert("删除成功！");
				reloaddrawList();
			}
		}
	});
}
// 删除屏幕结束
// 编辑屏幕开始
function bianjipingmu() {
	clearFeatur("lableLayer,drawLayer");// 清空层上的要素
	clearAllMarks();// 清除markers
	var draws = getdrawListSelections('id') + "";
	if (draws == null || draws == "") {
		alert("请选择规划记录！");
		return false;
	} else if (draws.split(",").length > 1) {
		alert("只能对一条规划编辑！");
		return false;
	}

	// 获得要编辑的信息
	$.ajax({
		async : false,
		cache : false,
		type : 'POST',
		url : "mapController.do?getpingmu&drawid=" + draws,// 请求的action路径
		error : function() {// 请求失败处理函数
		},
		success : function(data) {
			var d = $.parseJSON(data);
			$('#draws').val(draws);
			$('#drawName').val(d.drawname);
			$('#note').val(d.note);
			var geojson_format = new OpenLayers.Format.GeoJSON(
					new OpenLayers.Projection("EPSG:2362"));
			var drawfeatures = geojson_format.read(d.drawcontent,
					"FeatureCollection");
			for ( var i = 0; i < drawfeatures.length; i++) {
				var feature = drawfeatures[i];
				drawLayer.addFeatures([ feature ]);
			}
			
			var markfeatures = geojson_format.read(d.markercontent,
			"FeatureCollection");
			for ( var i = 0; i < markfeatures.length; i++) {
				var feature = markfeatures[i];
				lableLayer.addFeatures([ feature ]);
			}
		}
	});

}
// 编辑屏幕结束
// 改变编辑的层开始
// this function allows the editable layer to be changed
// for the snapping control, this amounts to calling setLayer
function updateEditable(name) {
	layer = window[name];
	// update the editable layer for the snapping control (nice)
	snap.setLayer(layer);
	// update the editable layer for the modify control (ugly)
	var modActive = editfeature.active;
	if (modActive) {
		editfeature.deactivate();
	}
	editfeature.layer = layer;
	editfeature.selectControl.layer = layer;
	editfeature.selectControl.handlers.feature.layer = layer;
	editfeature.dragControl.layer = layer;
	editfeature.dragControl.handlers.drag.layer = layer;
	editfeature.dragControl.handlers.feature.layer = layer;
	if (modActive) {
		editfeature.activate();
	}

	// update the editable layer for the dragfeature control (very ugly)
	var dragActive = dragfeature.active;
	if (dragActive) {
		dragfeature.deactivate();
	}
	dragfeature.layer = layer;
	dragfeature.handlers.drag.layer = layer;
	dragfeature.handlers.feature.layer = layer;
	if (dragActive) {
		dragfeature.activate();
	}
	// update the editable layer for the deletefeature control (very ugly)

	var delActive = deletefeature.active;
	if (delActive) {
		deletefeature.deactivate();
	}

	deletefeature.layer = layer;
	deletefeature.handler.layer = layer;
	if (delActive) {
		deletefeature.activate();
	}

}
// 改变编辑的层结束

// 编辑开关开始
function editDesign(name) {
	updateEditable(name);
}
// 编辑开关结束

// 暂时未用函数开始
// 地图到项目
function getProjectInfo(value) {
	var flag = window.top.$('#maintabs').tabs('exists', "项目信息");
	if (flag) {
		window.top.$('#maintabs').tabs('close', "项目信息");
	}
	window.top
			.$('#maintabs')
			.tabs(
					'add',
					{
						title : "项目信息",
						content : '<iframe  scrolling="auto" frameborder="0"  src="declareController.do?projectSearchDetial&declareid='
								+ value
								+ '" style="width:100%;height:100%;"></iframe>',
						closable : true,
						icon : 'icon-set'
					});

}
// 定位项目
function dingweiProject(v) {
	findCircle.deactivate();
	findPoint.deactivate();
	findSquare.deactivate();
	findPolygon.deactivate();
	findLine.deactivate();
	drawPoint.deactivate();
	drawPolygon.deactivate();
	drawLine.deactivate();
	measureDistance.deactivate();
	measureArea.deactivate();
	$.messager.progress({
		text : '页面加载中....',
		interval : 100
	});
	$.ajax({
		async : false,
		cache : false,
		type : 'POST',
		url : "mapController.do?getProjectDetail&declareid=" + v,// 请求的action路径
		error : function() {// 请求失败处理函数
		},
		success : function(data) {
			var d = $.parseJSON(data);
			projectDetail(d);
		}
	});
}

function projectDetail(d) {
	// 清除buffer层上的浮云
	clearAllFeaturPopups("bufferLayer");
	// 清除图层的要素
	clearFeatur("selectLayer,bufferLayer,hightLayer,drawLayer");
	// 清除markers
	clearAllMarks();
	// 设置消息栏为空
	document.getElementById('message').innerHTML = "";
	bufferLayer.removeAllFeatures();
	for ( var i = 0; i < d.length; i++) {
		var detialid = d[i].detialid;// 明细编号
		var declareid = d[i].declareid;// 申报编号
		var constructionunit = d[i].constructionunit;// 建设单位
		var projectname = d[i].projectname;// 项目名称
		var statusid = d[i].statusid;// 状态
		var buildingno = d[i].buildingno;// 栋号
		var undergroundconstructionarea = d[i].undergroundconstructionarea;// 地下建筑面积
		if (d[i].geom != null && d[i].geom != "") {
			var temp = d[i].geom;
			var geojson_format = new OpenLayers.Format.GeoJSON();
			var plg = geojson_format.read(temp, "Geometry");
			var feature = geojson_format.read(temp);
			bufferLayer.addFeatures([ feature ]);
			// 定位中心位置经度
			var lon = plg.getBounds().getCenterLonLat().lon;
			// 定位中心位置纬度
			var lat = plg.getBounds().getCenterLonLat().lat;
			// 获得当前缩放级别
			var level = 8;// map.getZoom();
			// 重新定位
			// map.setCenter(new OpenLayers.LonLat(lon, lat), level);
			var lonlat = new OpenLayers.LonLat(lon, lat);
			locateMap(lonlat, level);
			// 弹出信息
			var result = "<table id=\"tt\"  style=\"width:auto;height:auto;\"> "
					+ "<thead> ";
			result += "<tr> <td><b>项目名称:</b>" + projectname + "</td></tr>";
			result += "<tr> <td><b>建设单位:</b>" + constructionunit + "</td></tr>";
			result += "<tr> <td><b>栋号:</b>" + buildingno + "</td></tr>";
			result += "<tr> <td><b>地下建筑面积(㎡):</b>"
					+ undergroundconstructionarea + "</td></tr>";
			result += "<tr> <td><b>状态:</b>" + statusid + "</td></tr>";
			result += "<tr> <td align='center'><a href='#' onclick='getProjectInfo("
					+ declareid + ")'>查看详细</a></td> </tr>";
			result += "</thead> ";
			result += "</table>";
			var popup = new OpenLayers.Popup.FramedCloud("chicken", plg
					.getBounds().getCenterLonLat(), null, result, null, true);
			feature.popup = popup;
			map.addPopup(popup);
		}
	}
	$.messager.progress('close');
	// 若地图上还没有画该图形，则让用户画出
	drawProject(d);
}
// 绘制地下室
function drawProject(d) {
	for ( var i = 0; i < d.length; i++) {
		if (d[i].geom == null || d[i].geom == "") {
			// 开始画图
			jsondata = d;
			drawPolygon.activate();
			return;
		}
	}
}

// 更新项目详细信息
function saveProject(value, geomstr) {
	$.ajax({
		type : 'POST',
		url : "mapController.do?saveProjectGeom&geomstr=" + geomstr
				+ "&detailid=" + value,// 请求的action路径
		error : function() {// 请求失败处理函数
			alert("保存失败请重试！");
		},
		success : function(data) {
			alert("保存成功！");
			clearAllFeaturPopups("drawLayer");
			drawPolygon.deactivate();// 保存成功取消绘画
		}
	});
}

// 弹出保存项目明细
function addFeaturePopup(feature) {
	var format = new OpenLayers.Format.WKT(new OpenLayers.Projection(
			"EPSG:2362"));
	var str = format.write(feature, false);
	if (jsondata != null) {
		for ( var i = 0; i < jsondata.length; i++) {
			var detialid = jsondata[i].detialid;// 明细编号
			var declareid = jsondata[i].declareid;// 申报编号
			var constructionunit = jsondata[i].constructionunit;// 建设单位
			var projectname = jsondata[i].projectname;// 项目名称
			var buildingno = jsondata[i].buildingno;// 栋号
			var statusid = jsondata[i].statusid;// 状态
			var undergroundconstructionarea = jsondata[i].undergroundconstructionarea;// 地下建筑面积
			if (jsondata[i].geom == null || jsondata[i].geom == "") {
				// 弹出信息
				var result = "<table id=\"tt\"  style=\"width:auto;height:auto;\"> "
						+ "<thead> ";
				result += "<tr> <td><b>项目名称:</b>" + projectname + "</td></tr>";
				result += "<tr> <td><b>建设单位:</b>" + constructionunit
						+ "</td></tr>";
				result += "<tr> <td><b>栋号:</b>" + buildingno + "</td></tr>";
				result += "<tr> <td><b>地下建筑面积(㎡):</b>"
						+ undergroundconstructionarea + "</td></tr>";
				result += "<tr> <td><b>状态:</b>" + statusid + "</td></tr>";
				result += "<tr> <td align='center'><a href='#' onclick='saveProject("
						+ detialid + ",\"" + str + "\");'>保存</a></td> </tr>";
				result += "</thead> ";
				result += "</table>";
				var popup = new OpenLayers.Popup.FramedCloud("chicken",
						feature.geometry.getBounds().getCenterLonLat(), null,
						result, null, true, onPopupClose);
				feature.popup = popup;
				map.addPopup(popup);
			}
		}
	}

}
// 暂时未用函数结束

//区域统计专题图开始
//参数：displayType 显示类型，显示高亮加数字或高亮加饼图，线图等

function quyutjztt(displayType){
	// 清除buffer层上的浮云
	clearAllFeaturPopups("bufferLayer");
	// 清除图层的要素
	clearFeatur("selectLayer,bufferLayer,hightLayer,drawLayer,lableLayer");
	// 清除markers
	clearAllMarks();
	$.messager.progress({
		text : '页面加载中....',
		interval : 100
	});
	//参数：tjtype统计类型 'ztt' 专题图统计，'bt' 饼图，'zzt' 柱状图，'zxt' 折线图；
	//tjqy 统计区域（数据库表），tjdx统计对象（数据库表）
	$.ajax({
		type : 'POST',
		url : "mapController.do?getTjInfo&tjtype=bt&tjqy=m_xingzhengqujie&tjdx=m_gongjiaozhandian",// 请求的action路径
		error : function() {// 请求失败处理函数
		},
		success : function(data) { 
			retstr = $.parseJSON(data);
			
			var tc = "zhengzhou:m_xingzhengqujie";//图层
			var tjsj="";//区域统计数据
			var fids="";
			for ( var i = 0; i < retstr.length; i++) {
				
				if(i==0){
					tjsj+=retstr[i].tjinfo;
					fids+="m_xingzhengqujie."+retstr[i].fid+"";
				}else{
					tjsj+=","+retstr[i].tjinfo;
					fids+=",m_xingzhengqujie."+retstr[i].fid+"";
				}
			}
			tjsj=tjsj.split(",");
			fids=fids.split(",");
			// 获得区域信息
			var my_filter = new OpenLayers.Filter.FeatureId({
				fids : fids
			});
			var xmlPara = getXmlPara(tc, my_filter);
			var url = "http://" + mapServerIP + ":" + mapServerPort + "/geoserver/wfs?"
			var request = OpenLayers.Request.POST({
				url : url,
				data : xmlPara,
				callback : function(req) {	
					var colors = ["#FAEBD7","#F0F8FF",  "#F0FFFF", "#F8F8FF", "#FFFFF0", "#FDF5E6"];
					var gmlParse = new OpenLayers.Format.GML();
					var features = gmlParse.read(req.responseText);
					var feature;
					for ( var feat in features) {
						feature = features[feat];
						var tjvalue="";
						for(var j=0;j<fids.length;j++){
							if(feature.fid==fids[j]){
								tjvalue=tjsj[j];
							}
						}
						var lonlat=feature.geometry.getBounds().getCenterLonLat();
						if(displayType=='ztt'){
							setStyles(feature,colors[feat % colors.length],tjvalue,displayType);
							hightLayer.addFeatures([ feature ]);
						}else{
							//var url="http://192.168.1.120:8088/gongjiao/images/renfang/chart.svg";
							setMarkers(lonlat,tjvalue);
							setStyles(feature,colors[feat % colors.length],"",displayType);
						}
						locateMap(lonlat,2);
					}
				}
			});
		}
		
	});
	$.messager.progress('close');
}

//区域统计专题图结束
//设置统计专题图属性开始
function setStyles(feature,color,tjsl,displayType){
	if(displayType=='ztt'){
		feature.style={
				fillColor:color,
				fillOpacity: 0.4,
				strokeWidth : 0.1,
				strokeOpacity : 0.5,
				//strokeColor : "#F0F8FF",
				label : tjsl+"",
				fontColor : "#0000FF",
				fontSize : "12px",
				fontFamily : "Courier New, monospace",
				fontWeight : "bold",
				labelAlign : "lb",
				labelXOffset : "0",
				labelYOffset : "0",
				labelOutlineColor : "white",
				labelOutlineWidth : 0
			};
	}else{
		feature.style={
				fillColor:color,
				fillOpacity: 0.4,
				strokeWidth : 0.1,
				strokeOpacity : 0.5
				//strokeColor : "#F0F8FF",
			};
	}
	
	hightLayer.addFeatures([ feature ]);
}
//设置统计专题图属性结束
//设置统计专题图片开始
function setMarkers(lonlat,url){
	
	// 定位标签大小
	var size = new OpenLayers.Size(100, 100);
	// 偏移量
	var offset = new OpenLayers.Pixel(-(size.w / 2), -(size.h)/2);
	// 图片地址
	var icon = new OpenLayers.Icon(url,size, offset);
	// 创建marker
	var marker = new OpenLayers.Marker(new OpenLayers.LonLat(lonlat.lon, lonlat.lat), icon);
	markers.addMarker(marker);
}

//设置统计专题图片结束