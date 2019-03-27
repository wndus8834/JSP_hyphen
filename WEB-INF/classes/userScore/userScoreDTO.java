package userScore;

public class userScoreDTO {
	private String userID;
	private String refinementScore;
	private String culturalReqScore;
	private boolean cultureReqSatisfy;
	private String majorSelectScore;
	private String majorReqScore;
	private boolean majorReqSatisfy;
	private boolean graduPossible;
	public String getUserID() {
		return userID;
	}
	public void setUserID(String userID) {
		this.userID = userID;
	}
	public String getRefinementScore() {
		return refinementScore;
	}
	public void setRefinementScore(String refinementScore) {
		this.refinementScore = refinementScore;
	}
	public String getCulturalReqScore() {
		return culturalReqScore;
	}
	public void setCulturalReqScore(String culturalReqScore) {
		this.culturalReqScore = culturalReqScore;
	}
	public boolean isCultureReqSatisfy() {
		return cultureReqSatisfy;
	}
	public void setCultureReqSatisfy(boolean cultureReqSatisfy) {
		this.cultureReqSatisfy = cultureReqSatisfy;
	}
	public String getMajorSelectScore() {
		return majorSelectScore;
	}
	public void setMajorSelectScore(String majorSelectScore) {
		this.majorSelectScore = majorSelectScore;
	}
	public String getMajorReqScore() {
		return majorReqScore;
	}
	public void setMajorReqScore(String majorReqScore) {
		this.majorReqScore = majorReqScore;
	}
	public boolean isMajorReqSatisfy() {
		return majorReqSatisfy;
	}
	public void setMajorReqSatisfy(boolean majorReqSatisfy) {
		this.majorReqSatisfy = majorReqSatisfy;
	}
	public boolean isGraduPossible() {
		return graduPossible;
	}
	public void setGraduPossible(boolean graduPossible) {
		this.graduPossible = graduPossible;
	}
	
	public userScoreDTO() {}
	
	public userScoreDTO(String userID, String refinementScore, String culturalReqScore, boolean cultureReqSatisfy,
			String majorSelectScore, String majorReqScore, boolean majorReqSatisfy, boolean graduPossible) {
		super();
		this.userID = userID;
		this.refinementScore = refinementScore;
		this.culturalReqScore = culturalReqScore;
		this.cultureReqSatisfy = cultureReqSatisfy;
		this.majorSelectScore = majorSelectScore;
		this.majorReqScore = majorReqScore;
		this.majorReqSatisfy = majorReqSatisfy;
		this.graduPossible = graduPossible;
	}
	
	
}
