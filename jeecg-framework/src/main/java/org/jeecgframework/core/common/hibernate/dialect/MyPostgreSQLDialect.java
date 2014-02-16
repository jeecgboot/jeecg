package org.jeecgframework.core.common.hibernate.dialect;

import org.hibernate.dialect.PostgreSQLDialect;

public class MyPostgreSQLDialect extends PostgreSQLDialect {

	
	public boolean useInputStreamToInsertBlob() {
		// TODO Auto-generated method stub
		return true;
	}

}
