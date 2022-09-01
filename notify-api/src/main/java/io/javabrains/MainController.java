package io.javabrains;

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
public class MainController {

	@RequestMapping(value = "/")
	public Map<String, String> sendNotification() {
		Map<String, String> message = new HashMap<>();
		message.put("message", "This is a notification API") ;
		 return message;
	}
}

