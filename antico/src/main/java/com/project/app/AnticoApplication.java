package com.project.app;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.autoconfigure.security.servlet.SecurityAutoConfiguration;

import com.ulisesbocchio.jasyptspringboot.annotation.EnableEncryptableProperties;


@SpringBootApplication(exclude = SecurityAutoConfiguration.class)
@EnableEncryptableProperties
public class AnticoApplication {

	public static void main(String[] args) {
		SpringApplication.run(AnticoApplication.class, args);
	}

}
