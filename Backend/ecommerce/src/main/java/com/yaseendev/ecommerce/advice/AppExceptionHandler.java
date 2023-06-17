package com.yaseendev.ecommerce.advice;

import com.mongodb.DuplicateKeyException;
import com.mongodb.MongoWriteException;
import io.jsonwebtoken.ExpiredJwtException;
import org.springframework.dao.DataAccessResourceFailureException;
import org.springframework.http.HttpStatus;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.web.HttpMediaTypeNotSupportedException;
import org.springframework.web.HttpRequestMethodNotSupportedException;
import org.springframework.web.bind.MethodArgumentNotValidException;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.ResponseStatus;
import org.springframework.web.bind.annotation.RestControllerAdvice;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

@RestControllerAdvice
public class AppExceptionHandler {

    @ResponseStatus(HttpStatus.BAD_REQUEST)
    @ExceptionHandler(MethodArgumentNotValidException.class)
    public Map<String, ?> handleInvalidArguments(MethodArgumentNotValidException exception) {
        Map<String, List<String>> errMap = new HashMap<>();
        errMap.put("errors", exception.getBindingResult().getFieldErrors().stream().map(error -> error.getDefaultMessage()).collect(Collectors.toList()));
        return errMap;
    }

    @ResponseStatus(HttpStatus.NOT_FOUND)
    @ExceptionHandler(HttpRequestMethodNotSupportedException.class)
    public Map<String, ?> handleWrongEndPoint(HttpRequestMethodNotSupportedException exception) {
        Map<String, String> errMap = new HashMap<>();
        errMap.put("message", "Wrong Api Call");
        return errMap;
    }

    @ResponseStatus(HttpStatus.BAD_GATEWAY)
    @ExceptionHandler(HttpMediaTypeNotSupportedException.class)
    public Map<String, ?> handleMediaTypeException(HttpMediaTypeNotSupportedException exception) {
        Map<String, String> errMap = new HashMap<>();
        errMap.put("message", exception.getLocalizedMessage());
        return errMap;
    }

    @ResponseStatus(HttpStatus.CONFLICT)
    @ExceptionHandler(DuplicateKeyException.class)
    public Map<String, ?> handleConflict(DuplicateKeyException exception) {
        Map<String, String> errMap = new HashMap<>();
        System.out.println("Dup Exc: " + exception);
        errMap.put("message", exception.getLocalizedMessage());
        return errMap;
    }

    @ResponseStatus(HttpStatus.CONFLICT)
    @ExceptionHandler(MongoWriteException.class)
    public Map<String, ?> handleWriteException(MongoWriteException exception) {
        Map<String, String> errMap = new HashMap<>();
        System.out.println("Dup Exc: " + exception);
        if(exception.getLocalizedMessage().contains("email")){
        errMap.put("message", "An Account with the same email is already registered");
        } else {
            errMap.put("message", exception.getLocalizedMessage());
        }
        return errMap;
    }

    @ResponseStatus(HttpStatus.FORBIDDEN)
    @ExceptionHandler(ExpiredJwtException.class)
    public Map<String, ?> handleTokenExpiredException(ExpiredJwtException exception) {
        Map<String, String> errMap = new HashMap<>();
            errMap.put("message", exception.getLocalizedMessage());
        return errMap;
    }

    @ResponseStatus(HttpStatus.GATEWAY_TIMEOUT)
    @ExceptionHandler(DataAccessResourceFailureException.class)
    public Map<String, ?> handleTimeoutException(DataAccessResourceFailureException exception) {
        Map<String, String> errMap = new HashMap<>();
        errMap.put("message", exception.getLocalizedMessage());
        return errMap;
    }

    @ResponseStatus(HttpStatus.NOT_FOUND)
    @ExceptionHandler(UsernameNotFoundException.class)
    public Map<String, ?> handleUserNotFoundException(UsernameNotFoundException exception) {
        Map<String, String> errMap = new HashMap<>();
        errMap.put("message", "The email is either taken or is not valid");
        return errMap;
    }
}
