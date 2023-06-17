package com.yaseendev.ecommerce.services;

import com.yaseendev.ecommerce.models.Product;
import com.yaseendev.ecommerce.repositories.ProductRepository;
import com.yaseendev.ecommerce.repositories.SearchRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

@Service
public class ProductService {
    private ProductRepository repository;
    private SearchRepository searchRepository;

    @Autowired
    public ProductService(ProductRepository repository, SearchRepository searchRepository) {
        this.repository = repository;
        this.searchRepository = searchRepository;
    }

    public Product add(Product product) {return repository.insert(product);}

    public List<Product> getAllProducts() {
        return repository.findAll();
    }

    public List<Product> getCategoryProducts(String categoryId) {
        return searchRepository.findByCategory(categoryId);
    }

    public Product getDealOfDay() {
        return repository.findDealOfDay();
    }

    public Optional<Product> getProduct(String id) {
        return repository.findById(id);
    }

    public List<Product> getMostPopular() {
        return repository.fetchMostPopular();
    }

    public List<Product> getMostRated() {
        return repository.fetchMostRated();
    }

    public List<Product> getNewProducts() {
        return repository.fetchNewProducts();
    }

    public List<Product> searchProducts(String term, List<String> categoryIds, BigDecimal startPrice, BigDecimal endPrice, Double startRating, Double endRating, String sort, List<String> brands) {
        return searchRepository.findByFilter(term, categoryIds,startPrice,endPrice, startRating, endRating, sort, brands);
    }


    public Object getAllProductsBrands() {
        return repository.fetchAllBrands();
    }
}
