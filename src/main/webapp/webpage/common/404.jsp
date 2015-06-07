<%@ page contentType="text/html; charset=UTF-8"%>
<style>
    .code {
        border: 1px solid #ccc;
        background: #efefef;
        font-size: 16px;
    }
    .propNS {
        color: #660E7A
    }
    .propTag {
        color: #000080
    }
    .propName {
        color: #0000ff;
    }
    .propValue{
        color: #008000
    }
</style>
<div style="height: 100%; margin: 14px 20px 0 20px; overflow-y: auto">
    <div style="background: pink; margin-right: 50px; padding: 10px; text-align: center;">
        <div>404 error!请求地址有误！ </div>
        <div>请参照下面的步骤检查你的项目。</div>
    </div>

    <div><h5>代码生成前，配置相关文件</h5></div>
    <div style="margin-right: 50px;">
        <ul>
            <li>生成代码包的路径(jeecg_config.properties)：
                <pre class="code">

  <span class="propTag">bussi_package</span>=<span class="propValue">com.buss</span> // 生成代码的包前缀
                </pre>
            </li>
            <li>代码生成界面的配置：
                <ol>
                    <li>表名：<span class="propValue">guoming_test</span>；</li>
                    <li>包名：<span class="propValue">guoming</span>；</li>
                    <li>代码分层风格：<span class="propValue">代码分层</span>；</li>
                </ol>
            </li>
        </ul>
    </div>

    <div><h5>代码生成后，编辑配置文件</h5></div>
    <div style="margin-right: 50px;">
        <ul>
            <li>
                加载Controller(spring-mvc.xml)
                <pre class="code">

  &lt;<span class="propNS">context</span><span class="propTag">:component-scan</span> <span class="propName">base-package=</span><span class="propValue">"com.buss.*"</span>&gt;
      &lt;<span class="propNS">context</span><span class="propTag">:exclude-filter</span> <span class="propName">type=</span><span class="propValue">"annotation" expression="org.springframework.stereotype.Service"</span> /&gt;
  &lt;/<span class="propNS">context</span><span class="propTag">:component-scan</span>&gt;
                </pre>
            </li>
            <li>
                加载service(spring-mvc-hibernate.xml)
                        <pre class="code">

  &lt;<span class="propNS">context</span><span class="propTag">:component-scan</span> <span class="propName">base-package=</span><span class="propValue">"com.buss.*"</span>&gt;
      &lt;<span class="propNS">context</span><span class="propTag">:exclude-filter</span> <span class="propName">type=</span><span class="propValue">"annotation" expression="org.springframework.stereotype.Controller"</span> /&gt;
  &lt;/<span class="propNS">context</span><span class="propTag">:component-scan</span>&gt;
                        </pre>
            </li>
            <li>
                扫描hibernate实体(spring-mvc-hibernate.xml)
                <pre class="code">

  如果生成代码时，代码分层风格选择了“代码分层”，则配置文件如下：
  &lt;<span class="propTag">property</span> <span class="propName">name=</span><span class="propValue">"packagesToScan"</span>&gt;
      &lt;<span class="propTag">list</span>&gt;
          ....
          &lt;!-- 扫描 代码分层 实体 --&gt;
          &lt;<span class="propTag">value</span>&gt;com.buss.entity.*&lt;/<span class="propTag">value</span>&gt;
          &lt;!-- 扫描 业务分层 实体 --&gt;
          &lt;<span class="propTag">value</span>&gt;com.buss.*.entity&lt;/<span class="propTag">value</span>&gt;
      &lt;/<span class="propTag">list</span>&gt;
  &lt;/<span class="propTag">property</span>>
                </pre>
            </li>
        </ul>
    </div>

    <h5>代码生成后，编辑菜单地址</h5>
    <ol>
        <li>系统管理-->菜单管理-->录入菜单</li>
        <li>填写地址：<span class="propValue">guomingTestController.do?guomingTest</span></li>
    </ol>

</div>