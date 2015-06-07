package org.jeecgframework.web.demo.service.test;

import org.jeecgframework.web.demo.entity.test.CourseEntity;

import org.jeecgframework.core.common.service.CommonService;

public interface CourseServiceI extends CommonService{

	/**
	 * 保存课程
	 *@Author JueYue
	 *@date   2013-11-10
	 *@param  course
	 */
	void saveCourse(CourseEntity course);
	/**
	 * 更新课程
	 *@Author JueYue
	 *@date   2013-11-10
	 *@param  course
	 */
	void updateCourse(CourseEntity course);

}
