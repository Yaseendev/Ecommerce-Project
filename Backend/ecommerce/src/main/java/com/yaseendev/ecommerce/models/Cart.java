package com.yaseendev.ecommerce.models;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.With;
import org.springframework.data.mongodb.core.mapping.Field;

import java.util.List;

@Data
@NoArgsConstructor
@AllArgsConstructor
@With
public class Cart {
    @Field
    private List<CartItem> cartContent = List.of();
    private double total;
    private double subtotal;
    private Coupon coupon;
}
