package com.yaseendev.ecommerce.controllers;

import com.yaseendev.ecommerce.models.Address;
import com.yaseendev.ecommerce.models.EditAddressRequest;
import com.yaseendev.ecommerce.models.User;
import com.yaseendev.ecommerce.models.UserEditRequest;
import com.yaseendev.ecommerce.services.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("api/v1/user")
public class UserController {

    private final UserService service;

    @Autowired
    public UserController(UserService service) {
        this.service = service;
    }

    @PostMapping("/edit")
    public ResponseEntity<?> editUser(
            @RequestHeader String Authorization,
            @RequestBody UserEditRequest editRequest
            ) {
        try {
            return ResponseEntity.ok(service.editUser(Authorization, editRequest));
        } catch (Exception e) {
            return ResponseEntity.badRequest().body(e.getLocalizedMessage());
        }
    }

    @GetMapping("/addresses")
    public ResponseEntity<?> getUserAddresses(
            @RequestHeader String Authorization
    ) {
        try {
            return ResponseEntity.ok(service.getUserAddresses(Authorization));
        } catch (Exception e) {
            return ResponseEntity.status(404).body(e.getLocalizedMessage());
        }
    }

    @PostMapping("/addresses/add")
    public ResponseEntity<?> addUserAddress(
            @RequestHeader String Authorization,
            @RequestBody Address address
    ) {
        System.out.println(address);
        try {
            return ResponseEntity.ok(service.addUserAddress(Authorization, address));
        } catch (Exception e) {
            return ResponseEntity.status(404).body(e.getLocalizedMessage());
        }
    }

    @PostMapping("/addresses/edit")
    public ResponseEntity<?> editUserAddress(
            @RequestHeader String Authorization,
            @RequestBody EditAddressRequest request
    ) {
        System.out.println(request);
        try {
            return ResponseEntity.ok(service.editAddress(Authorization, request.getAddress(), request.getIndex()));
        } catch (Exception e) {
            return ResponseEntity.status(404).body(e.getLocalizedMessage());
        }
    }

    @DeleteMapping("/addresses")
    public ResponseEntity<?> deleteUserAddress(
            @RequestHeader String Authorization,
            @RequestBody int addressIndex
    ) {
        System.out.println(addressIndex);
        try {
            return ResponseEntity.ok(service.deleteAddress(Authorization, addressIndex));
        } catch (Exception e) {
            return ResponseEntity.status(404).body(e.getLocalizedMessage());
        }
    }
}
