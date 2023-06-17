package com.yaseendev.ecommerce.services;

import com.yaseendev.ecommerce.models.Address;
import com.yaseendev.ecommerce.models.User;
import com.yaseendev.ecommerce.models.UserEditRequest;
import com.yaseendev.ecommerce.repositories.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.mongodb.core.MongoTemplate;
import org.springframework.data.mongodb.core.query.Criteria;
import org.springframework.data.mongodb.core.query.Query;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Objects;
import java.util.Optional;

@Service
public class UserService {
    private final JwtService jwtService;
    private final UserRepository userRepository;
    private final MongoTemplate mongoTemplate;

    @Autowired
    public UserService(JwtService jwtService, UserRepository userRepository, MongoTemplate mongoTemplat) {
        this.jwtService = jwtService;
        this.userRepository = userRepository;
        this.mongoTemplate = mongoTemplat;
    }

    public User editUser(String token, UserEditRequest userData) throws Exception {
        final String email = jwtService.extractUserEmail(token);
        Query query = new Query();
        query.addCriteria(Criteria.where("email").is(email));
        final User user = mongoTemplate.findOne(query, User.class);
        if(!email.equals(userData.getEmail())){
            if(userRepository.findByEmail(userData.getEmail()).isPresent()) {
                //TODO: throw error
                throw new Exception("This email is already taken");
            } else {
                assert user != null;
                user.setEmail(userData.getEmail());
            }
        }
        if(!userData.getFirstName().equals(user != null ? user.getFirstName() : null)) {
            if (user != null) {
                user.setFirstName(userData.getFirstName());
            }
        }
        if (user != null && !userData.getLastName().equals(user.getLastName())) {
            user.setLastName(userData.getLastName());
        }
        return mongoTemplate.save(Objects.requireNonNull(user));
    }

    public List<Address> getUserAddresses(String token) throws Exception {
        final String email = jwtService.extractUserEmail(token);
       final Optional<User> user =  userRepository.findByEmail(email);
       if(user.isPresent()) {
           return user.get().getAddresses();
       }
      else throw new Exception("User not found");
    }

    public List<Address> addUserAddress(String token, Address address) throws Exception {
        final String email = jwtService.extractUserEmail(token);
        final Optional<User> user =  userRepository.findByEmail(email);
        if(user.isPresent()) {
            user.get().getAddresses().add(address);
            return userRepository.save(user.get()).getAddresses();
        }
        else throw new Exception("User not found");
    }

    public List<Address> editAddress(String token, Address address, int index) throws Exception {
        final String email = jwtService.extractUserEmail(token);
        final Optional<User> user =  userRepository.findByEmail(email);
        if(user.isPresent()) {
            user.get().getAddresses().set(index, address);
            return userRepository.save(user.get()).getAddresses();
        }
        else throw new Exception("User not found");
    }

    public List<Address> deleteAddress(String token, int index) throws Exception {
        final String email = jwtService.extractUserEmail(token);
        final Optional<User> user =  userRepository.findByEmail(email);
        if(user.isPresent()) {
            user.get().getAddresses().remove(index);
            return userRepository.save(user.get()).getAddresses();
        }
        else throw new Exception("User not found");
    }
    
    public String extractId(String token) throws Exception {
        final String email = jwtService.extractUserEmail(token);
        final Optional<User> user = userRepository.findByEmail(email);
        if(user.isPresent()) {
            return userRepository.findByEmail(email).get().getId();
        }
        else throw new Exception("User not found");
    }
}
