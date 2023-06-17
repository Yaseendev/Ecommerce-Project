package com.yaseendev.ecommerce.repositories;

import com.yaseendev.ecommerce.models.Product;
import org.springframework.data.mongodb.repository.Aggregation;
import org.springframework.data.mongodb.repository.MongoRepository;

import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

public interface ProductRepository extends MongoRepository<Product, String> {

    public List<Product> findByCategory();

    public Optional<Product> findById(String id);

    @Aggregation(pipeline = {"{'$sample': {'size': 1}}"})
    public Product findDealOfDay();

    @Aggregation(pipeline = {"{'$sample': {'size': 12}}"})
    public List<Product> fetchMostPopular();

    @Aggregation(pipeline = {
            "{'$sort': {'rating': -1}}",
            "{'$limit': 10}"
    })
    public List<Product> fetchMostRated();

    @Aggregation(pipeline = {
            "{'$sort': {'_id': -1}}",
            "{'$limit': 10}"
    })
    public List<Product> fetchNewProducts();

    @Aggregation(pipeline = {
            "{'$group': {'_id': 0, 'brands': {'$addToSet': '$brand'}}}"
    })
    public Object fetchAllBrands();
}
