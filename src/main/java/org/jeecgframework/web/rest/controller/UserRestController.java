package org.jeecgframework.web.rest.controller;

import java.net.URI;
import java.util.List;
import java.util.Set;

import javax.validation.ConstraintViolation;
import javax.validation.Validator;

import org.jeecgframework.core.beanvalidator.BeanValidators;
import org.jeecgframework.web.system.pojo.base.TSBaseUser;
import org.jeecgframework.web.system.pojo.base.TSUser;
import org.jeecgframework.web.system.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.ResponseStatus;
import org.springframework.web.util.UriComponentsBuilder;

import io.swagger.annotations.Api;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiOperation;
import io.swagger.annotations.ApiParam;

/**
 * TSUser的Restful API
 * 
 *  path/ POST    --> 新增 (CREATE)
 *  path/id  GET -->  查询 (READ)
 *  path/id  PUT  -->  更新 (UPDATE)
 *  path/id  DELETE --> 删除 (DELETE)
 * 
 * @author liuht
 */

@Api(value="userRest",description="用户信息管理",tags="UserRestController")

@Controller
@RequestMapping(value = "/user")
public class UserRestController {

	@Autowired
	private UserService userService;

	@Autowired
	private Validator validator;

	/**
	 * 访问地址：http://localhost:8080/jeecg/rest/user
	 * @return
	 */
	@RequestMapping(method = RequestMethod.GET)
	@ResponseBody

	@ApiOperation(value="用户列表信息",produces="application/json",httpMethod="GET")

	public List<TSUser> list() {
		List<TSUser> listUsers=userService.getList(TSUser.class);
		return listUsers;
	}

	/**
	 * 访问地址：http://localhost:8080/jeecg/rest/user/{id}
	 * @param id
	 * @return
	 */
	@RequestMapping(value = "/{id}", method = RequestMethod.GET)
	@ResponseBody

	@ApiOperation(value="根据ID获取用户信息",notes="根据ID获取用户信息",httpMethod="GET",produces="application/json")

	public ResponseEntity<?> get(@ApiParam(required=true,name="id",value="用户ID") @PathVariable("id") String id) {
		TSUser task = userService.get(TSUser.class, id);
		if (task == null) {
			return new ResponseEntity(HttpStatus.NOT_FOUND);
		}
		return new ResponseEntity(task, HttpStatus.OK);
	}

	@RequestMapping(method = RequestMethod.POST, consumes = MediaType.APPLICATION_JSON_VALUE)
	@ResponseBody

	@ApiOperation(value="创建用户信息")
	public ResponseEntity<?> create(@ApiParam(name="用户对象")@RequestBody TSUser user, UriComponentsBuilder uriBuilder) {

		//调用JSR303 Bean Validator进行校验，如果出错返回含400错误码及json格式的错误信息.
		Set<ConstraintViolation<TSUser>> failures = validator.validate(user);
		if (!failures.isEmpty()) {
			return new ResponseEntity(BeanValidators.extractPropertyAndMessage(failures), HttpStatus.BAD_REQUEST);
		}

		//保存用户
		userService.save(user);

		//按照Restful风格约定，创建指向新任务的url, 也可以直接返回id或对象.
		String id = user.getId();
		URI uri = uriBuilder.path("/rest/user/" + id).build().toUri();
		HttpHeaders headers = new HttpHeaders();
		headers.setLocation(uri);

		return new ResponseEntity(headers, HttpStatus.CREATED);
	}

	@RequestMapping(value = "/{id}", method = RequestMethod.PUT, consumes = MediaType.APPLICATION_JSON_VALUE)
	@ResponseBody

	@ApiOperation(value="更新用户信息",notes="更新用户数据信息")
	public ResponseEntity<?> update(@ApiParam(name="用户",value="传入对应的JSON")@RequestBody TSUser user) {

		//调用JSR303 Bean Validator进行校验，如果出错返回含400错误码及json格式的错误信息.
		Set<ConstraintViolation<TSUser>> failures = validator.validate(user);
		if (!failures.isEmpty()) {
			return new ResponseEntity(BeanValidators.extractPropertyAndMessage(failures), HttpStatus.BAD_REQUEST);
		}

		//保存
		userService.saveOrUpdate(user);

		//按Restful约定，返回204状态码, 无内容. 也可以返回200状态码.
		return new ResponseEntity(HttpStatus.NO_CONTENT);
	}

	@RequestMapping(value = "/{id}", method = RequestMethod.DELETE)
	@ResponseStatus(HttpStatus.NO_CONTENT)

	@ApiOperation(value="删除用户信息")

	public void delete(@ApiParam(name="id",value="用户ID",required=true)@PathVariable("id") String id) {
		userService.deleteEntityById(TSUser.class, id);
	}
}
