package org.jeecgframework.core.common.hibernate.dialect;


public class PostgreSQLDialect extends Dialect
{
  public boolean supportsLimit()
  {
    return true;
  }

  public boolean supportsLimitOffset()
  {
    return true;
  }

  public String getLimitString(String sql, int offset, String offsetPlaceholder, int limit, String limitPlaceholder)
  {
    return new StringBuffer(sql.length() + 20).append(sql).append(" limit " + limitPlaceholder).toString();
  }
}