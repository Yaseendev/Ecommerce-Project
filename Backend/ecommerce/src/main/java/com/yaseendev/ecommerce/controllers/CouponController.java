package com.yaseendev.ecommerce.controllers;

import com.yaseendev.ecommerce.models.Coupon;
import com.yaseendev.ecommerce.services.CouponService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("api/v1/coupon")
public class CouponController {
    private final CouponService couponService;

    @Autowired
    public CouponController(CouponService couponService) {
        this.couponService = couponService;
    }

    @GetMapping
    public ResponseEntity<?> checkCoupon(
            @RequestHeader String Authorization,
            @RequestParam String code) {
        try {
            return ResponseEntity.ok(couponService.getCoupon(code, Authorization));
        } catch (Exception e){
            return ResponseEntity.badRequest().body(e.getLocalizedMessage());
        }
    }

    @PostMapping("/add")
    public ResponseEntity<?> addCoupon(@RequestBody Coupon coupon) {
        try {
            return ResponseEntity.ok(couponService.addCoupon(coupon));
        } catch (Exception e){
            return ResponseEntity.badRequest().body(e.getLocalizedMessage());
        }
    }

    @PostMapping("/remove")
    public ResponseEntity<?> removeCoupon(
            @RequestHeader String Authorization) {
        try {
            return ResponseEntity.ok(couponService.removeCoupon(Authorization));
        } catch (Exception e){
            return ResponseEntity.badRequest().body(e.getLocalizedMessage());
        }
    }
}
