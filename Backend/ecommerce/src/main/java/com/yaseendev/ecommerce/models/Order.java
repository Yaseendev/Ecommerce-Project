package com.yaseendev.ecommerce.models;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.springframework.data.annotation.Id;
import org.springframework.data.mongodb.core.mapping.Document;

import java.time.LocalDateTime;

@Document
@Data
@NoArgsConstructor
@AllArgsConstructor
public class Order {
    @Id
    private String id;

    private OrderStatus status = OrderStatus.PLACED;
    private String userId;
    private Cart cart;
    private Address address;
    private PaymentMethod paymentMethod;
    private String notes;
    private LocalDateTime orderDate = LocalDateTime.now();
}
