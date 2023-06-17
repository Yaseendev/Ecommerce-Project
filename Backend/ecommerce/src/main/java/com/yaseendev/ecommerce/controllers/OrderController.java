package com.yaseendev.ecommerce.controllers;

import com.yaseendev.ecommerce.models.Order;
import com.yaseendev.ecommerce.services.OrderService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.math.BigDecimal;
import java.util.List;

@RestController
@RequestMapping("api/v1/orders")
public class OrderController {

    private final OrderService orderService;

    @Autowired
    public OrderController(OrderService orderService) {
        this.orderService = orderService;
    }

    @GetMapping("/get")
    public ResponseEntity<?> getOrders(@RequestHeader String Authorization) {
        try {
            return ResponseEntity.ok(orderService.getUserOrders(Authorization).get());
        } catch (Exception e) {
            return ResponseEntity.badRequest().body(e.getLocalizedMessage());
        }
    }

    @PostMapping("/add")
    public ResponseEntity<?> addOrder(
            @RequestHeader String Authorization,
            @RequestBody Order order) {
        try {
            return ResponseEntity.ok(orderService.placeOrder(order, Authorization));
        } catch (Exception e) {
            return ResponseEntity.badRequest().body(e.getLocalizedMessage());
        }
    }

    @PostMapping("/cancel")
    public ResponseEntity<?> cancelOrder(@RequestBody String orderId) {
        try {
            System.out.println(orderId);
            orderService.cancelOrder(orderId);
            return ResponseEntity.ok("Order Canceled");
        } catch (Exception e) {
            return ResponseEntity.badRequest().body(e.getLocalizedMessage());
        }
    }
}
