package io.javabrains;

import org.springframework.boot.CommandLineRunner;
import org.springframework.stereotype.Component;
import io.javabrains.notification.SendNotification;


@Component
public class NotificationJob implements CommandLineRunner {
    
    //"run" executes the program first
    public void run(String... args) throws Exception {
    	
    	while(true) {
    		Thread.sleep(5000);
    		
    		System.out.println("Sending notification\n");
    		//SendNotification.sendNotification();
    	}        
    }
    
}
