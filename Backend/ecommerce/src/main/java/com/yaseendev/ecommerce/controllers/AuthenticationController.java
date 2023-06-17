package com.yaseendev.ecommerce.controllers;

import com.yaseendev.ecommerce.models.AuthenticationRequest;
import com.yaseendev.ecommerce.models.AuthenticationResponse;
import com.yaseendev.ecommerce.models.RegisterRequest;
import com.yaseendev.ecommerce.services.AuthenticationService;
import com.yaseendev.ecommerce.services.JwtService;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("api/v1/auth")
@RequiredArgsConstructor
public class AuthenticationController {
    private final AuthenticationService authService;
    private final JwtService jwtService;

    @PostMapping("/register")
    public ResponseEntity<AuthenticationResponse> register(
            @RequestBody @Valid RegisterRequest request
    ) {
        return ResponseEntity.ok(authService.register(request));
    }

    @PostMapping("/signin")
    public ResponseEntity<AuthenticationResponse> authenticate(
            @RequestBody AuthenticationRequest request
    ) {
        return ResponseEntity.ok(authService.authenticate(request));
    }

    @PostMapping("/token-check")
    public ResponseEntity<?> tokenCheck(@RequestHeader String Authorization) {
        System.out.println("Token Check Res: " + Authorization);
       final AuthenticationResponse res = authService.tokenCheck(Authorization);
        if(res.getUser() != null)
         return ResponseEntity.ok(res);
        return ResponseEntity.status(403).body("Token has been expired");
    }

}
