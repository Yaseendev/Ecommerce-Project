package com.yaseendev.ecommerce.controllers;

import com.yaseendev.ecommerce.models.Product;
import com.yaseendev.ecommerce.services.WishlistService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("api/v1/wishlist")
public class WishlistController {
    private WishlistService service;

    @Autowired
    public WishlistController(WishlistService service){
        this.service = service;
    }

    @GetMapping("/get")
    public ResponseEntity<List<Product>> getUserCart(@RequestHeader String Authorization) {
        final List<Product> wishlist = service.getWishlist(Authorization);
        if(wishlist != null)
            return ResponseEntity.ok(wishlist);
        return ResponseEntity.ok(List.of());
    }

    @PostMapping("/add")
    public ResponseEntity<List<Product>> addToWishlist(
            @RequestHeader String Authorization,
            @RequestBody String productId
    ) {
        System.out.println(productId);
        final List<Product> wishlist = service.addToWishlist(Authorization, productId);
        if(wishlist != null)
            return ResponseEntity.ok(wishlist);
        return ResponseEntity.ok(List.of());
    }

    @PostMapping("/remove")
    public ResponseEntity<List<Product>> removeFromWishlist(
            @RequestHeader String Authorization,
            @RequestBody String productId
    ) {
        final List<Product> wishlist = service.removeFromWishlist(Authorization, productId);
        if(wishlist != null)
            return ResponseEntity.ok(wishlist);
        return ResponseEntity.ok(List.of());
    }
}
