package com.yaseendev.ecommerce.services;

import com.yaseendev.ecommerce.models.*;
import com.yaseendev.ecommerce.repositories.ProductRepository;
import com.yaseendev.ecommerce.repositories.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.mongodb.core.MongoTemplate;
import org.springframework.data.mongodb.core.query.Criteria;
import org.springframework.data.mongodb.core.query.Query;
import org.springframework.stereotype.Service;
import java.util.List;
import java.util.Objects;
import java.util.stream.Collectors;

@Service
public class CartService {

    private final JwtService jwtService;
    private final UserRepository userRepository;
    private MongoTemplate mongoTemplate;

    private final ProductRepository productRepository;

    @Autowired
    public CartService(JwtService jwtService, UserRepository userRepository, ProductRepository productRepository, MongoTemplate mongoTemplat) {
        this.jwtService = jwtService;
        this.userRepository = userRepository;
        this.mongoTemplate = mongoTemplat;
        this.productRepository = productRepository;
    }

    public Cart getUserCart(String token) {
        final String email = jwtService.extractUserEmail(token);
        User user = userRepository.findByEmail(email).get();
        final Cart cart = user.getCart();
        return cart;
    }

    public Cart addToCart(String token, String productId, int quantity) {
        final String email = jwtService.extractUserEmail(token);
        Query query = new Query();
        query.addCriteria(Criteria.where("email").is(email));

        final User user = mongoTemplate.findOne(query, User.class);
        final Product product = productRepository.findById(productId).get();
        final Cart tempCart = user.getCart();
        final CartItem item = CartItem.builder()
                .product(product)
                .quantity(quantity)
                .build();
        final int itemIndex = tempCart.getCartContent().indexOf(item);
        if (itemIndex == -1) { //If Not Existed
            tempCart.getCartContent().add(item);
        } else {
            item.setQuantity(tempCart.getCartContent().get(itemIndex).getQuantity() + item.getQuantity());
            tempCart.getCartContent().set(itemIndex, item);
        }
         final double subTotal = tempCart.getCartContent().stream().collect(Collectors.summarizingDouble((s) -> s.getProduct().getFinalPrice().doubleValue() * s.getQuantity())).getSum();
        double total = subTotal;
        if(tempCart.getCoupon() != null) {
            total -= tempCart.getCoupon().getValue().doubleValue();
        }
        tempCart.setSubtotal(subTotal);
        tempCart.setTotal(total);
        user.setCart(tempCart);
        return mongoTemplate.save(user).getCart();
    }

    public Cart bulkAddToCart(String token, List<CartItemRequest> items) {
        final String email = jwtService.extractUserEmail(token);
        Query query = new Query();
        query.addCriteria(Criteria.where("email").is(email));

        final User user = mongoTemplate.findOne(query, User.class);
        final Cart tempCart = user.getCart();
        items.forEach((item) -> {
            final Product product = productRepository.findById(item.getProductId()).get();
            final CartItem cartItem = CartItem.builder()
                    .product(product)
                    .quantity(item.getQuantity())
                    .build();
            final int itemIndex = tempCart.getCartContent().indexOf(cartItem);
            if (itemIndex == -1) { //If Not Existed
                tempCart.getCartContent().add(cartItem);
            } else {
                cartItem.setQuantity(tempCart.getCartContent().get(itemIndex).getQuantity() + cartItem.getQuantity());
                tempCart.getCartContent().set(itemIndex, cartItem);
            }
        });
        final double subTotal = tempCart.getCartContent().stream().collect(Collectors.summarizingDouble((s) -> s.getProduct().getPrice() * s.getQuantity())).getSum();
        double total = subTotal;
        if(tempCart.getCoupon() != null) {
            total -= tempCart.getCoupon().getValue().doubleValue();
        }
        tempCart.setSubtotal(subTotal);
        tempCart.setTotal(total);
        user.setCart(tempCart);
        return mongoTemplate.save(user).getCart();
    }

    public Cart updateCart(String token, String productId, int quantity) {
        final String email = jwtService.extractUserEmail(token);
        Query query = new Query();
        query.addCriteria(Criteria.where("email").is(email));

        final User user = mongoTemplate.findOne(query, User.class);
        final Product product = productRepository.findById(productId).get();
        final Cart tempCart = user.getCart();
        final CartItem item = CartItem.builder()
                .product(product)
                .quantity(quantity)
                .build();
        final int itemIndex = tempCart.getCartContent().indexOf(item);
        if (itemIndex != -1) {
            tempCart.getCartContent().set(itemIndex, item);
        }
        final double subTotal = tempCart.getCartContent().stream().collect(Collectors.summarizingDouble((s) -> s.getProduct().getPrice() * s.getQuantity())).getSum();
        double total = subTotal;
        if(tempCart.getCoupon() != null) {
            total -= tempCart.getCoupon().getValue().doubleValue();
        }
        tempCart.setSubtotal(subTotal);
        tempCart.setTotal(total);
        user.setCart(tempCart);
        return mongoTemplate.save(user).getCart();
    }

    public Cart deleteFromCart(String token, String productId) {
        final String email = jwtService.extractUserEmail(token);
        Query query = new Query();
        query.addCriteria(Criteria.where("email").is(email));

        final User user = mongoTemplate.findOne(query, User.class);
        final Product product = productRepository.findById(productId).get();
        final Cart tempCart = Objects.requireNonNull(user).getCart();
        final CartItem item = CartItem.builder()
                .product(product)
                .build();
        final int itemIndex = tempCart.getCartContent().indexOf(item);
        if (itemIndex != -1) {
            tempCart.getCartContent().remove(itemIndex);
        }
        final double subTotal = tempCart.getCartContent().stream().collect(Collectors.summarizingDouble((s) -> s.getProduct().getPrice() * s.getQuantity())).getSum();
        double total = subTotal;
        if(tempCart.getCoupon() != null) {
            total -= tempCart.getCoupon().getValue().doubleValue();
        }
        tempCart.setSubtotal(subTotal);
        tempCart.setTotal(total);
        user.setCart(tempCart);
        return mongoTemplate.save(user).getCart();
    }

    public Cart clearCart(String id) {
        final User user = userRepository.findById(id).get();
        user.setCart(new Cart());
        return userRepository.save(user).getCart();
    }
}
