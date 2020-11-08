package poly.dto;

public class VideoDTO {
	private String sign_name;
	private String date;
	private String path;
	private String tm_path;
	public String getTm_path() {
		return tm_path;
	}
	public void setTm_path(String tm_path) {
		this.tm_path = tm_path;
	}
	public String getSign_name() {
		return sign_name;
	}
	public void setSign_name(String sign_name) {
		this.sign_name = sign_name;
	}
	public String getDate() {
		return date;
	}
	public void setDate(String date) {
		this.date = date;
	}
	public String getPath() {
		return path;
	}
	public void setPath(String path) {
		this.path = path;
	}
}
