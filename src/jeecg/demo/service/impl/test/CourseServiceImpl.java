package jeecg.demo.service.impl.test;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import jeecg.demo.entity.test.CourseEntity;
import jeecg.demo.entity.test.StudentEntity;
import jeecg.demo.service.test.CourseServiceI;
import org.jeecgframework.core.common.service.impl.CommonServiceImpl;

@Service("courseService")
@Transactional
public class CourseServiceImpl extends CommonServiceImpl implements CourseServiceI {

	@Override
	public void saveCourse(CourseEntity course) {
		this.save(course.getTeacher());
		this.save(course);
		for (StudentEntity s :course.getStudents()){
			s.setCourse(course);
		}
		this.batchSave(course.getStudents());
		
	}

	@Override
	public void updateCourse(CourseEntity course) {
		this.updateEntitie(course);
		this.updateEntitie(course.getTeacher());
		for (StudentEntity s :course.getStudents()){
			this.updateEntitie(s);
		}
	}
	
}