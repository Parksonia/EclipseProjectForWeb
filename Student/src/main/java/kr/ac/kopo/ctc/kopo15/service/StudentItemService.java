package kr.ac.kopo.ctc.kopo15.service;


import java.sql.SQLException;

import kr.ac.kopo.ctc.kopo15.dao.StudentItemDao;
import kr.ac.kopo.ctc.kopo15.dto.Pagination;

public interface StudentItemService {
	
	StudentItemDao getStudentItemDao();
	
	void setStudentItemDao(StudentItemDao studentItemDao);
	
	Pagination getPagination(int page, int countPerPage) throws ClassNotFoundException, SQLException;  // 페이지네이션 
}
