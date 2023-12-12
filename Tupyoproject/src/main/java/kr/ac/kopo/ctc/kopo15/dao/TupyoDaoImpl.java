package kr.ac.kopo.ctc.kopo15.dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import kr.ac.kopo.ctc.kopo15.domain.TupyoItem;

public class TupyoDaoImpl implements TupyoDao {

	public static void main(String[] args) {		
	}

	@Override
	public List<TupyoItem> selectAll() {

		List<TupyoItem> hubo_arr = new ArrayList();

		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			Connection con = DriverManager.getConnection("jdbc:mysql://192.168.23.64 :33060/kopo15","root","5150");
			Statement stmt = con.createStatement(); 

			ResultSet rset = stmt.executeQuery("select * from newhubo;");  // 등록된 모든 후보 조회
			while(rset.next()) {

				TupyoItem hubo = new TupyoItem();

				hubo.setKiho(rset.getInt(1));
				hubo.setName(rset.getString(2));

				hubo_arr.add(hubo);
			}
			rset.close();
			stmt.close();
			con.close();


		} catch (ClassNotFoundException e) {
			e.printStackTrace();

		} catch (SQLException e) {
			e.printStackTrace();
		}
		return hubo_arr;	//결과값 리스트로 반환 
	}

	@Override
	public int newKiho() {

		int newkiho=1; // 기호 1번 초기화
		TupyoItem kiho_list = new TupyoItem();
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			Connection con = DriverManager.getConnection("jdbc:mysql://192.168.23.64 :33060/kopo15","root","5150");
			Statement stmt = con.createStatement(); 
			ResultSet rset= stmt.executeQuery("select kiho from newhubo;");
			List<Integer> kiho = new ArrayList<Integer>(); // 숫자형 타입의 리스트 생성

			while(rset.next()) {			
				kiho.add(rset.getInt(1));			
			}
			for(int i=0; i<kiho.size(); i++) {

				if(newkiho !=kiho.get(i)) {
					kiho_list.setKiho(newkiho);
					break;
				}
				newkiho++;    
			}		
		} catch (Exception e) {
			e.printStackTrace();
		}		
		return newkiho;
	}



	@Override
	public List<TupyoItem> deleteHuboData(int kiho) {

		List<TupyoItem> del_hubo = new ArrayList();  // 삭제되고 난 후 반환 할 list 생성

		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			Connection con = DriverManager.getConnection("jdbc:mysql://192.168.23.64 :33060/kopo15","root","5150");
			Statement stmt = con.createStatement(); 

			String QueryTxt="";
			QueryTxt = String.format("delete from newhubo where kiho='%s';",kiho);
			stmt.execute(QueryTxt);

			ResultSet rset = stmt.executeQuery("select * from newhubo;");

			while(rset.next()) {
				TupyoItem newhubolist = new TupyoItem ();
				newhubolist.setKiho(rset.getInt(1));  // 삭제 후 기호
				newhubolist.setName(rset.getString(2)); // 이름
				del_hubo.add(newhubolist);
			}
			rset.close();
			stmt.close();
			con.close();

		} catch (ClassNotFoundException e) {

			e.printStackTrace();
		} catch (SQLException e) {

			e.printStackTrace();
		}
		return del_hubo;
	}

	@Override
	public boolean newHubolist(int newkiho, String name) {


		//List<TupyoItem> updatehubolist = new ArrayList();

		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			Connection con = DriverManager.getConnection("jdbc:mysql://192.168.23.64 :33060/kopo15","root","5150");
			Statement stmt = con.createStatement(); 

			String QueryTxt;
			QueryTxt = String.format("insert into newhubo(kiho,name) values('%s','%s');",
					Integer.toString(newkiho),name);			
			stmt.execute(QueryTxt);		
			stmt.close();
			con.close();			
			return true;


		} catch (Exception e) {
			e.printStackTrace();
			return false;
		}
	}

	@Override
	public boolean delHuboData(int kiho) {

		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			Connection con = DriverManager.getConnection("jdbc:mysql://192.168.23.64 :33060/kopo15","root","5150");
			Statement stmt = con.createStatement(); 

			String QueryTxt="";
			stmt.execute("delete from newtupyo where kiho ="+kiho+";");  // 사표 하게되면  이전의 투표는 없어야지 정상(사표처리)
			QueryTxt = String.format("delete from newhubo where kiho='%s';",kiho);

			stmt.execute(QueryTxt);	
			stmt.close();
			con.close();

			return true;

		} catch (Exception e) {
			e.printStackTrace();
			return false;

		}

	}
	@Override
	public int totalVoteCount() {   // 투표 참여자 수 반환

		int totalCnt=0;

		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			Connection con = DriverManager.getConnection("jdbc:mysql://192.168.23.64 :33060/kopo15","root","5150");
			Statement stmt = con.createStatement(); 
			ResultSet rset = stmt.executeQuery("select count(*) from newtupyo;");


			while(rset.next()) {

				totalCnt= rset.getInt(1); //count 조회 한 그 데이터의 값 저장

			}
			rset.close();
			stmt.close();
			con.close();

		} catch (Exception e) {			
			e.printStackTrace();
		}
		return totalCnt;
	}

	@Override
	public List<TupyoItem> voteResultAll() {  // 모든 득표자의 결과를 list로 반환 
		
		List<TupyoItem> allresult= new ArrayList();  // select 내용을 저장할 리스트 생성
			
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			Connection con = DriverManager.getConnection("jdbc:mysql://192.168.23.64 :33060/kopo15","root","5150");
			Statement stmt = con.createStatement(); 
			
			
			//left join으로 후보테이블의 모든 정보는 출력되게 하고 투표 테이블은 후보와 공통되면서 필요한 것만 where의 역할은 on 이 함 
			ResultSet rset = stmt.executeQuery("select a.kiho, a.name,count(b.kiho),"
											+ "(count(b.kiho)/(select count(*)from newtupyo))*100 "
											+ "from newhubo as a left join newtupyo as b "
											+ "on a.kiho=b.kiho group by a.kiho; ");
			
			
			while(rset.next()) {
				TupyoItem tupyoitem = new TupyoItem();
				tupyoitem.setVotekiho(rset.getInt(1));  //기호
				tupyoitem.setName(rset.getString(2));  // 후보자명
				tupyoitem.setVotescount(rset.getInt(3)); //득표수
				tupyoitem.setVotesrate(rset.getDouble(4));// 득표율
				allresult.add(tupyoitem);  // 리스트에 다 저장
			}

			rset.close();
			stmt.close();
			con.close();
			
		} catch (Exception e) {			
			e.printStackTrace();
		}
		return allresult;
	}

	@Override
	public List<TupyoItem> voteResultOne(int votekiho) {
		List<TupyoItem> oneresult = new ArrayList(); // 후보자 별 분석 리스트 반환 (연령별 득표수,득표율)
		
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			Connection con = DriverManager.getConnection("jdbc:mysql://192.168.23.64 :33060/kopo15","root","5150");
			Statement stmt = con.createStatement(); 
			//select agegroup, count(kiho),(count(kiho)/(select count(*) from newtupyo where kiho="4"))*100 from newtupyo where kiho="4" group by agegroup;   
			
			String QueryTxt = String.format("select agegroup,count(kiho), (count(kiho) / (select count(*) from newtupyo where kiho='%s')) * 100 "
												+ "from newtupyo where kiho='%s' group by agegroup order by agegroup;", votekiho, votekiho);// group by 연령으로 해야지 연령 순서대로 적용됨 주의!!!!!
			ResultSet rset =stmt.executeQuery(QueryTxt);
		
			while(rset.next()) {
				TupyoItem voteresult = new TupyoItem();
				voteresult.setAgegroup(rset.getInt(1)); // 특정 후부자를 뽑은 연령대 
				voteresult.setVotescount(rset.getInt(2)); //특정 후보자의 연령대별 득표수 
				voteresult.setVotesrate(rset.getDouble(3)); // 특정 후보자의 연령대별 득표율 
				oneresult.add(voteresult); // 리스트에 순서대로 저장
			}
			rset.close();
			stmt.close();
			con.close();
			
		}catch(Exception e){
		e.getStackTrace();
		}		
		
		return oneresult;
	}

	@Override
	public boolean insertVoteData(int votekiho, int agegroup) {  // 투표 데이터 집어 넣기 

		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			Connection con = DriverManager.getConnection("jdbc:mysql://192.168.23.64 :33060/kopo15","root","5150");
			Statement stmt = con.createStatement(); 
			String QueryTxt;  // 쿼리문 요약작성 

			QueryTxt=String.format("insert into newtupyo(kiho,agegroup)values('%s','%s');",votekiho,agegroup);
			stmt.execute(QueryTxt);
			return true;
		} catch (Exception e) {			
			e.printStackTrace();
			return false;
		}
	}
}


