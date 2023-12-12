package kr.ac.kopo.ctc.kopo15.dao;


import java.io.FileNotFoundException;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import kr.ac.kopo.ctc.kopo15.domain.StudentItem;

public class StudentItemDaoImpl implements StudentItemDao {

	public static void main(String[] args) {

	}



	//	@Override
	public StudentItem create() {
		// TODO Auto-generated method stub

		return null;
	}

	@Override
	public StudentItem selectOne(int id) {  // selectAll.jsp에서 id를 get으로 받아 함수 호출 시 매개변수로 보냄 
		StudentItem stu_item = new StudentItem();  // 객체생성 class 사용하기 위해 		

		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			Connection con = DriverManager.getConnection("jdbc:mysql://192.168.23.64 :33060/kopo15","root","5150");//DriverManager.getConnection->mysql 데이터 베이스에 연결하기 위한 connection객체생성
			Statement stmt = con.createStatement(); 

			String QueryTxt = String.format("select * from studenttable where studentid="+id+";"); // 매개변수로받은 특정학새의 정보를 rset으로 저장하고 리스트로 반환함
			ResultSet rset = stmt.executeQuery(QueryTxt);
			while(rset.next()){
				stu_item.setId(rset.getInt(1));   // 인덱스 번호 주의해라!!!!
				stu_item.setName(rset.getString(2));
				stu_item.setKor(rset.getInt(3));
				stu_item.setEng(rset.getInt(4));
				stu_item.setMat(rset.getInt(5));
			}
			rset.close();
			stmt.close();
			con.close();

		}catch(Exception e) {

		}
		return stu_item;
	}
	public int newstudentid (String name, int kor, int eng, int mat) throws ClassNotFoundException, SQLException {

		int newStudentid =209901; //초기값
		StudentItem stu_item = new StudentItem();


			Class.forName("com.mysql.cj.jdbc.Driver");
			Connection con = DriverManager.getConnection("jdbc:mysql://192.168.23.64:33060/kopo15", "root", "5150");//DriverManager.getConnection->mysql 데이터베이스에 연결하기 위한 connection객체생성 
			Statement stmt = con.createStatement();
			String QueryTxt;

			ResultSet rset = stmt.executeQuery("select studentid from studenttable"); //학번중에 가장 큰 학번 불러옴
			List<Integer> studentitem = new ArrayList<Integer>();

			while(rset.next()) {
				studentitem.add(rset.getInt(1)); //id를 리스트에 추가 
			}

			for(int newid :studentitem) {  //리스트에 저장된 값 하나씩 살펴보기
				if(newid !=newStudentid) {   // 하나씩 값이 커질 때 없으면 그 값으로 newStudentid에 저장할 수 있게 함 
					stu_item.setId(newStudentid);
					break;
				}
				newStudentid++;
			}
			QueryTxt = String.format("insert into studenttable(studentid,name,kor,eng,mat) values('%s','%s','%s','%s','%s');",
					Integer.toString(newStudentid), name, kor, eng, mat);
			stmt.execute(QueryTxt);

			rset.close();
			stmt.close();
			con.close();

		return newStudentid;
	}



	@Override
	public int countOfVisitor() {


		int cnt=0;
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			Connection con = DriverManager.getConnection("jdbc:mysql://192.168.23.64 :33060/kopo15","root","5150");
			Statement stmt = con.createStatement();  
			ResultSet rset =stmt.executeQuery("select * from visitor;");   // 방문자 수 를 세기위한 DB테이블(visitor) 생성했음 count 컬럼-value=1

			while(rset.next()) {
				cnt =rset.getInt(1);
				cnt++;
				stmt.execute("update visitor set count ="+cnt+";");  //새로 고침시 방문자 수가 올라가게 됨 
			}
			rset.close();
			stmt.close();
			con.close();

		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return cnt;   // counting 된 수를 반환함
	}

	@Override
	public List<StudentItem> selectAll() {
		// TODO Auto-generated method stub


		List<StudentItem> stu_arr = new ArrayList<>();  // 조회된값을 생성자 setter로 저장하여 그 값을 리스트에 저장함

		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			Connection con = DriverManager.getConnection("jdbc:mysql://192.168.23.64 :33060/kopo15","root","5150");//DriverManager.getConnection->mysql 데이터 베이스에 연결하기 위한 connection객체생성
			Statement stmt = con.createStatement();  

			String QueryTxt;
			QueryTxt =String.format("select * from studenttable;");  // 모든 데이터 조회 
			ResultSet rset =stmt.executeQuery(QueryTxt); // 조회된 결과를 resultset저장

			while(rset.next()) { // select 로 불러온 데이터를 한줄씩 읽어냄
				StudentItem stu_item = new StudentItem();  // 객체 생성을 반복문 안에 넣어야지 매번 새로운 객체 생성되어 set에 새로운 값이 저장 될 수 있다. 

				stu_item.setId(rset.getInt(1));   //학번
				stu_item.setName(rset.getString(2));  //이름
				stu_item.setKor(rset.getInt(3));   //국어
				stu_item.setEng(rset.getInt(4));	//영어
				stu_item.setMat(rset.getInt(5));	//수학				

				stu_arr.add(stu_item);				
			}
			rset.close();
			stmt.close();

		} catch (Exception e) {
			e.getStackTrace();
		}
		return stu_arr;  
	}	



	@Override
	public List<StudentItem> deleteData(int studentid) {

		List<StudentItem>deletestu_arr =new ArrayList<>();

		try {

			Class.forName("com.mysql.cj.jdbc.Driver");
			Connection con = DriverManager.getConnection("jdbc:mysql://192.168.23.64 :33060/kopo15","root","5150");//DriverManager.getConnection->mysql 데이터 베이스에 연결하기 위한 connection객체생성
			Statement stmt = con.createStatement();  

			String QueryTxt;
			QueryTxt = String.format("delete from studenttable WHERE studentid='%s';",studentid);	//해당 학번 삭제 하고 	
			stmt.execute(QueryTxt);
			ResultSet rset =stmt.executeQuery("select * from studenttable;");  // 삭제 된 후 업데이트 까지 완료하기 위해 전체데이터 불러옴

			while(rset.next()) {
				StudentItem stu_item = new StudentItem();

				stu_item.setId(rset.getInt(1)); //업데이트까지 완료된 전체 데이터를 읽어서 list로 저장 할 거임	
				stu_item.setName(rset.getString(2));
				stu_item.setKor(rset.getInt(3));
				stu_item.setEng(rset.getInt(4));
				stu_item.setMat(rset.getInt(5));
				deletestu_arr.add(stu_item);  //list로 저장				
			}
			rset.close();
			stmt.close();
			con.close();

		}catch(Exception e) {

			e.getStackTrace();

		}
		return deletestu_arr;
	}

	public List<StudentItem>updateData(int studentid,String name,int kor,int eng,int mat) throws ClassNotFoundException, SQLException{

		List<StudentItem> updatestu_arr =new ArrayList<>();


			Class.forName("com.mysql.cj.jdbc.Driver");
			Connection con = DriverManager.getConnection("jdbc:mysql://192.168.23.64 :33060/kopo15","root","5150");//DriverManager.getConnection->mysql 데이터 베이스에 연결하기 위한 connection객체생성
			Statement stmt = con.createStatement();  

			String QueryTxt;
			QueryTxt = String.format("UPDATE studenttable SET name='%s', kor='%s', eng='%s', mat='%s'  WHERE studentid='%s';"
					,name,kor,eng,mat,studentid);	

			stmt.execute(QueryTxt);

			ResultSet rset = stmt.executeQuery("select * from studenttable;");
			while(rset.next()) {
				StudentItem stu_item = new StudentItem();  

				stu_item.setId(rset.getInt(1)); //업데이트까지 완료된 전체 데이터를 읽어서 list로 저장 할 거임	
				stu_item.setName(rset.getString(2));
				stu_item.setKor(rset.getInt(3));
				stu_item.setEng(rset.getInt(4));
				stu_item.setMat(rset.getInt(5));
				updatestu_arr.add(stu_item);  //list로 저장				
			}
			rset.close();
			stmt.close();
			con.close();
			
		return updatestu_arr;
	}


	public int totalCount()  {
		// TODO Auto-generated method stub

			int cnt=0;
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");    //-> JDBC 드라이버를 로드하기 위한 코드 (라이브러리에 미리 넣어둠 )  
			Connection con = DriverManager.getConnection("jdbc:mysql://192.168.23.64 :33060/kopo15","root","5150");
		     Statement stmt = con.createStatement();

	         ResultSet rset = stmt.executeQuery("select count(*) as total from studenttable;");
	         if (rset.next()) {
	            cnt = rset.getInt("total");
	         }

	         rset.close();
	         stmt.close();
	         con.close();
	      } catch (ClassNotFoundException e) {

	      } catch (SQLException e) {
	         e.printStackTrace();
	      }
	      return cnt;
	   }
	

	//table 생성하기
	public  boolean createTable() {

		try {

			Class.forName("com.mysql.cj.jdbc.Driver");    //-> JDBC 드라이버를 로드하기 위한 코드 (라이브러리에 미리 넣어둠 )  
			Connection con = DriverManager.getConnection("jdbc:mysql://192.168.23.64 :33060/kopo15","root","5150");
			Statement stmt = con.createStatement();	//sql 명령(query)을 실행하기 위한 statement객체 생성

			stmt.execute("create table studenttable("+    // 테이블생성 및 필드명 지정 
					"studentid int,"+     // studentid primary key 가 됨
					"name  varchar(50),"+   // 이름
					"kor  int,"+  // 국어 점수
					"eng  int,"+  // 영어 점수
					"mat int,"+	//수학 점수	
					"primary key(studentid)"+			
					")DEFAULT CHARSET = utf8;");   

			stmt.close();   //쿼리문 작성 종료
			con.close();   //연결종료
			System.out.println("성공!");
			return true;
		}catch(Exception e) {
			System.out.println("실패!");
			return false;
		}


	}
	//table drop	
	public boolean dropTable() {  //삭제 성공 실패시 true false 반환 


		try {
			Class.forName("com.mysql.cj.jdbc.Driver");    //-> JDBC 드라이버를 로드하기 위한 코드 (라이브러리에 미리 넣어둠 )  
			Connection con = DriverManager.getConnection("jdbc:mysql://192.168.23.64 :33060/kopo15","root","5150");//DriverManager.getConnection->mysql 데이터 베이스에 연결하기 위한 connection객체생성

			Statement stmt = con.createStatement();	//sql 명령(query)을 실행하기 위한 statement객체 생성

			stmt.execute("drop table studenttable ");   // 쿼리 실행문 

			stmt.close(); 
			con.close();

			System.out.println("성공!");
			return true;

		}catch(Exception e) {

			System.out.println("실패!");
			return false;
		}
	}	

	@Override
	public int scoreRank(int studentid) {   // 등수 구하기 

		int rank=1;  //초기화
		try{
		
		Class.forName("com.mysql.cj.jdbc.Driver");//-> JDBC 드라이버를 로드하기 위한 코드 (라이브러리에 미리 넣어둠 )   
		Connection con = DriverManager.getConnection("jdbc:mysql://192.168.23.64 :33060/kopo15","root","5150");//DriverManager.getConnection->mysql 데이터 베이스에 연결하기 위한 connection객체생성
		Statement stmt = con.createStatement();  
			
		ResultSet rset = stmt.executeQuery("select (select count(*) + 1 from studenttable "
				+ "where (a.kor+a.eng+a.mat) < (kor + eng + mat))"
				+ " from studenttable as a where studentid = " + studentid); // 등수 구하기 
		
	
		rset.next();
		rank = rset.getInt(1);

		rset.close();
		stmt.close();
		con.close();
		
		}
		catch(Exception e) {
			e.getStackTrace();	
		}
		return rank ;
	}
	



	public boolean insertTable() {

		try {
			Class.forName("com.mysql.cj.jdbc.Driver");//-> JDBC 드라이버를 로드하기 위한 코드 (라이브러리에 미리 넣어둠 )   
			Connection con = DriverManager.getConnection("jdbc:mysql://192.168.23.64 :33060/kopo15","root","5150");//DriverManager.getConnection->mysql 데이터 베이스에 연결하기 위한 connection객체생성
			Statement stmt = con.createStatement();  

			String QueryTxt;  // 쿼리문 요약작성 

			for(int i=1; i<76; i++) {
				int studentid = 209900+i;
				String name = "name"+String.valueOf(i);
				int kor = (int)(Math.random()*100+1);
				int eng = (int)(Math.random()*100+1);
				int mat = (int)(Math.random()*100+1);

				QueryTxt=String.format("insert into studenttable(studentid,name,kor,eng,mat)values('%s','%s','%s','%s','%s');",studentid,name,kor,eng,mat);
				stmt.execute(QueryTxt);
			}

			//			stmt.execute("insert into studenttable(studentid,name,kor,eng,mat)values(209901,'나연',95,100,95);");
			//			stmt.execute("insert into studenttable(studentid,name,kor,eng,mat)values(209902,'정연',95,95,95);");
			//			stmt.execute("insert into studenttable(studentid,name,kor,eng,mat)values(209903,'모모',100,100,100);");
			//			stmt.execute("insert into studenttable(studentid,name,kor,eng,mat)values(209904,'사나',100,95,90);");
			//			stmt.execute("insert into studenttable(studentid,name,kor,eng,mat)values(209905,'지효',80,100,70);");
			//			stmt.execute("insert into studenttable(studentid,name,kor,eng,mat)values(209906,'미나',95,100,95);");
			//			stmt.execute("insert into studenttable(studentid,name,kor,eng,mat)values(209907,'다현',100,100,70);");
			//			stmt.execute("insert into studenttable(studentid,name,kor,eng,mat)values(209908,'채영',80,75,72);");
			//			stmt.execute("insert into studenttable(studentid,name,kor,eng,mat)values(209909,'쯔위',78,79,82);");
			stmt.close(); 
			con.close();
			System.out.println("성공!");
			return true;
		}catch (Exception e) {
			System.out.println("실패!");
			return false;
		}

	}


}








