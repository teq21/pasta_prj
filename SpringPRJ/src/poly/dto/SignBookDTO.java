package poly.dto;

import java.util.List;
import java.util.Map;

import poly.util.Criteria;

public class SignBookDTO {

	private String post_no;
	private String post_title;
	private String thumb_nail;
	private String img_one;
	private String img_two;
	private String sign_info;
	private String sign_inst;
	
	public String getImg_one() {
		return img_one;
	}
	public void setImg_one(String img_one) {
		this.img_one = img_one;
	}
	public String getImg_two() {
		return img_two;
	}
	public void setImg_two(String img_two) {
		this.img_two = img_two;
	}
	public String getSign_info() {
		return sign_info;
	}
	public void setSign_info(String sign_info) {
		this.sign_info = sign_info;
	}
	public String getSign_inst() {
		return sign_inst;
	}
	public void setSign_inst(String sign_inst) {
		this.sign_inst = sign_inst;
	}
	public String getPost_no() {
		return post_no;
	}
	public void setPost_no(String post_no) {
		this.post_no = post_no;
	}
	public String getPost_title() {
		return post_title;
	}
	public void setPost_title(String post_title) {
		this.post_title = post_title;
	}
	
	public String getThumb_nail() {
		return thumb_nail;
	}
	public void setThumb_nail(String thumb_nail) {
		this.thumb_nail = thumb_nail;
	}
	
}
