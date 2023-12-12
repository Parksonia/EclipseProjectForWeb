package kr.ac.kopo.ctc.kopo15.dao;


import java.sql.SQLException;
import java.util.Date;
import java.util.List;

import kr.ac.kopo.ctc.kopo15.domain.GongjiItem;



public interface GongjiItemDao {


public boolean insertgongjilist();
 
List<GongjiItem>GonjiListAll() ;

List<GongjiItem>GongjiOneView(int id);

public boolean insertNewGongji(String title,String content,int rootid,int relevel,int recnt,int viewcnt); 

public boolean Reinsert(String title,String content,int rootid,int relevel,int recnt);

public boolean deleteGonji(int id,int relevel);


public boolean updateGongji(int id,String title,String content);

public String getDate();

public int totalCount();

//public int viewCnt(int id);


}
