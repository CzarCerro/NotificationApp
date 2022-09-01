package io.javabrains.notification;

import org.springframework.stereotype.Service;

@Service
public class NotificationService {
	public static int sendNotification() {
		return SendNotification.sendNotification();
	}
}

