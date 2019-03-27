package user;

public class UserDTO {
	private String userID;
	private String userPassword;
	private String userGrade;
	private String userDepart;
	private String userName;
	private boolean adminChecked;
	private boolean gradu;
	private String userEmail;
	private String userPhone;
	private String person;
	
	
	
	public String getUserEmail() {
		return userEmail;
	}
	public void setUserEmail(String userEmail) {
		this.userEmail = userEmail;
	}
	public String getUserPhone() {
		return userPhone;
	}
	public void setUserPhone(String userPhone) {
		this.userPhone = userPhone;
	}
	public String getPerson() {
		return person;
	}
	public void setPerson(String person) {
		this.person = person;
	}
	public boolean isGradu() {
		return gradu;
	}
	public void setGradu(boolean gradu) {
		this.gradu = gradu;
	}
	public String getUserID() {
		return userID;
	}
	public void setUserID(String userID) {
		this.userID = userID;
	}
	public String getUserPassword() {
		return userPassword;
	}
	public void setUserPassword(String userPassword) {
		this.userPassword = userPassword;
	}
	public String getUserGrade() {
		return userGrade;
	}
	public void setUserGrade(String userGrade) {
		this.userGrade = userGrade;
	}
	public String getUserDepart() {
		return userDepart;
	}
	public void setUserDepart(String userDepart) {
		this.userDepart = userDepart;
	}
	public String getUserName() {
		return userName;
	}
	public void setUserName(String userName) {
		this.userName = userName;
	}
	public boolean isAdminChecked() {
		return adminChecked;
	}
	public void setAdminChecked(boolean adminChecked) {
		this.adminChecked = adminChecked;
	}
	
	public UserDTO() {}
	
	public UserDTO(String userID, String userPassword, String userGrade, String userDepart, String userName,
			boolean adminChecked, boolean gradu, String userEmail, String userPhone, String person) {
		super();
		this.userID = userID;
		this.userPassword = userPassword;
		this.userGrade = userGrade;
		this.userDepart = userDepart;
		this.userName = userName;
		this.adminChecked = adminChecked;
		this.gradu = gradu;
		this.userEmail = userEmail;
		this.userPhone = userPhone;
		this.person = person;
	}
	
	
}
