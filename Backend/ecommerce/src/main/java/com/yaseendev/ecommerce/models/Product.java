package com.yaseendev.ecommerce.models;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.springframework.data.annotation.Id;
import org.springframework.data.mongodb.core.mapping.Document;

import java.math.BigDecimal;
import java.util.List;

@Document
@Data
@NoArgsConstructor
@AllArgsConstructor
public class Product {
    @Id
    private String id;
    private String title;
    private String description;
    private BigDecimal price;
    private BigDecimal  discountPercentage;
    private double rating;
    private int stock;
    private String brand;
    private Category category;
    private String thumbnail;
    private List<String> images;
    private BigDecimal finalPrice;

    public void setFinalPrice(BigDecimal finalPrice) {
        this.finalPrice = discountPercentage != null ? BigDecimal.valueOf(price.doubleValue() - (price.doubleValue() * (discountPercentage.doubleValue() / 100))) : price;
    }

    public BigDecimal getFinalPrice() {
        return discountPercentage != null ? BigDecimal.valueOf(price.doubleValue() - (price.doubleValue() * (discountPercentage.doubleValue() / 100))) : price;
    }

    public double getPrice() {
        return price.doubleValue();
    }
}
