package com.yaseendev.ecommerce.repositories;

import com.mongodb.client.AggregateIterable;
import com.mongodb.client.MongoClient;
import com.mongodb.client.MongoCollection;
import com.mongodb.client.MongoDatabase;
import com.yaseendev.ecommerce.models.Product;
import org.bson.Document;
import org.bson.types.ObjectId;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.mongodb.core.convert.MongoConverter;
import org.springframework.stereotype.Component;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.regex.Pattern;

@Component
public class SearchRepositoryImpl implements SearchRepository{


    final MongoClient mongoClient;
    final MongoConverter converter;

    @Autowired
    public SearchRepositoryImpl(MongoClient mongoClient, MongoConverter converter) {
        this.mongoClient = mongoClient;
        this.converter = converter;
    }

    @Override
    public List<Product> findByCategory(String categoryId) {

        MongoDatabase database = mongoClient.getDatabase("ecommerce");
        MongoCollection<Document> collection = database.getCollection("product");
        List<Product> products = new ArrayList<>();
        AggregateIterable<Document> result = collection.aggregate(Arrays.asList(new Document("$match",
                new Document("$expr",
                        new Document("$eq", Arrays.asList("$category._id",
                                new ObjectId(categoryId)))))));
        result.forEach(product -> products.add(converter.read(Product.class,product)));
        return products;
    }

    @Override
    public List<Product> findByFilter(String term, List<String> categoryIds, BigDecimal startPrice, BigDecimal endPrice, Double startRating, Double endRating, String sort, List<String> brands) {
        MongoDatabase database = mongoClient.getDatabase("ecommerce");
        MongoCollection<Document> collection = database.getCollection("product");
        List<Product> products = new ArrayList<>();
        final Document termDoc = new Document("title", Pattern.compile(term+"(?i)"));
        final Document mainDoc = new Document("$match", termDoc);
            System.out.println("Categories" + categoryIds);
        if(categoryIds != null) {
            termDoc.append("category._id", new Document("$in", categoryIds.stream().map(catId -> new ObjectId(catId)).toList()));
        }
        if(startPrice != null && endPrice !=null) {
            termDoc.append("price", new Document("$lte", endPrice).append("$gte", startPrice));
        }
        if(startRating != null && endRating !=null) {
            termDoc.append("rating", new Document("$lte", endRating).append("$gte", startRating));
        }
        if(brands != null) {
            termDoc.append("brand", new Document("$in", brands));
        }
        List<Document> docs = new ArrayList<>();
        docs.add(mainDoc);
        switch (sort) {
            case "low_price":
                docs.add(new Document("$sort", new Document("price", 1L)));
                break;
            case "high_price":
                docs.add(new Document("$sort", new Document("price", -1L)));
                break;
            case "high_rating":
                docs.add(new Document("$sort", new Document("rating", -1L)));
                break;
            case "low_rating":
                docs.add(new Document("$sort", new Document("rating", 1L)));
                break;
        }

        AggregateIterable<Document> result = collection.aggregate(docs);

        result.forEach(product -> products.add(converter.read(Product.class,product)));
        return products;
//        Arrays.asList(new Document("$match", new Document("price", new Document("$lte", 30L).append("$gte", 13L)).append("title", Pattern.compile("a(?i)")).append("category._id", new Document("$in", Arrays.asList(new ObjectId("642b23c5469635a62b1ba926"), new ObjectId("642b2407469635a62b1ba927"))))),
//                new Document("$sort",
//                        new Document("price", -1L)))
    }
}
