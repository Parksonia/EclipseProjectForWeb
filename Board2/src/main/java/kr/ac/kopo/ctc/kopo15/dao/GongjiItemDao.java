package kr.ac.kopo.ctc.kopo15.dao;

import java.util.List;

import kr.ac.kopo.ctc.kopo15.domain.GongjiItem;

public interface GongjiItemDao {

	boolean insertgongjilist();

	 List<GongjiItem> GonjiListAll();
	 
	 List<GongjiItem> GongjiOneView(int id);

	 boolean deleteGonji(int id);
	 
	 boolean updateGongji(int id, String title,String content);
	 
	 boolean insertNewGongji(String title,String content,int rootid,int relevel,int recnt,int viewcnt);
	 
	 String getDate();
	 
	 int totalCount();

}
