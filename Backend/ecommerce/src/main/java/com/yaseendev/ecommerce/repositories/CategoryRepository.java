package com.yaseendev.ecommerce.repositories;

import com.yaseendev.ecommerce.models.Category;
import org.springframework.data.mongodb.repository.MongoRepository;

public interface CategoryRepository extends MongoRepository<Category, String> {

}
