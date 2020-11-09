package poly.dto;

public class UserInfoDTO {

	
	private String email;
	private String user_name;
	private String password;
	private String reg_id;
	private String reg_dt;
	private String chg_id;
	private String chg_dt;
	private String phone;
	private String have_sign;
	public String getPhone() {
		return phone;
	}
	public void setPhone(String phone) {
		this.phone = phone;
	}
	public String getHave_sign() {
		return have_sign;
	}
	public void setHave_sign(String have_sign) {
		this.have_sign = have_sign;
	}
	//회원가입시, 중복가입을 방지 위해 사용할변수
	//DB 를 조회해서 외원이 존해하면 y값을 반환함
	//DB 테이블에 존재하지않는  가상의칼럼(ALIAS)
	private String exists_yn;
	
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getUser_name() {
		return user_name;
	}
	public void setUser_name(String user_name) {
		this.user_name = user_name;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public String getReg_id() {
		return reg_id;
	}
	public void setReg_id(String reg_id) {
		this.reg_id = reg_id;
	}
	public String getReg_dt() {
		return reg_dt;
	}
	public void setReg_dt(String reg_dt) {
		this.reg_dt = reg_dt;
	}
	public String getChg_id() {
		return chg_id;
	}
	public void setChg_id(String chg_id) {
		this.chg_id = chg_id;
	}
	public String getChg_dt() {
		return chg_dt;
	}
	public void setChg_dt(String chg_dt) {
		this.chg_dt = chg_dt;
	}
	public String getExists_yn() {
		return exists_yn;
	}
	public void setExists_yn(String exists_yn) {
		this.exists_yn = exists_yn;
	}

	
	


	
}
