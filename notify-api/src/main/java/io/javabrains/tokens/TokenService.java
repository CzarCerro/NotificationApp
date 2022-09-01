package io.javabrains.tokens;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;


@Service
public class TokenService {
	
	@Autowired
	private TokenRepository tokenRepository;
	
	public List<Token> getAllTokens() {
		//return topics;
		List<Token> tokens = new ArrayList<>();
		tokenRepository.findAll().forEach(tokens::add);
		return tokens;
	}
	
	public void addToken(Token token) {
		tokenRepository.save(token);
	}
	
	public void updateToken(Token token) {
		tokenRepository.save(token);
	}
}
