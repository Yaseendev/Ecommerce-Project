package com.yaseendev.ecommerce.models;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.springframework.data.annotation.Id;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class Address {
    private GeoLocation position;
    private String city;
    private String street;
    private String blockNumber;
    private String floorNumber;
    private String phone;
    private String buildingName;
    private String apartmentNumber;
    private String additionalInfo;
    private String label;
}

