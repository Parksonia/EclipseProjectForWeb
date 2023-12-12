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
			Querytxt =("insert into gongji(title,date,content)values('공지사항1',date(now()),'공지사항내용1');"); stmt.execute(Querytxt);
			Querytxt =("insert into gongji(title,date,content)values('공지사항2',date(now()),'공지사항내용2');"); stmt.execute(Querytxt);
			Querytxt =("insert into gongji(title,date,content)values('공지사항3',date(now()),'공지사항내용3');"); stmt.execute(Querytxt);	
			Querytxt =("insert into gongji(title,date,content)values('공지사항4',date(now()),'공지사항내용4');"); stmt.execute(Querytxt);
			Querytxt =("insert into gongji(title,date,content)values('공지사항5',date(now()),'공지사항내용5');"); stmt.execute(Querytxt);


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
		
		ResultSet rset = stmt.executeQuery("select * from  gongji order by rootid desc,recnt asc;");
				
		while(rset.next()) {

			
			GongjiItem gongji = new GongjiItem();

			gongji.setId(rset.getInt(1)); //번호
			gongji.setTitle(rset.getString(2));//제목
			gongji.setViewcnt(rset.getInt(8));// 조회수
			gongji.setDate(rset.getDate(3)); //시간
			//gongji.setContent(rset.getString(4));  내용은 리스트에서 제외 
			gongji.setRelevel(rset.getInt(6)); // 들여쓰기 위한 relevel 
			gongji.setStatus(rset.getInt(9)); // 댓글삭제 상태 확인
			
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
		
		stmt.execute("update gongji set viewcnt=viewcnt+1 where id="+id+";");   // 조회 수 업데이트 클릭 시 올라감 
		String QueryTxt =String.format("select * from gongji where id='%S';",id);
		ResultSet rset = stmt.executeQuery(QueryTxt);
		
		while(rset.next()) {
			GongjiItem gongji = new GongjiItem();
			
			gongji.setId(rset.getInt(1));    // 글번호
			gongji.setTitle(rset.getString(2)); // 제목
			gongji.setDate(rset.getDate(3));    //작성날짜
			gongji.setContent(rset.getString(4));  //내용
			gongji.setRootid(rset.getInt(5)); //원글번호
			gongji.setRelevel(rset.getInt(6)); // 그룹내순서
			gongji.setRecnt(rset.getInt(7)); // 들여쓰기
			gongji.setViewcnt(rset.getInt(8)); // 조회수
			
			
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
	public boolean deleteGonji(int id,int relevel) {
	

		
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			Connection con = DriverManager.getConnection("jdbc:mysql://192.168.23.64 :33060/kopo15_ex2","root","5150");
			Statement stmt = con.createStatement(); 
			
			if(relevel==0) { // 원글삭제하는경우
				String QueryTxt = String.format("delete from gongji WHERE rootid='%s';",id);	//해당게시글 삭제 하고 	
				stmt.execute(QueryTxt);
			
			}else {  // 댓글삭제의경우 못읽게 하고싶음 
				String QueryTxt = String.format("update gongji set title='삭제된댓글입니다',status=-1 where id='%s';",id);	//댓글을 삭제하는게 아니라 업데이트로 표시 
				stmt.execute(QueryTxt);	
			}
	
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
			QueryTxt = String.format("update gongji set id='%s', title='%s', date=curdate(), content='%s'  WHERE id='%s';" ,id,title,content,id);	

			stmt.execute(QueryTxt);		
			stmt.close();
			con.close();
			
			return true;

		}catch(Exception e) {

			return false;
		}
	}

	@Override
	public boolean Reinsert(String title,String content,int rootid,int relevel,int recnt) {  // 댓글 추가 
	

		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			Connection con = DriverManager.getConnection("jdbc:mysql://192.168.23.64 :33060/kopo15_ex2","root","5150");//DriverManager.getConnection->mysql 데이터 베이스에 연결하기 위한 connection객체생성
			Statement stmt = con.createStatement();  
	
			String QueryTxt =String.format("update gongji set recnt=recnt+1 where rootid='%s' and recnt > '%s';",rootid,recnt);
			stmt.execute(QueryTxt);
			String QueryTxt2 =String.format("insert into gongji(title,date,content,rootid,relevel,recnt,viewcnt)values('%s',curdate(),'%s','%s','%s','%s',0);",title,content,rootid,(relevel+1),(recnt+1));
			stmt.execute(QueryTxt2);
			
			
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

			
			ResultSet rset = stmt.executeQuery("select * from gongji;");
			
			if(rset.next()) {  //데이터가 있는 경우  id의 가장 큰 수에 +1 rootid로  만들어줌 그래야 자동 생성되는 id와 일치하게 됨
					stmt.execute("SELECT MAX(id)+1 INTO @next_id FROM gongji;");
					String QueryTxt = String.format("insert into gongji(id,title,date,content,rootid,relevel,recnt,viewcnt)values(@next_id,'%s',curdate(),'%s',@next_id,'%s','%s','%s');",title,content,relevel,recnt,viewcnt);
					stmt.execute(QueryTxt);
					
			}else {  // 데이터가 아무것도 없는 경우 // 데이터가 없는경우 rootid =1로 정해줌
			
				String QueryTxt = String.format("insert into gongji(id,title,date,content,rootid,relevel,recnt,viewcnt)values(1,'%s',curdate(),'%s',1,'%s','%s','%s');",title,content,relevel,recnt,viewcnt);
				stmt.execute(QueryTxt);
			}
			
			rset.close();
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

			ResultSet rset =stmt.executeQuery("select count(*) from gongji;");
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
