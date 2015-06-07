package org.jeecgframework.web.demo.service.impl.test;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import org.jeecgframework.web.demo.entity.test.CourseEntity;
import org.jeecgframework.web.demo.entity.test.StudentEntity;
import org.jeecgframework.web.demo.service.test.CourseServiceI;
import org.jeecgframework.core.common.service.impl.CommonServiceImpl;

@Service("courseService")
@Transactional
public class CourseServiceImpl extends CommonServiceImpl implements CourseServiceI {

	
	public void saveCourse(CourseEntity course) {
		this.save(course.getTeacher());
		this.save(course);
		for (StudentEntity s :course.getStudents()){
			s.setCourse(course);
		}
		this.batchSave(course.getStudents());
		
	}

	
	public void updateCourse(CourseEntity course) {
		this.updateEntitie(course);
		this.updateEntitie(course.getTeacher());
		for (StudentEntity s :course.getStudents()){
            s.setCourse(course);
			this.saveOrUpdate(s);
		}
	}
	
}