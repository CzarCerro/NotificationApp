package io.javabrains.notification;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Component;

import io.javabrains.PushyAPI;

@Component
public class SendNotification {
	public static int sendNotification() {
		// Prepare list of target device tokens
		List<String> deviceTokens = new ArrayList<>();
		int status = 0;

		// Add your device tokens here
	    deviceTokens.add("3c80d9d89b761c1f9f4f72");
	    
		// Convert to String[] array
		String[] to = deviceTokens.toArray(new String[deviceTokens.size()]);

		// Set payload (any object, it will be serialized to JSON)
		Map<String, String> payload = new HashMap<>();

		// Add "message" parameter to payload
		payload.put("message", "Hello from API");

		// iOS notification fields
		Map<String, Object> notification = new HashMap<>();

		notification.put("badge", 1);
		notification.put("sound", "ping.aiff");
		notification.put("title", "Test Notification");
		notification.put("body", "Hello from API \u270c");

		// Prepare the push request
		PushyAPI.PushyPushRequest push = new PushyAPI.PushyPushRequest(payload, to, notification);

		try {
			// Try sending the push notification
			PushyAPI.sendPush(push);
			status = 1;
		}
		catch (Exception exc) {
			// Error, print to console
			System.out.println(exc.toString());
		}
		
		return status;
	}
}
