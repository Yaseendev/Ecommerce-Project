package com.yaseendev.ecommerce.repositories;

import com.yaseendev.ecommerce.models.Coupon;
import org.springframework.data.mongodb.repository.MongoRepository;

import java.util.Optional;

public interface CouponRepository extends MongoRepository<Coupon, String> {
    Optional<Coupon> findByName(String name);
    Optional<Coupon> findByCode(String code);
}
