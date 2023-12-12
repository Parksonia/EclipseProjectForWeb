package kr.ac.kopo.ctc.kopo15.dao;

import java.util.List;

import kr.ac.kopo.ctc.kopo15.domain.TupyoItem;

public interface TupyoDao {
	
	List<TupyoItem> selectAll(); // 등록 후보자 전체 출력
	
	List<TupyoItem> deleteHuboData(int kiho);  // 후보자 삭제
	
	int newKiho();    // 기호번호 부여(삭제된것부터)
	
	boolean delHuboData(int kiho);  // 삭제 되면 true 반환
	
	boolean newHubolist(int newkiho,String name);  //후보등록 되면 true 반환
	
	boolean insertVoteData(int votekiho,int agegroup);  // 투표 데이터 들어가면 true 반환
	
	int totalVoteCount();   //투표 참여자 수 반환
	
	List<TupyoItem> voteResultAll();  // 전체 투표 데이터 리스트 반환
	
	List<TupyoItem> voteResultOne(int votekiho);  // 특정 기호의 투표데이터 리스트 반환 

}
