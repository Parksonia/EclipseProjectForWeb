package kr.ac.kopo.ctc.kopo15.dao;



import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import kr.ac.kopo.ctc.kopo15.domain.StockItem;

public class StockItemDaoImpl implements StockItemDao {

	public static void main(String[] args) {
		// TODO Auto-generated method stub

	}

	@Override
	public List<StockItem> stocklistAll() {

		List<StockItem> listall = new ArrayList<>();  


		try {
			Class.forName("com.mysql.cj.jdbc.Driver");   
			Connection con = DriverManager.getConnection("jdbc:mysql://192.168.23.64 :33060/kopo15_ex2","root","5150");
			Statement stmt = con.createStatement();	//sql 명령(query)을 실행하기 위한 statement객체 생성

			ResultSet rset =stmt.executeQuery("select * from stock order by inputdate desc;");

			while(rset.next()) {

				StockItem item = new StockItem();
				
				item.setProductId(rset.getString(1)); // 상품번호
				item.setProductName(rset.getString(2)); //상품명
				item.setStockCnt(rset.getInt(3)); // 재고수량
				item.setCheckdate(rset.getDate(4));  //재고파악일
				item.setInputdate(rset.getDate(5));  // 상품등록일 

				listall.add(item);  //리스트에 저장

			}
			rset.close();
			stmt.close();
			con.close();	
		}catch(Exception e) {

			e.getStackTrace();			
		}

		return listall; 
	}

	@Override
	public List<StockItem> stocklistOne(String productid) {
	
		List<StockItem> listone = new ArrayList<>();
		
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");   
			Connection con = DriverManager.getConnection("jdbc:mysql://192.168.23.64 :33060/kopo15_ex2","root","5150");
			Statement stmt = con.createStatement();	
			
			String QueryTxt=String.format("select * from stock where productId='%s'",productid);
			ResultSet rset =stmt.executeQuery(QueryTxt);
			
			while(rset.next()) {
				StockItem item =new StockItem();
				item.setProductId(rset.getString(1)); // 상품번호
				item.setProductName(rset.getString(2)); //상품명
				item.setStockCnt(rset.getInt(3)); // 재고수량
				item.setCheckdate(rset.getDate(4));  //재고파악일
				item.setInputdate(rset.getDate(5));  // 상품등록일 
				item.setDescription(rset.getString(6)); //상품설명
				item.setImg(rset.getString(7)); // 상품이미지 
				
				listone.add(item);
			
			}
			rset.close();
			stmt.close();
			con.close();	
		}catch(Exception e) {
						
		}
			
		return listone;  // 특정상품상세 리스트 반환 
	}

	@Override
	public boolean insertProduct(String productid, String name, int cnt, String description,String img) {  // 신규입력
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");   
			Connection con = DriverManager.getConnection("jdbc:mysql://192.168.23.64 :33060/kopo15_ex2","root","5150");
			Statement stmt = con.createStatement();	
			String QueryTxt = String.format("insert into stock(productId,productName,stockCnt,checkdate,inputdate,description,img)"
					+ "values('%s','%s','%s',date(now()),date(now()),'%s','%s');",productid,name,cnt,description,img);

			stmt.execute(QueryTxt);
			
			stmt.close();
			con.close();
			return true;
		}catch(Exception e) {

			return false;	
		}		
	}

	@Override
	public boolean deleteProduct(String productid) {  //상품 삭제 

		try {
			Class.forName("com.mysql.cj.jdbc.Driver");   
			Connection con = DriverManager.getConnection("jdbc:mysql://192.168.23.64 :33060/kopo15_ex2","root","5150");
			Statement stmt = con.createStatement();
			
			String QueryTxt = String.format("delete from stock where productId='%s';",productid);  //해당 상품번호 data전체삭제 
			stmt.execute(QueryTxt);
			
			stmt.close();
			con.close();
			return true;
		}catch(Exception e) {
			return false;
		}
	}

	@Override
	public boolean updateStock(String productid, int cnt) {
		
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");   
			Connection con = DriverManager.getConnection("jdbc:mysql://192.168.23.64 :33060/kopo15_ex2","root","5150");
			Statement stmt = con.createStatement();
			String today = getDate();
			java.sql.Date currentDate = java.sql.Date.valueOf(today);
			
			String QueryTxt;
			QueryTxt = String.format("update stock set stockCnt='%s',checkdate='%s' where productId='%s';"
										,cnt,currentDate,productid);
			
			stmt.execute(QueryTxt);
			stmt.close();
			con.close();
			return true;
		}catch(Exception e) {
			
			return false;
		}
	}

	@Override
	public String getDate() {  // 당일 날짜 반환 

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

			ResultSet rset =stmt.executeQuery("select count(*) from stock;");
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