package io.javabrains.notification;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;


@RestController
public class NotificationController {

	@Autowired
	private NotificationService notificationService;

	@RequestMapping(value = "/notify")
	public Map<String, String> notifyEndpoint() {
		Map<String, String> message = new HashMap<>();
		message.put("message", "A POST request to this endpoint will send a notification") ;
		 return message;
	}
	
	@RequestMapping(method = RequestMethod.POST, value = "/notify")
	public int sendNotification() {
		int status = 0;
		status = notificationService.sendNotification();
		
		return status;
	}
	
}

