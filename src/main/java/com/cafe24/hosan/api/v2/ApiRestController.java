package com.cafe24.hosan.api.v2;

import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("api/v2")
//@ApiVersion(1)
public class ApiRestController {

	 @RequestMapping(value = "/members/")
	 public ResponseEntity<?> v1Foo() {
	   return ResponseEntity.ok("v1 foo");
	 }

}
