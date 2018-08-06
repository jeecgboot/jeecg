package org.jeecgframework.core.util;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.util.Hashtable;
import javax.naming.Context;
import javax.naming.NamingEnumeration;
import javax.naming.NamingException;
import javax.naming.directory.Attribute;
import javax.naming.directory.Attributes;
import javax.naming.directory.BasicAttribute;
import javax.naming.directory.BasicAttributes;
import javax.naming.directory.DirContext;
import javax.naming.directory.InitialDirContext;
import javax.naming.directory.ModificationItem;
import javax.naming.directory.SearchControls;
import javax.naming.directory.SearchResult;

import jodd.io.FileUtil;

public class LdapUtil {

	private static File errorFile = new File("d:\\error.txt");

	private static final String DOMAIN_NAME = "EXAMPLE";
	private static final String DOMAIN_SUFFIX = "COM";

	// 请注意这里并不能直接用EXAMPLE.COM当作LDAP SERVER来取代LDAP_SERVER_IP
	private static final String LDAP_SERVER_IP = "10.10.0.5";
	private static final String LDAP_PORTAL = "389";

	private static final String ROOT = "DC=" + DOMAIN_NAME + ",DC=" + DOMAIN_SUFFIX; // LDAP的根节点的DC
	private static final String LDAP_URL = "ldap://" + LDAP_SERVER_IP + ":" + LDAP_PORTAL + "/";

	/**
	 * 域账号登陆验证
	 * 
	 * @param userName
	 * @param password
	 * @return boolean
	 * @throws Exception
	 */
	public static boolean ldapAuth(final String userName, final String password)
			throws Exception {
		boolean isPass = false;
		String ldapUserName = DOMAIN_NAME + "\\" + userName;

		Hashtable<String, String> environment = new Hashtable<String, String>();
		environment.put(Context.INITIAL_CONTEXT_FACTORY,
				"com.sun.jndi.ldap.LdapCtxFactory");
		environment.put(Context.PROVIDER_URL, LDAP_URL);
		environment.put(Context.REFERRAL, "follow");
		environment.put(Context.SECURITY_PRINCIPAL, ldapUserName);
		environment.put(Context.SECURITY_CREDENTIALS, password);
		DirContext dirContext = null;
		try {
			dirContext = new InitialDirContext(environment);
			isPass = true;
		} catch (NamingException e) {
			e.printStackTrace();
		} finally {
			if (null != dirContext) {
				dirContext.close();
			}
		}
		return isPass;
	}

	/**
	 * 域账号登陆验证
	 * 
	 * @param userName
	 * @param password
	 * @return DirContext
	 * @throws Exception
	 */
	public static DirContext getDirContext(final String userName, final String password) throws Exception {
		DirContext dc = null;
		String ldapUserName = DOMAIN_NAME + "\\" + userName;

		Hashtable<String, String> environment = new Hashtable<String, String>();
		environment.put(Context.INITIAL_CONTEXT_FACTORY,
				"com.sun.jndi.ldap.LdapCtxFactory");
		environment.put(Context.PROVIDER_URL, LDAP_URL);
		environment.put(Context.REFERRAL, "follow");
		environment.put(Context.SECURITY_PRINCIPAL, ldapUserName);
		environment.put(Context.SECURITY_CREDENTIALS, password);
		try {
			dc = new InitialDirContext(environment);
		} catch (NamingException e) {
			e.printStackTrace();
		}
		return dc;
	}

	/**
	 * @param base
	 *            ：根节点(在这里是"dc=example,dc=com")
	 * @param scope
	 *            ：搜索范围,分为"base"(本节点),"one"(单层),""(遍历)
	 * @param filter
	 *            ：指定子节点(格式为"(objectclass=*)",*是指全部，你也可以指定某一特定类型的树节点)
	 */
	public static String getDN(String base, String scope, String filter,
			DirContext dc) {
		String dn = null;
		SearchControls sc = new SearchControls();
		if (scope.equals("base")) {
			sc.setSearchScope(SearchControls.OBJECT_SCOPE);
		} else if (scope.equals("one")) {
			sc.setSearchScope(SearchControls.ONELEVEL_SCOPE);
		} else {
			sc.setSearchScope(SearchControls.SUBTREE_SCOPE);
		}
		NamingEnumeration<?> ne = null;
		try {
			ne = dc.search(base, filter, sc);
			while (ne.hasMore()) {
				//System.out.println();
				SearchResult sr = (SearchResult) ne.next();
				String name = sr.getName();
				if (base != null && !base.equals("")) {
					LogUtil.info("entry: " + name + "," + base);
				} else {
					LogUtil.info("entry: " + name);
				}
				dn = name + "," + base;
				break;
			}
		} catch (Exception nex) {
			System.err.println("Error: " + nex.getMessage());
			nex.printStackTrace();
		}
		return dn;
	}

	/**
	 * 添加
	 */
	public static void add(String newUserName, DirContext dc) {
		try {
			BasicAttributes attrs = new BasicAttributes();
			BasicAttribute objclassSet = new BasicAttribute("objectClass");
			objclassSet.add("sAMAccountName");
			objclassSet.add("employeeID");
			attrs.put(objclassSet);
			attrs.put("ou", newUserName);
			dc.createSubcontext("ou=" + newUserName + "," + ROOT, attrs);
		} catch (Exception e) {
			e.printStackTrace();
			//System.out.println("Exception in add():" + e);
		}
	}

	/**
	 * 删除
	 * 
	 * @param dn
	 */
	public static void delete(String dn, DirContext dc) {
		try {
			dc.destroySubcontext(dn);
		} catch (Exception e) {
			LogUtil.error("Exception in delete():" + e);
		}
	}

	/**
	 * 重命名节点
	 * 
	 * @param oldDN
	 * @param newDN
	 * @return
	 */
	public static boolean renameEntry(String oldDN, String newDN, DirContext dc) {
		try {
			dc.rename(oldDN, newDN);
			return true;
		} catch (NamingException ne) {
			System.err.println("Error: " + ne.getMessage());
			return false;
		}
	}

	/**
	 * 修改
	 * 
	 * @return
	 * @throws IOException
	 */
	public static boolean modifyInformation(String dn, String employeeID,
			DirContext dc, String[] employeeArray) throws IOException {
		try {
			String[] modifyAttr = { "telephoneNumber" };
			// employeeArray.length - 1的目的去除员工编号
			ModificationItem[] modifyItems = new ModificationItem[employeeArray.length - 1];

			for (int i = 0; i < modifyAttr.length; i++) {
				String attrName = modifyAttr[i];
				Attribute attr = new BasicAttribute(attrName,
						employeeArray[i + 1]);
				modifyItems[i] = new ModificationItem(
						DirContext.REPLACE_ATTRIBUTE, attr);
			}

			/* 修改属性 */
			// Attribute attr0 = new BasicAttribute("telephoneNumber",
			// telephoneNumber);
			// modifyItems[0] = new
			// ModificationItem(DirContext.REPLACE_ATTRIBUTE, attr0);

			/* 删除属性 */
			// Attribute attr0 = new BasicAttribute("description","陈轶");
			// modifyItems[0] = new
			// ModificationItem(DirContext.REMOVE_ATTRIBUTE, attr0);

			/* 添加属性 */
			// Attribute attr0 = new BasicAttribute("employeeID", employeeID);
			// modifyItems[0] = new ModificationItem(DirContext.ADD_ATTRIBUTE,
			// attr0);

			/* 修改属性 */
			dc.modifyAttributes(dn, modifyItems);
			return true;
		} catch (NamingException e) {
			e.printStackTrace();
			System.err.println("Error: " + e.getMessage());
			FileUtil.appendString(errorFile, "Error:" + e.getMessage() + "\n");
			return false;
		}
	}

	/**
	 * @param base
	 *            ：根节点(在这里是"dc=example,dc=com")
	 * @param scope
	 *            ：搜索范围,分为"base"(本节点),"one"(单层),""(遍历)
	 * @param filter
	 *            ：指定子节点(格式为"(objectclass=*)",*是指全部，你也可以指定某一特定类型的树节点)
	 */
	public void searchInformation(String base, String scope, String filter,
			DirContext dc) {
		SearchControls sc = new SearchControls();
		if (scope.equals("base")) {
			sc.setSearchScope(SearchControls.OBJECT_SCOPE);
		} else if (scope.equals("one")) {
			sc.setSearchScope(SearchControls.ONELEVEL_SCOPE);
		} else {
			sc.setSearchScope(SearchControls.SUBTREE_SCOPE);
		}
		NamingEnumeration<?> ne = null;
		try {
			ne = dc.search(base, filter, sc);
			// Use the NamingEnumeration object to cycle through
			// the result set.
			while (ne.hasMore()) {
				//System.out.println();
				SearchResult sr = (SearchResult) ne.next();
				String name = sr.getName();
				if (base != null && !base.equals("")) {
					LogUtil.info("entry: " + name + "," + base);
				} else {
					LogUtil.info("entry: " + name);
				}

				Attributes at = sr.getAttributes();
				NamingEnumeration<?> ane = at.getAll();
				while (ane.hasMore()) {
					Attribute attr = (Attribute) ane.next();
					String attrType = attr.getID();
					NamingEnumeration<?> values = attr.getAll();
					// Another NamingEnumeration object, this time
					// to iterate through attribute values.
					while (values.hasMore()) {
						Object oneVal = values.nextElement();
						if (oneVal instanceof String) {
							LogUtil.info(attrType + ": "+ (String) oneVal);
						} else {
							LogUtil.info(attrType + ": "+ new String((byte[]) oneVal));
						}
					}
				}
			}
		} catch (Exception nex) {
			System.err.println("Error: " + nex.getMessage());
			nex.printStackTrace();
		}
	}

	/**
	 * 查询并定制返回属性
	 * 
	 * @throws NamingException
	 */
	public void Ldapbyuserinfo(String userName, DirContext dc) {
		// Create the search controls
		SearchControls searchCtls = new SearchControls();
		// Specify the search scope
		searchCtls.setSearchScope(SearchControls.SUBTREE_SCOPE);
		// specify the LDAP search filter
		String searchFilter = "sAMAccountName=" + userName;
		// Specify the Base for the search 搜索域节点
		String searchBase = ROOT;
		
		int totalResults = 0;
		String returnedAtts[] = { "url", "whenChanged", "employeeID", "name", "userPrincipalName", "physicalDeliveryOfficeName",
				"departmentNumber", "telephoneNumber", "homePhone", "mobile", "department", "sAMAccountName", "whenChanged", "mail" }; // 定制返回属性

		searchCtls.setReturningAttributes(returnedAtts); // 设置返回属性集
		//searchCtls.setReturningAttributes(null); // 不定制属性，将返回所有的属性集

		try {
			NamingEnumeration<?> answer = dc.search(searchBase, searchFilter, searchCtls);
			if (oConvertUtils.isEmpty(answer)) {
				LogUtil.info("answer is null");
			} else {
				LogUtil.info("answer not null");
			}
			while (answer.hasMoreElements()) {
				SearchResult sr = (SearchResult) answer.next();
				//System.out.println("************************************************");
				//System.out.println("getname=" + sr.getName());
				Attributes Attrs = sr.getAttributes();
				if (Attrs != null) {
					try {

						for (NamingEnumeration<?> ne = Attrs.getAll(); ne.hasMore();) {
							Attribute Attr = (Attribute) ne.next();
							//System.out.println("AttributeID="+ Attr.getID().toString());
							// 读取属性值
							for (NamingEnumeration<?> e = Attr.getAll(); e
									.hasMore(); totalResults++) {
								String user = e.next().toString(); // 接受循环遍历读取的userPrincipalName用户属性
								//System.out.println(user);
							}
							
							// System.out.println(" ---------------");
							// 读取属性值
							// Enumeration values = Attr.getAll();
							// if (values != null) { // 迭代
							// while (values.hasMoreElements()) {
							// System.out.println(" 2AttributeValues="
							// + values.nextElement());
							// }
							// }
							// System.out.println(" ---------------");
						}
					} catch (NamingException e) {
						System.err.println("Throw Exception : " + e);
					}
				}
			}
			//System.out.println("Number: " + totalResults);
		} catch (Exception e) {
			e.printStackTrace();
			System.err.println("Throw Exception : " + e);
		}
	}

	/**
	 * 关闭LDAP连接
	 */
	public static void close(DirContext dc) {
		if (dc != null) {
			try {
				dc.close();
			} catch (NamingException e) {
				LogUtil.error("NamingException in close():" + e);
			}
		}
	}

	/**
	 * 主函数用于测试
	 * 
	 * @param args
	 * @throws Exception
	 */
	public static void main(String[] args) throws Exception {

		// get AD Context
		String adAdmin = "OP031793";
		String adAdminPassword = "xxxxx";
		
		DirContext dc = getDirContext(adAdmin, adAdminPassword);

		if (dc == null) {
			//System.out.println("User or password incorrect!");
			return;
		}

		/*
		 * 假设address.txt中存在如下信息,一个是员工号,一个是手机号,当然也可以加其他内容进来 
		 * OP036616,13111111111
		 * OP018479,13122222222 
		 * OP017591,13233333333 
		 * OP032528,13244444444
		 */

		FileInputStream fileInputStream = StreamUtils
				.getFileInputStream("d:\\address.txt");
		String strFile = StreamUtils.InputStreamTOString(fileInputStream);
		String[] lineContextArray = strFile.split("\r\n");

		for (int i = 0; i < lineContextArray.length; i++) {
			if (lineContextArray[i] == null)
				continue;

			String lineContext = lineContextArray[i];
			String[] employeeArray = lineContext.split(",");

			String employeeID = employeeArray[0];
			String dn = getDN(ROOT, "", "sAMAccountName=" + employeeID, dc);

			if (dn == null) {
				FileUtil.appendString(errorFile, "Not find user:" + employeeID
						+ "\n");
				continue;
			}

			modifyInformation(dn, employeeID, dc, employeeArray);
		}
		close(dc);
	}
}
