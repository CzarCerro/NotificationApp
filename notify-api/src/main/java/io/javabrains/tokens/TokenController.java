package io.javabrains.tokens;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;


@RestController
public class TokenController {

	@Autowired
	private TokenService tokenService;

	@RequestMapping(value = "/tokens")
		public List<Token> getAllTokens() {
			return tokenService.getAllTokens();
	}
	
	@RequestMapping(method = RequestMethod.POST, value = "/tokens")
	public void addToken(@RequestBody Token token) {
		tokenService.addToken(token);
	}
	
	@RequestMapping(method = RequestMethod.PUT, value = "/tokens")
	public void updateToken(@RequestBody Token token) {
		tokenService.updateToken(token);
	}
}
