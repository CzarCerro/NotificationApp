package io.javabrains.tokens;

import javax.persistence.Entity;
import javax.persistence.Id;

@Entity
public class Token {
	
	@Id //This annotation chooses id as the primary key
	private String token;
	private String status;
	
	public Token() {

	}

	public Token(String token, String status, String password) {
		super();
		this.token = token;
		this.status = status;
	}

	public String getToken() {
		return token;
	}

	public void setToken(String token) {
		this.token = token;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}
	

}
