package kr.ac.kopo.ctc.kopo15.domain;

public class TupyoItem {

	private int kiho;
	private String name;    //hubotable

	private int votekiho;
	private int agegroup;  //tupyotable
	
	
	private double votesrate;  // 득표율
	private int votescount;  //득표수
	

	
	public int getVotekiho() {
		return votekiho;
	}
	public void setVotekiho(int votekiho) {
		this.votekiho = votekiho;
	}
	public int getAgegroup() {
		return agegroup;
	}
	public void setAgegroup(int agegroup) {
		this.agegroup = agegroup;
	}
	public double getVotesrate() {
		return votesrate;
	}
	public void setVotesrate(double votesrate) {
		this.votesrate = votesrate;
	}
	public int getVotescount() {
		return votescount;
	}
	public void setVotescount(int votescount) {
		this.votescount = votescount;
	}
	public int getKiho() {
		return kiho;
	}
	public void setKiho(int kiho) {
		this.kiho = kiho;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	
}
