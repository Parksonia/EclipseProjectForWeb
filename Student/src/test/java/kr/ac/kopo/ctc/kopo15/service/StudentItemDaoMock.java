package kr.ac.kopo.ctc.kopo15.service;

import java.util.List;

import kr.ac.kopo.ctc.kopo15.dao.StudentItemDao;
import kr.ac.kopo.ctc.kopo15.domain.StudentItem;

public class StudentItemDaoMock implements StudentItemDao {

	@Override
	public StudentItem create() {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public StudentItem selectOne(int id) {
		StudentItem studentItem = new StudentItem();
		return studentItem;
	}

	@Override
	public List<StudentItem> selectAll(int page, int countPerPage) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public int totalCount() {
		// TODO Auto-generated method stub
		return 0;
	}


}
