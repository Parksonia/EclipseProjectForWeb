package kr.ac.kopo.ctc.kopo15.service;

import kr.ac.kopo.ctc.kopo15.dao.GongjiItemDao;
import kr.ac.kopo.ctc.kopo15.dao.GongjiItemImpl;
import kr.ac.kopo.ctc.kopo15.dto.Pagination;

public class GongjiItemServiceImpl implements GongjiItemService {

	private GongjiItemDao gongjiitemdao = new GongjiItemImpl();

	@Override
	   public Pagination getPagination(int page, int countPerPage) {
	      Pagination pagination = new Pagination(); //객체 생성은 최대한 윗부분에서 해야 정보 저장 가능
	      GongjiItemImpl gongjiitemimpl= new GongjiItemImpl();
	      int totalCount = gongjiitemimpl.totalCount(); //총 데이터 개수

	      int endPage = 0; //최종페이지

	      if (totalCount % countPerPage == 0) { //총 데이터의 갯수를 countPerPage 로 나눈 나머지가 0이라면  
	         endPage = totalCount / countPerPage; //마지막 페이지는 전체 카운트를 countPerPage로 나눈값이 된다. 
	      } else {
	         endPage = (totalCount / countPerPage) + 1;  //나머지 출력이 있으면 페이지 +1
	      }
	      
	      //현재페이지 설정
	      if(page < 1) {
	         pagination.setC(1);   //페이지가 1보다 작으면 현재페이지를 1로 지정
	      } else if (endPage < page) {
	         pagination.setC(endPage);   //마지막페이지가 보려는 페이지보다 작을때는 마지막페이지를 현재페이지로 지정
	      } else {
	         pagination.setC(page);   //그외라면 보려는 페이지를 현재페이지로 설정한다.
	      }


	      // << 페이지 설정
	      if(page < 11) {
	         pagination.setPp(-1);   //보려는 페이지가 11보다 작은경우 Pp를 -1로 지정 Pp는 제일처음으로간다
	      } else {
	         pagination.setPp(1);   //그외라면 Pp를 1로 지정
	      }

	      // < 페이지 설정
	      if (page < 11) {
	         pagination.setP(-1);   //보려는 페이지가 11보다 작은경우 p를 -1로 지정 P는 한페이지 앞으로 간다
	      } else if (endPage < page) { //마지막페이지가 보려는 페이지보다 작은경우 
	         pagination.setP(((endPage - 1) / 10 -1) * 10 + 1); 
	      } else {
	         pagination.setP((((page - 1) / 10) - 1) * 10 + 1); 
	      }

	      //시작페이지 설정
	      if (page < 1) {
	         pagination.setS(1);   // 보려는 페이지가 1보다 작다면 시작페이지를 1로 지정
	      } else if (endPage < page) { //마짐가페이지가 보려는페이지보다 작은경우 
	         pagination.setS(((endPage -1) / 10 * 10) + 1);
	      } else {
	         pagination.setS(((page -1) / 10) * 10 + 1);
	      }

	      //마지막 페이지 설정
	      if(page < 11) {
	         pagination.setE(10); //보려는 페이지가 11보다 작은 경우 마지막 페이지를 10으로 지정 
	      } else if (((page - 1) / 10) >= endPage / 10) {
	         pagination.setE(endPage);            
	      } else {
	         pagination.setE(((page - 1) / 10) * 10 + 10);
	      }

	      //> 페이지 설정
	      if (page < 11) {
	         pagination.setN(11); //보려는 페이지가 11보다 작은경우 > 누르면 11로 간다
	      } else if (page < (endPage / 10 * 10)) {
	         pagination.setN((((page - 1) / 10) + 1) * 10 + 1);
	      } else if ((endPage / 10 * 10) < page) {
	         pagination.setN(-1);
	      }


	      // >> 페이지 설정 
	      if((endPage / 10 * 10) < page) { 
	         pagination.setNn(-1);   
	      } else {
	         pagination.setNn(endPage * countPerPage);
	      } 

//			int current=page;
//			int tenpage=10;
//			int s_page=0;
//			int e_page=0;
//			int finalendpage =0;
//			int pp=1; //처음으로 돌아가기
//			int p=0;
//			int nn=0;
//			int n=0;
//
//
//			//최종페이지 수 구하기
//			if(totalCount%countPerPage==0) {
//				finalendpage=(totalCount/countPerPage);
//			}else if(totalCount%countPerPage!=0) {
//				finalendpage=(totalCount/countPerPage)+1;
//			}
//
//			//현재페이지 
//			if (current<1) { 
//				current=1;
//			}else if (page > finalendpage) {
//				current= finalendpage;
//			}
//
//			//startpage		
//			if(page<=finalendpage && page%10==0) {  // 나누어 떨어지는 경우에 대한 조건 주의하자!!!!
//				s_page=((current-1)/10*10)+1;  // 20의 경우 19로 만들어주어 /10=> 앞자리수*10+1해주면 됨 
//
//			}else if(page<=finalendpage && page%10!=0){
//				s_page=((current/10)*10)+1;					
//			}	
//			else if(page>finalendpage && page%10==0) {
//				s_page=((finalendpage-1)/10*10)+1;		
//			}
//			else if(page>finalendpage && page%10!=0) {
//				s_page=((finalendpage/10)*10)+1;
//			}
//			
//			//endpage				
//
//			if (page>=finalendpage) {
//				e_page=finalendpage;
//			}else if(page<finalendpage) {
//				if((s_page+tenpage)-1 > finalendpage){
//					e_page=finalendpage;
//				}else {
//					e_page=(s_page+tenpage)-1;	
//				}			
//			}
//
//			//pp (맨 처음의 첫번째 페이지)
//			if (page<tenpage) {
//				pp=-1;
//			}
//
//			//p (이전tenpage의 startpage로 돌아가기)
//			if (page<11) {
//				p=-1;
//			}else  {
//				p=s_page-10;
//			}
//
//			//nn 맨 마지막페이지의 첫번째 페이지
//			if(s_page+tenpage<finalendpage) {
//				if(finalendpage%tenpage!=0) {
//					nn=((finalendpage/tenpage)*10)+1; // 나누기 10의 의미= 1의자리를 제외한 앞자리 숫자 (그러나finalend가 10으로 나누어 떨어지는 경우 생각해야함) 
//				}else {
//					nn=finalendpage-tenpage+1;
//				}
//			}else {
//				nn=-1;
//			}
//			//n(다음tenpage의 startpage=s+tenpage)
//			if(s_page+tenpage<finalendpage) {
//				n=s_page+tenpage;
//			}else {
//				n=-1;
//			}
//
//			pagination.setC(current);  //현재페이지
//			pagination.setS(s_page);   //페이지 블록 시작번호
//			pagination.setE(e_page);   //페이지 블록 끝번호
//			pagination.setPp(pp);	  //맨앞이동 기호
//			pagination.setP(p);		  //이전 페이지 이동 기호
//			pagination.setN(n);			// 다음 페이지 이동 기호
//			pagination.setNn(nn);		//맨 끝 페이지 이동 기호 

	      

	      return pagination; //객체 값 반환
	   }


	@Override
	public kr.ac.kopo.ctc.kopo15.dao.GongjiItemDao getStudentItemDao() {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public void GongjiItemDao(kr.ac.kopo.ctc.kopo15.dao.GongjiItemDao gongjiitemdao) {
		// TODO Auto-generated method stub
	}	
	
}
