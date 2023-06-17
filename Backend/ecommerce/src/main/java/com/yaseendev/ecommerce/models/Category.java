package com.yaseendev.ecommerce.models;

import lombok.AllArgsConstructor;
import lombok.Data;

import lombok.NoArgsConstructor;
import org.springframework.data.annotation.Id;
import org.springframework.data.mongodb.core.mapping.Document;

// (collation = "category")
@Document
@Data
@NoArgsConstructor
@AllArgsConstructor
public class Category {
    //@GeneratedValue(strategy = AUTO)
    @Id
    private String id;
    private String name;
    private String imgUrl;

    public Category(String name, String imgUrl) {
        this.name = name;
        this.imgUrl = imgUrl;
    }
}

