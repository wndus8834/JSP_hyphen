package userClass;

public class userClassDTO {
	private String subjYear;
	private String subjSemester;
	private String subjCode;
	private String userID;
	private String subjName;
	private String subjMain;
	private String subjScore;
	private String bigDepartName;
	private String userDepart;
	private String score;
	private String grade;
	
	public String getSubjYear() {
		return subjYear;
	}
	public void setSubjYear(String subjYear) {
		this.subjYear = subjYear;
	}
	public String getSubjSemester() {
		return subjSemester;
	}
	public void setSubjSemester(String subjSemester) {
		this.subjSemester = subjSemester;
	}
	public String getSubjCode() {
		return subjCode;
	}
	public void setSubjCode(String subjCode) {
		this.subjCode = subjCode;
	}
	public String getUserID() {
		return userID;
	}
	public void setUserID(String userID) {
		this.userID = userID;
	}
	public String getSubjName() {
		return subjName;
	}
	public void setSubjName(String subjName) {
		this.subjName = subjName;
	}
	public String getSubjMain() {
		return subjMain;
	}
	public void setSubjMain(String subjMain) {
		this.subjMain = subjMain;
	}
	public String getSubjScore() {
		return subjScore;
	}
	public void setSubjScore(String subjScore) {
		this.subjScore = subjScore;
	}
	public String getBigDepartName() {
		return bigDepartName;
	}
	public void setBigDepartName(String bigDepartName) {
		this.bigDepartName = bigDepartName;
	}
	public String getUserDepart() {
		return userDepart;
	}
	public void setUserDepart(String userDepart) {
		this.userDepart = userDepart;
	}
	public String getScore() {
		return score;
	}
	public void setScore(String score) {
		this.score = score;
	}
	public String getGrade() {
		return grade;
	}
	public void setGrade(String grade) {
		this.grade = grade;
	}
	
	public userClassDTO() {}
	
	public userClassDTO(String subjYear, String subjSemester, String subjCode, String userID, String subjName,
			String subjMain, String subjScore, String bigDepartName, String userDepart, String score, String grade) {
		super();
		this.subjYear = subjYear;
		this.subjSemester = subjSemester;
		this.subjCode = subjCode;
		this.userID = userID;
		this.subjName = subjName;
		this.subjMain = subjMain;
		this.subjScore = subjScore;
		this.bigDepartName = bigDepartName;
		this.userDepart = userDepart;
		this.score = score;
		this.grade = grade;
	}
	
	
}
