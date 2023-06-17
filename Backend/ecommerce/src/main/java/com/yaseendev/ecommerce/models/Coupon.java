package com.yaseendev.ecommerce.models;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.springframework.data.annotation.Id;
import org.springframework.data.mongodb.core.index.Indexed;
import org.springframework.data.mongodb.core.mapping.Document;

import java.math.BigDecimal;

@Document
@Data
@NoArgsConstructor
@AllArgsConstructor
public class Coupon {
        @Id
        private String id;
        private String name;

        @Indexed(unique = true)
        private String code;
        private BigDecimal value;
        private Boolean valid = true;
}
