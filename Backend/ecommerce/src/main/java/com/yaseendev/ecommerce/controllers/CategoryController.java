package com.yaseendev.ecommerce.controllers;

import com.yaseendev.ecommerce.models.Category;
import com.yaseendev.ecommerce.services.CategoryService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("api/v1/categories")
public class CategoryController {

    private CategoryService categoryService;

    @Autowired
    public CategoryController(CategoryService categoryService){
        this.categoryService = categoryService;
    }

    @PostMapping("/add")
    @ResponseStatus(HttpStatus.CREATED)
    public Category addCategory(
           @RequestBody Category category) {
        return categoryService.save(category);
    }

    @GetMapping
    public List<Category> getCategories() {
        return categoryService.getCategories();
    }


}
