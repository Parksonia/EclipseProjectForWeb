package kr.ac.kopo.ctc.kopo15.domain;

import java.sql.Date;
import java.time.LocalDateTime;

public class GongjiItem {

	private int id;
	private String title;
	private Date date;   // date type
	private String content;			//text(midiumtext로 변경)
	private int rootid;   // 원글번호
	private int relevel;
	private int recnt;    
	private int viewcnt; //조회수
	private int status; // 삭제 상태 업데이트 
	

	
	public int getRootid() {
		return rootid;
	}
	public void setRootid(int rootid) {
		this.rootid = rootid;
	}
	public int getRelevel() {
		return relevel;
	}
	public void setRelevel(int relevel) {
		this.relevel = relevel;
	}
	public int getRecnt() {
		return recnt;
	}
	public void setRecnt(int recnt) {
		this.recnt = recnt;
	}
	public int getViewcnt() {
		return viewcnt;
	}
	public int getStatus() {
		return status;
	}
	public void setStatus(int status) {
		this.status = status;
	}
	public void setViewcnt(int viewcnt) {
		this.viewcnt = viewcnt;
	}
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public Date getDate() {
		return date;
	}
	public void setDate(Date date) {
		this.date = date;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	

}
