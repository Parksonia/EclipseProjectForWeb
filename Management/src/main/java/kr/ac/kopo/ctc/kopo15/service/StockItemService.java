package kr.ac.kopo.ctc.kopo15.service;


import java.sql.SQLException;

import kr.ac.kopo.ctc.kopo15.dao.StockItemDao;
import kr.ac.kopo.ctc.kopo15.dto.Pagination;

public interface StockItemService {
	
	StockItemDao getStockitemDao();
	
	void StockItemDao(StockItemDao stockitemdao);
	
	Pagination getPagination(int page, int countPerPage) throws ClassNotFoundException, SQLException;  // 페이지네이션 

	StockItemDao getStockItemDao();
}
