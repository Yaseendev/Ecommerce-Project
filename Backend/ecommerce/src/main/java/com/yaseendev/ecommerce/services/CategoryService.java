package com.yaseendev.ecommerce.services;

import com.yaseendev.ecommerce.models.Category;
import com.yaseendev.ecommerce.repositories.CategoryRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class CategoryService {

    private CategoryRepository repository;

    @Autowired
    public CategoryService(CategoryRepository repository) {
        this.repository = repository;
    }

    public Category save(Category category) {
        return repository.insert(category);
    }

    public List<Category> getCategories() {
        return repository.findAll();
    }
}
