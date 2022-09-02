package io.javabrains;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.CommandLineRunner;
import org.springframework.stereotype.Component;
import io.javabrains.notification.SendNotification;
import io.javabrains.tokens.Token;
import io.javabrains.tokens.TokenService;


@Component
public class NotificationJob implements CommandLineRunner {
    
	@Autowired
	private TokenService tokenService;
	
    //"run" executes the program first
    public void run(String... args) throws Exception {
    	
    	while(true) {
    		Thread.sleep(5000);		
    		List<Token> tokenList = tokenService.getAllTokens();
    		
    		for (Object token : tokenList) {
    			if (Boolean.valueOf(((Token) token).getStatus())) {
    				SendNotification.sendNotification(((Token) token).getToken());
    			}
    		}
    	}        
    }
    
}
