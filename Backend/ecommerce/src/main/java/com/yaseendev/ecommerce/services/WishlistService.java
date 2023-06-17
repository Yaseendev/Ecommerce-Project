package com.yaseendev.ecommerce.services;

import com.yaseendev.ecommerce.models.Product;
import com.yaseendev.ecommerce.models.User;
import com.yaseendev.ecommerce.repositories.ProductRepository;
import com.yaseendev.ecommerce.repositories.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.mongodb.core.MongoTemplate;
import org.springframework.data.mongodb.core.query.Criteria;
import org.springframework.data.mongodb.core.query.Query;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;

@Service
public class WishlistService {
    private final JwtService jwtService;
    private final UserRepository userRepository;
    private MongoTemplate mongoTemplate;

    private final ProductRepository productRepository;

    @Autowired
    public WishlistService(JwtService jwtService, UserRepository userRepository, ProductRepository productRepository, MongoTemplate mongoTemplat) {
        this.jwtService = jwtService;
        this.userRepository = userRepository;
        this.mongoTemplate = mongoTemplat;
        this.productRepository = productRepository;
    }

    public List<Product> getWishlist(String token) {
        final String email = jwtService.extractUserEmail(token);
        User user = userRepository.findByEmail(email).get();
        final List<Product> wishList = user.getWishList();
        return wishList;
    }

    public List<Product> addToWishlist(String token, String productId) {
        final String email = jwtService.extractUserEmail(token);
        Query query = new Query();
        query.addCriteria(Criteria.where("email").is(email));

        final User user = mongoTemplate.findOne(query, User.class);
    final Product product = productRepository.findById(productId).get();
        final List<Product> tempList = user.getWishList();

        final int itemIndex = tempList.indexOf(product);
        if (itemIndex == -1) { //If Not Existed
            tempList.add(product);
        }
        user.setWishList(tempList);
        return mongoTemplate.save(user).getWishList();
    }

    public List<Product> removeFromWishlist(String token, String productId) {
        final String email = jwtService.extractUserEmail(token);
        Query query = new Query();
        query.addCriteria(Criteria.where("email").is(email));

        final User user = mongoTemplate.findOne(query, User.class);
        final Product product = productRepository.findById(productId).get();
        final List<Product> tempList = user.getWishList();

        final int itemIndex = tempList.indexOf(product);
        if (itemIndex != -1) { //If Not Existed
            tempList.remove(itemIndex);
        }
        user.setWishList(tempList);
        return mongoTemplate.save(user).getWishList();
    }
}
