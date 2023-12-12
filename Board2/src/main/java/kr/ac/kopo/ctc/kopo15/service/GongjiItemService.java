package kr.ac.kopo.ctc.kopo15.service;


import java.sql.SQLException;
import kr.ac.kopo.ctc.kopo15.service.*;
import kr.ac.kopo.ctc.kopo15.dao.GongjiItemDao;
import kr.ac.kopo.ctc.kopo15.dto.Pagination;

public interface GongjiItemService {
	
	GongjiItemDao getStudentItemDao();
	
	void GongjiItemDao(GongjiItemDao gongjiitemdao);
	
	Pagination getPagination(int page, int countPerPage) throws ClassNotFoundException, SQLException;  // 페이지네이션 
}
