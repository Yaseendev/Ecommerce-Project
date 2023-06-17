package com.yaseendev.ecommerce.controllers;

import com.yaseendev.ecommerce.models.*;
import com.yaseendev.ecommerce.services.CartService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.math.BigDecimal;
import java.math.BigInteger;
import java.util.List;

@RestController
@RequestMapping("api/v1/cart")
public class CartController {

    private final CartService cartService;

    @Autowired
    public CartController(CartService cartService){
        this.cartService = cartService;
    }

    @GetMapping("/get-cart")
    public ResponseEntity<Cart> getUserCart(@RequestHeader String Authorization) {
        final Cart cart = cartService.getUserCart(Authorization);
        if(cart != null)
            return ResponseEntity.ok(cart);
        return ResponseEntity.ok(new Cart());
    }

    @PostMapping("/add")
    public ResponseEntity<Cart> addToCart(
            @RequestHeader String Authorization,
            @RequestBody CartItemRequest addRequest
            ) {
        final Cart cart = cartService.addToCart(Authorization, addRequest.getProductId(), addRequest.getQuantity());
        if(cart != null)
            return ResponseEntity.ok(cart);
       return ResponseEntity.ok(new Cart());
    }

    @PostMapping("/add-all")
    public ResponseEntity<Cart> addToCartBulk(
            @RequestHeader String Authorization,
            @RequestBody CartAddAllRequest addRequest
    ) {
        System.out.println(addRequest);
   final Cart cart = cartService.bulkAddToCart(Authorization, addRequest.getItems());
        if(cart != null)
            return ResponseEntity.ok(cart);
        return ResponseEntity.ok(new Cart());
    }

    @PostMapping("/update")
    public ResponseEntity<Cart> updateCart(
            @RequestHeader String Authorization,
            @RequestBody CartItemRequest updateRequest
    ) {
        final Cart cart = cartService.updateCart(Authorization, updateRequest.getProductId(), updateRequest.getQuantity());
        if(cart != null)
            return ResponseEntity.ok(cart);
        return ResponseEntity.ok(new Cart());
    }

    @PostMapping("/remove")
    public ResponseEntity<Cart> removeFromCart(
            @RequestHeader String Authorization,
            @RequestBody String productId
    ) {
        final Cart cart = cartService.deleteFromCart(Authorization, productId);
        if(cart != null)
            return ResponseEntity.ok(cart);
        return ResponseEntity.ok(new Cart());
    }
}
