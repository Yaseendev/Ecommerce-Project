package com.yaseendev.ecommerce.services;

import com.yaseendev.ecommerce.models.*;
import com.yaseendev.ecommerce.repositories.UserRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.Optional;

@Service
@RequiredArgsConstructor
public class AuthenticationService {

    private final UserRepository userRepository;
    private final PasswordEncoder passwordEncoder;
    private final JwtService jwtService;
    private final AuthenticationManager authenticationManager;
    public AuthenticationResponse register(RegisterRequest request) {
        var user = User.builder()
                .firstName(request.getFirstName())
                .lastName(request.getLastName())
                .email(request.getEmail())
                .password(passwordEncoder.encode(request.getPassword()))
                .profileImgUrl("")
                .addresses(new ArrayList<>())
                .wishList(new ArrayList<>())
                .role(Role.USER)
                .build();
        userRepository.save(user);
        var authToken = jwtService.generateToken(user);
        System.out.println(authToken);
        return AuthenticationResponse.builder()
                .user(user)
                .token(authToken)
                .build();
    }

    public AuthenticationResponse authenticate(AuthenticationRequest request) {
        authenticationManager.authenticate(
                new UsernamePasswordAuthenticationToken(
                        request.getEmail(),
                        request.getPassword()
                )
        );

        var user = userRepository.findByEmail(request.getEmail()).orElseThrow();
        userRepository.save(user);
        var authToken = jwtService.generateToken(user);
        return AuthenticationResponse.builder()
                .token(authToken)
                .user(user)
                .build();
    }

    public AuthenticationResponse tokenCheck(String bearerToken) {
        if(bearerToken.startsWith("Bearer ")){
            final String token = bearerToken.substring("Bearer ".length());
            final String email = jwtService.extractUsername(token);
            if(email != null){
                Optional<User> userDetails = userRepository.findByEmail(email);
                if(jwtService.isTokenValid(token, userDetails.get().getEmail())) {
                    return  AuthenticationResponse
                            .builder()
                            .token(token)
                            .user(userDetails.get())
                            .build();
                }
            }
        }
        return AuthenticationResponse.builder().token(bearerToken).build();
    }
}
