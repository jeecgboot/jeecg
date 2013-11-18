package jeecg.rest.utils;

import java.io.IOException;
import java.lang.reflect.Field;
import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.logging.Logger;

import net.sf.json.JSONArray;

import org.restlet.data.MediaType;
import org.restlet.ext.xml.DomRepresentation;
import org.restlet.representation.Representation;
import org.w3c.dom.Element;
/**
 * @Title: utils
 * @Description: 通用类包含转换json、xml
 * @author yankang
 * @date 2013-09-26 22:27:30
 * @version V1.0
 */
public class Utils {
	private Logger logger = Logger.getLogger("utils");

	/**
	 * 将list中的数据转换成json格式。
	 * 
	 * @param ListObj
	 * @param clazz
	 * @return
	 */
	@SuppressWarnings( { "unchecked", "unchecked" })
	public static StringBuffer toJson(java.util.List<Object> ListObj,
			Class clazz, Map<String, String> excludeProperty) {
		StringBuffer sb = new StringBuffer();
		List list = new ArrayList();
		for (int i = 0; i < ListObj.size(); i++) {
			Map<Object, Object> resultObject = new HashMap<Object, Object>();
			Object obj = ListObj.get(i);
			Iterator iterator = getFilds(clazz).keySet().iterator();
			while (iterator.hasNext()) {
				String property = String.valueOf(iterator.next());
				Class ownerClass = obj.getClass();
				String methodName = "get"
						+ property.substring(0, 1).toUpperCase()
						+ property.substring(1);
				Method method;
				try {
					if (excludeProperty.get(property) == null) {
						method = ownerClass.getMethod(methodName, null);
						resultObject.put(property, method.invoke(obj, null));
					}

				} catch (SecurityException e) {
					e.printStackTrace();
				} catch (NoSuchMethodException e) {
					e.printStackTrace();
				} catch (IllegalArgumentException e) {
					e.printStackTrace();
				} catch (IllegalAccessException e) {
					e.printStackTrace();
				} catch (InvocationTargetException e) {
					e.printStackTrace();
				}

			}

			list.add(resultObject);

		}
		sb.append(JSONArray.fromObject(list));
		return sb;

	}
	/**
	 * 将单个对象中的数据转换成json格式。
	 * 
	 * @param ListObj
	 * @param clazz
	 * @return
	 */
	@SuppressWarnings( { "unchecked", "unchecked" })
	public static StringBuffer toSingleJson(Object obj, Class clazz,
			Map<String, String> excludeProperty) {
		StringBuffer sb = new StringBuffer("");
		List list = new ArrayList();
		if (obj != null) {
			Map<Object, Object> resultObject = new HashMap<Object, Object>();
			Iterator iterator = getFilds(clazz).keySet().iterator();
			while (iterator.hasNext()) {
				String property = String.valueOf(iterator.next());
				Class ownerClass = obj.getClass();
				String methodName = "get"
						+ property.substring(0, 1).toUpperCase()
						+ property.substring(1);
				Method method;
				try {
					if (excludeProperty.get(property) == null) {
						method = ownerClass.getMethod(methodName, null);
						resultObject.put(property, method.invoke(obj, null));
					}
				} catch (SecurityException e) {
					e.printStackTrace();
				} catch (NoSuchMethodException e) {
					e.printStackTrace();
				} catch (IllegalArgumentException e) {
					e.printStackTrace();
				} catch (IllegalAccessException e) {
					e.printStackTrace();
				} catch (InvocationTargetException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
			list.add(resultObject);
			sb.append(JSONArray.fromObject(list));
		}

		return sb;

	}

	/**
	 * 转成xml两种方式
	 * 
	 * @param ListObj
	 * @param clazz
	 * @return
	 */
	// @SuppressWarnings("unchecked")
	// public static String toXml(java.util.List<Object> listObj,
	// Class clazz, Map<String, String> excludeProperty) {
	// StringBuffer sb=new StringBuffer();
	// DomRepresentation representation = null;
	// try {
	// representation = new DomRepresentation(MediaType.TEXT_XML);
	// Document d = DocumentHelper.createDocument();
	// org.dom4j.Element element=d.addElement("children");
	// if (listObj != null && listObj.size() > 0) {
	// for (int j = 0; j < listObj.size(); j++) {
	// Object obj = listObj.get(j);
	// org.dom4j.Element eltItem = element.addElement(clazz.getSimpleName());
	// Iterator iterator = getFilds(clazz).keySet().iterator();
	// while (iterator.hasNext()) {
	// String property = String.valueOf(iterator.next());
	// Class ownerClass = obj.getClass();
	// String methodName = "get"
	// + property.substring(0, 1).toUpperCase()
	// + property.substring(1);
	// Method method;
	// try {
	// method = ownerClass.getMethod(methodName, null);
	// if (excludeProperty.get(property) != null
	// && !excludeProperty.get(property)
	// .equals("")) {
	// } else {
	// org.dom4j.Element eltName = eltItem.addElement(property);
	// Object objResult = method.invoke(obj, null);
	// // eltName.appendChild(d.createTextNode(objResult
	// // + ""));
	// eltName.setText(objResult+"");
	// //eltItem.appendChild(eltName);
	// }
	//
	// } catch (SecurityException e) {
	// e.printStackTrace();
	// } catch (NoSuchMethodException e) {
	// e.printStackTrace();
	// } catch (IllegalArgumentException e) {
	// // TODO Auto-generated catch block
	// e.printStackTrace();
	// } catch (IllegalAccessException e) {
	// // TODO Auto-generated catch block
	// e.printStackTrace();
	// } catch (InvocationTargetException e) {
	// // TODO Auto-generated catch block
	// e.printStackTrace();
	// }
	//
	// }
	// //d.appendChild(eltItem);
	//
	// }
	// //d.normalizeDocument();
	// sb.append(d.asXML());
	// System.out.println(sb);
	// }
	// } catch (IOException e) {
	// // TODO Auto-generated catch block
	// e.printStackTrace();
	// }
	// try {
	// sb.append(representation.getText());
	// System.out.println(representation);
	// } catch (IOException e) {
	// // TODO Auto-generated catch block
	// e.printStackTrace();
	// }
	// return sb.toString();
	//
	// }
	public static Representation toXml(List<Object> objList, Class clazz,
			Map<String, String> excludeProperty) {
		DomRepresentation representation = null;
		try {
			representation = new DomRepresentation(MediaType.TEXT_XML);
			org.w3c.dom.Document d = representation.getDocument();
			if (objList != null) {
				Element parent = d.createElement("children");
				for (int j = 0; j < objList.size(); j++) {
					Element eltItem = d.createElement(clazz.getSimpleName());
					Iterator iterator = getFilds(clazz).keySet().iterator();
					Object obj = objList.get(j);
					while (iterator.hasNext()) {
						String property = String.valueOf(iterator.next());
						Class ownerClass = obj.getClass();
						String methodName = "get"
								+ property.substring(0, 1).toUpperCase()
								+ property.substring(1);
						Method method;
						try {
							method = ownerClass.getMethod(methodName, null);
							if (excludeProperty.get(property) != null
									&& !excludeProperty.get(property)
											.equals("")) {
							} else {
								Element eltName = d.createElement(property);
								Object objResult = method.invoke(obj, null);
								eltName.appendChild(d.createTextNode(objResult
										+ ""));
								eltItem.appendChild(eltName);
							}
						} catch (SecurityException e) {
							e.printStackTrace();
						} catch (NoSuchMethodException e) {
							e.printStackTrace();
						} catch (IllegalArgumentException e) {
							e.printStackTrace();
						} catch (IllegalAccessException e) {
							e.printStackTrace();
						} catch (InvocationTargetException e) {
							e.printStackTrace();
						}
					}
					parent.appendChild(eltItem);
				}
				d.appendChild(parent);
				d.normalizeDocument();
			}
		} catch (IOException e) {
			e.printStackTrace();
		}
		try {
			System.out.println(representation.getText() + "+++");
			System.out.println(representation);
		} catch (IOException e) {
			e.printStackTrace();
		}
		return representation;

	}
	/*
	 * 单个对象转成xml @param ListObj @param clazz @return
	 */
	public static Representation toSingleXml(Object obj, Class clazz,
			Map<String, String> excludeProperty) {
		DomRepresentation representation = null;
		try {
			representation = new DomRepresentation(MediaType.TEXT_XML);
			org.w3c.dom.Document d = representation.getDocument();
			if (obj != null) {
				Element eltItem = d.createElement(clazz.getSimpleName());
				Iterator iterator = getFilds(clazz).keySet().iterator();
				while (iterator.hasNext()) {
					String property = String.valueOf(iterator.next());
					Class ownerClass = obj.getClass();
					String methodName = "get"
							+ property.substring(0, 1).toUpperCase()
							+ property.substring(1);
					Method method;
					try {
						method = ownerClass.getMethod(methodName, null);
						if (excludeProperty.get(property) != null
								&& !excludeProperty.get(property).equals("")) {
						} else {
							Element eltName = d.createElement(property);
							Object objResult = method.invoke(obj, null);
							eltName.appendChild(d
									.createTextNode(objResult + ""));
							eltItem.appendChild(eltName);
						}
					} catch (SecurityException e) {
						e.printStackTrace();
					} catch (NoSuchMethodException e) {
						e.printStackTrace();
					} catch (IllegalArgumentException e) {
						e.printStackTrace();
					} catch (IllegalAccessException e) {
						e.printStackTrace();
					} catch (InvocationTargetException e) {
						e.printStackTrace();
					}

				}
				d.appendChild(eltItem);
				d.normalizeDocument();

			}

		} catch (IOException e) {
			e.printStackTrace();
		}

		return representation;

	}

	/**
	 * 获取类的属性，包括集成第一层父类属性
	 * 
	 * @param clazz
	 * @return
	 */
	public static Map<Object, Object> getFilds(Class clazz) {
		Map<Object, Object> map = new HashMap<Object, Object>();
		for (Field field : clazz.getDeclaredFields()) {
			if (!field.getName().equals("serialVersionUID")) {
				map.put(field.getName(), field.getName());
			}

		}
		if (clazz.getSuperclass() != null) {
			for (Field field : clazz.getSuperclass().getDeclaredFields()) {
				if (!field.getName().equals("serialVersionUID")) {
					map.put(field.getName(), field.getName());
				}

			}
		}
		if (clazz.getSuperclass().getSuperclass() != null) {
			for (Field field : clazz.getSuperclass().getSuperclass()
					.getDeclaredFields()) {
				if (!field.getName().equals("serialVersionUID")) {
					map.put(field.getName(), field.getName());
				}

			}
		}

		return map;
	}
	/**
	 * 返回结果
	 * @return
	 */
	public  static Representation  returnSuccessResult(Boolean result){
		DomRepresentation representation = null;
			try {
				representation = new DomRepresentation(MediaType.TEXT_XML);
				org.w3c.dom.Document d = representation.getDocument();
				Element eltItem = d.createElement("success");
				eltItem.setTextContent(result+"");
				d.appendChild(eltItem);
				d.normalizeDocument();
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			
			return representation;
	}
	
	public static void main(String[] args) {
		
			try {
				System.out.println(returnSuccessResult(false).getText());
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		
	}

	

}
