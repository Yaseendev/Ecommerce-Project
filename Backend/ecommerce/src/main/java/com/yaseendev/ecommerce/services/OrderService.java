package com.yaseendev.ecommerce.services;

import com.yaseendev.ecommerce.models.Order;
import com.yaseendev.ecommerce.models.OrderStatus;
import com.yaseendev.ecommerce.repositories.OrderRepository;
import lombok.SneakyThrows;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
public class OrderService {
    private final OrderRepository orderRepository;
    private final CartService cartService;
    private final UserService userService;

    @Autowired
    public OrderService(OrderRepository orderRepository,
                        CartService cartService,
                        UserService userService
                        ) {
        this.orderRepository = orderRepository;
        this.cartService = cartService;
        this.userService = userService;
    }

    public List<Order> getAllOrders() {
        return orderRepository.findAll();
    }

    public Optional<List<Order>> getUserOrders(String token) throws Exception {
        final String userID = userService.extractId(token);
        return orderRepository.findByUserId(userID);
    }

    public Order add(Order order, String id) {
         orderRepository.insert(order);
         order.setUserId(id);
       return orderRepository.save(order);
    }

    @SneakyThrows
    public List<Order> placeOrder(Order order, String token) {
        final String userID = userService.extractId(token);
        cartService.clearCart(userID);
       add(order, userID);
       return orderRepository.findByUserId(userID).get();
    }

    public void cancelOrder(String orderId) throws Exception {
       final Optional<Order> order = orderRepository.findById(orderId);
        if(order.isPresent()) {
            order.get().setStatus(OrderStatus.CANCELED);
             orderRepository.save(order.get());
        }
        else throw new Exception("Order not found");
    }
}
