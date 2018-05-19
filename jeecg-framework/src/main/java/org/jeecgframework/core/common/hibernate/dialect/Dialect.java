package org.jeecgframework.core.common.hibernate.dialect;

public class Dialect
{
  public boolean supportsLimit()
  {
    return false;
  }

  public boolean supportsLimitOffset()
  {
    return supportsLimit();
  }

  public String getCountSql(String sql)
  {
    String tmp = "select count(1) amount from (" + sql + ")  a";
    return tmp;
  }

  public String getLimitString(String sql, int offset, int limit)
  {
    return getLimitString(sql, offset, Integer.toString(offset), limit, Integer.toString(limit));
  }

  public String getLimitString(String sql, int offset, String offsetPlaceholder, int limit, String limitPlaceholder)
  {
    throw new UnsupportedOperationException("paged queries not supported");
  }
}