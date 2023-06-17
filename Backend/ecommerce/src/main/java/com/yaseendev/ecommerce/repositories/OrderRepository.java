package com.yaseendev.ecommerce.repositories;

import com.yaseendev.ecommerce.models.Order;
import org.springframework.data.mongodb.repository.MongoRepository;

import java.util.List;
import java.util.Optional;

public interface OrderRepository extends MongoRepository<Order, String> {
    public Optional<List<Order>> findByUserId(String userId);
}
