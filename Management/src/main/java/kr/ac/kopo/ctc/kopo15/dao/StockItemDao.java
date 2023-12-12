package kr.ac.kopo.ctc.kopo15.dao;

import java.util.Date;
import java.util.List;

import kr.ac.kopo.ctc.kopo15.domain.StockItem;

public interface StockItemDao {



	List<StockItem> stocklistAll();
	
	List<StockItem> stocklistOne(String productid);
	
	public boolean insertProduct(String productid,String name,int cnt,String description, String img);

	public boolean deleteProduct(String productid);
	
	public boolean updateStock(String productid,int cnt);
	
	public String getDate();
	
	int totalCount();

}
