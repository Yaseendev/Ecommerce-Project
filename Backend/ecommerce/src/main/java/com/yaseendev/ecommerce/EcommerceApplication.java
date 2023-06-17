package com.yaseendev.ecommerce;

import com.yaseendev.ecommerce.models.Category;
import com.yaseendev.ecommerce.repositories.CategoryRepository;
import org.springframework.boot.CommandLineRunner;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.autoconfigure.security.servlet.SecurityAutoConfiguration;
import org.springframework.context.annotation.Bean;

import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.List;

@SpringBootApplication //(exclude = SecurityAutoConfiguration.class)
public class EcommerceApplication {

	public static void main(String[] args) {
		SpringApplication.run(EcommerceApplication.class, args);
	}

//	@Bean
//	CommandLineRunner runner(CategoryRepository repository) {
//		return args -> {
//
//			Category category = new Category(
//					"JJ",
//					"AA"
//			);
//			repository.insert(category);
//		};
//	}

}
