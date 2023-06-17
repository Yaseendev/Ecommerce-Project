package com.yaseendev.ecommerce.services;

import com.yaseendev.ecommerce.models.Cart;
import com.yaseendev.ecommerce.models.Coupon;
import com.yaseendev.ecommerce.models.User;
import com.yaseendev.ecommerce.repositories.CouponRepository;
import com.yaseendev.ecommerce.repositories.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Optional;

@Service
public class CouponService {
    private final CouponRepository couponRepository;
    private final JwtService jwtService;
    private final UserRepository userRepository;

    @Autowired
    public CouponService(CouponRepository couponRepository, JwtService jwtService, UserRepository userRepository) {
        this.couponRepository = couponRepository;
        this.jwtService = jwtService;
        this.userRepository = userRepository;
    }

    public Cart getCoupon(String cName, String token) throws Exception {
        final String email = jwtService.extractUserEmail(token);
        final Optional<Coupon> coupon = couponRepository.findByCode(cName);
        if(coupon.isPresent()) {
            if (coupon.get().getValid()) {
                final Optional<User> user = userRepository.findByEmail(email);
                if(user.isPresent()) {
                    final Cart userCart = user.get().getCart();
                    userCart.setCoupon(coupon.get());
                    userCart.setTotal(userCart.getTotal() - coupon.get().getValue().doubleValue());
                    user.get().setCart(userCart);
                    return userRepository.save(user.get()).getCart();
                }
                else throw new Exception("User Error");
            }
            else throw new Exception("Coupon is invalid");
        } else throw new Exception("Coupon not found");
    }

    public Coupon addCoupon(Coupon coupon) throws Exception {
        final Optional<Coupon> insertedCoupon = couponRepository.findByCode(coupon.getCode());
        if(insertedCoupon.isPresent()) {
            throw new Exception("Coupon is already existed");
        } else return couponRepository.insert(coupon);
    }

    public Cart removeCoupon(String token) throws Exception {
        final String email = jwtService.extractUserEmail(token);
        final Optional<User> user = userRepository.findByEmail(email);
        if(user.isPresent()) {
            final Cart userCart = user.get().getCart();
            userCart.setTotal(userCart.getSubtotal());
            userCart.setCoupon(null);
            user.get().setCart(userCart);
            return userRepository.save(user.get()).getCart();
        }
        else throw new Exception("User Error");
    }

}
