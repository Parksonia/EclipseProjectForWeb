package kr.ac.kopo.ctc.kopo15.dao;


import java.net.http.HttpRequest;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.apache.catalina.connector.Request;

import kr.ac.kopo.ctc.kopo15.domain.GongjiItem;

public class GongjiItemImpl implements GongjiItemDao{

	public static void main(String[] args) {

	}

	@Override
	public boolean insertgongjilist() {
		// TODO Auto-generated method stub


		try {
			Class.forName("com.mysql.cj.jdbc.Driver");   
			Connection con = DriverManager.getConnection("jdbc:mysql://192.168.23.64 :33060/kopo15_ex2","root","5150");
			Statement stmt = con.createStatement();	//sql 명령(query)을 실행하기 위한 statement객체 생성

			String Querytxt;
			Querytxt =("insert into gongji2(title,date,content)values('공지사항1',date(now()),'공지사항내용1');"); stmt.execute(Querytxt);
			Querytxt =("insert into gongji2(title,date,content)values('공지사항2',date(now()),'공지사항내용2');"); stmt.execute(Querytxt);
			Querytxt =("insert into gongji2(title,date,content)values('공지사항3',date(now()),'공지사항내용3');"); stmt.execute(Querytxt);	
			Querytxt =("insert into gongji2(title,date,content)values('공지사항4',date(now()),'공지사항내용4');"); stmt.execute(Querytxt);
			Querytxt =("insert into gongji2(title,date,content)values('공지사항5',date(now()),'공지사항내용5');"); stmt.execute(Querytxt);


			/*
			 * create table gongji(id int not null primary key auto_increment,
					title varchar(70),
                    date date,
                    content text)
                    default char set=utf8;
			 * 
			 * */
			
			
			
			stmt.close();
			con.close();

			return true;		
		}catch(Exception e) {

			return false;
		}			
	}

	@Override
	public List<GongjiItem> GonjiListAll()  {
		// TODO Auto-generated method stub
		List<GongjiItem> gongjiarr = new ArrayList<>();  

		try{
		Class.forName("com.mysql.cj.jdbc.Driver");   
		
		Connection con = DriverManager.getConnection("jdbc:mysql://192.168.23.64 :33060/kopo15_ex2","root","5150");
		Statement stmt = con.createStatement();	//sql 명령(query)을 실행하기 위한 statement객체 생성
		
		ResultSet rset = stmt.executeQuery("select * from gongji2;");

		while(rset.next()) {

			GongjiItem gongji = new GongjiItem();

			gongji.setId(rset.getInt(1)); //번호
			gongji.setTitle(rset.getString(2));//제목
			gongji.setDate(rset.getDate(3)); //시간
			//gongji.setContent(rset.getString(4));  내용은 리스트에서 제외 

			gongjiarr.add(gongji);
		}
		
			rset.close();
			stmt.close();
			con.close();
					
		}catch(Exception e) {
			e.getStackTrace();
		}
		return gongjiarr;
	}

	@Override
	public List<GongjiItem> GongjiOneView(int id) {
		
		List<GongjiItem> gonjioneview = new ArrayList();
		
		try {
		Class.forName("com.mysql.cj.jdbc.Driver");
		Connection con = DriverManager.getConnection("jdbc:mysql://192.168.23.64 :33060/kopo15_ex2","root","5150");//DriverManager.getConnection->mysql 데이터 베이스에 연결하기 위한 connection객체생성
		Statement stmt = con.createStatement(); 
		
		String QueryTxt =String.format("select * from gongji2 where id='%S';",id);
		ResultSet rset = stmt.executeQuery(QueryTxt);
		
		while(rset.next()) {
			GongjiItem gongji = new GongjiItem();
			
			gongji.setId(rset.getInt(1));    // 글번호
			gongji.setTitle(rset.getString(2)); // 제목
			gongji.setDate(rset.getDate(3));    //작성날짜
			gongji.setContent(rset.getString(4));  //내용
	
			//gongji.setViewcnt(rset.getInt(8)); // 조회수 
			
			gonjioneview.add(gongji);	
	
			
		}
		
		rset.close();
		stmt.close();
		con.close();	
		}catch(Exception e) {
			
		}
				
		return gonjioneview;
	}

//	@Override
//	public int viewCnt(int id) {  //조회수 카운트 
//		
//		int viewcnt = 0;
//	
//		return viewcnt;
//	}

	@Override
	public boolean deleteGonji(int id) {
	
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			Connection con = DriverManager.getConnection("jdbc:mysql://192.168.23.64 :33060/kopo15_ex2","root","5150");
			Statement stmt = con.createStatement(); 
			
			String QueryTxt = String.format("delete from gongji2 WHERE id='%s';",id);	//해당 학번 삭제 하고 	
			stmt.execute(QueryTxt);
			//stmt.execute("alter table gongji auto_increment=1;");
			//stmt.execute("SET @COUNT = 0;");
			//stmt.execute("UPDATE gongji SET id = @COUNT:=@COUNT+1;"); // id 번호 재정렬 , 재정렬 하면 신규 추가시 빠진 번호 부터 들어감..?
			
			stmt.close();
			con.close();
			
			return true;
		}catch(Exception e){
			
			return false;
		
	
		}
	}

	@Override
	public boolean updateGongji(int id, String title,String content) {


		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			Connection con = DriverManager.getConnection("jdbc:mysql://192.168.23.64 :33060/kopo15_ex2","root","5150");//DriverManager.getConnection->mysql 데이터 베이스에 연결하기 위한 connection객체생성
			Statement stmt = con.createStatement();  
			String QueryTxt;
			QueryTxt = String.format("update gongji2 set id='%s', title='%s', date=date(now()), content='%s'  WHERE id='%s';"
					,id,title,content,id);	

			stmt.execute(QueryTxt);		
			stmt.close();
			con.close();
			
			return true;

		}catch(Exception e) {

			return false;
		}
	}

	@Override
	public boolean insertNewGongji(String title,String content,int rootid,int relevel,int recnt,int viewcnt) {  // 새로 작성되는 글 업로드 완료 되면 true 반환 


		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			Connection con = DriverManager.getConnection("jdbc:mysql://192.168.23.64 :33060/kopo15_ex2","root","5150");//DriverManager.getConnection->mysql 데이터 베이스에 연결하기 위한 connection객체생성
			Statement stmt = con.createStatement();  

			String QueryTxt = String.format("insert into gongji2 (title,date,content)values('%s',date(now()),'%s');",title,content);
			stmt.execute(QueryTxt);
			//ResultSet rset = stmt.executeQuery("select * from gongji;");

			stmt.close();
			con.close();
			
			return true;

			

		}catch(Exception e) {

			return false;

		}
	}
	@Override
	public String getDate() {

		Date day = new Date();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		String today = sdf.format(day);

		//java.sql.Date d = java.sql.Date.valueOf(today);

		return today;
	}
	@Override
	public int totalCount() {
	
		int totalCnt=0;
		
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			Connection con = DriverManager.getConnection("jdbc:mysql://192.168.23.64 :33060/kopo15_ex2","root","5150");//DriverManager.getConnection->mysql 데이터 베이스에 연결하기 위한 connection객체생성
			Statement stmt = con.createStatement();  

			ResultSet rset =stmt.executeQuery("select count(*) from gongji2;");
			while(rset.next()) {
				totalCnt =rset.getInt(1);
			}
			
			rset.close();
			stmt.close();
			con.close();
			
		}catch(Exception e) {
						
		}
		return totalCnt ;
	}

}
