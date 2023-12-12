package kr.ac.kopo.ctc.kopo15.dao;

import java.sql.SQLException;
import java.util.List;

import kr.ac.kopo.ctc.kopo15.domain.StudentItem;

public interface StudentItemDao {
	// CRUD
	
	StudentItem create();  // table 생성
	
	StudentItem selectOne(int id);  // 학번 조회
	
	int countOfVisitor();  //방문자 수 
	
	public int newstudentid (String name, int kor, int eng, int mat) throws ClassNotFoundException, SQLException;  //새로운 학생 등록
	
	List<StudentItem>updateData(int studentid,String name,int kor,int eng,int mat) throws ClassNotFoundException, SQLException;  //학생 정보 수정
	
	List<StudentItem>deleteData(int studentid); // 학생 정보 삭제
	
	//List<StudentItem> selectAll(int page, int countPerPage);

	List<StudentItem> selectAll();   //전체 학생 조회
	
	int totalCount();   // 총 학생 수 
	
	boolean insertTable();  // db insert
	
	boolean dropTable();   // db table drop
	
	boolean createTable();  //db table create
	
	int scoreRank(int studentid);   //등수구하기
	
	
	
//	update
	
	
//	delete
}
