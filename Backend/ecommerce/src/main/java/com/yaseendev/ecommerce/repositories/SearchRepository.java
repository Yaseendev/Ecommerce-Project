package com.yaseendev.ecommerce.repositories;

import com.yaseendev.ecommerce.models.Product;

import java.math.BigDecimal;
import java.util.List;

public interface SearchRepository {
    List<Product> findByCategory(String categoryId);

    List<Product> findByFilter(String  term, List<String> categoryIds, BigDecimal startPrice, BigDecimal endPrice, Double startRating, Double endRating, String sort, List<String> brands);
}
