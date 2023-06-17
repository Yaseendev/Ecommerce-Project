package com.yaseendev.ecommerce.models;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
public class OrderRequest {

    private OrderStatus status = OrderStatus.PLACED;
    private String userId;
    private Cart cart;
    private Address address;
    private PaymentMethod paymentMethod;
}
