package com.yaseendev.ecommerce.models;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.springframework.data.annotation.Id;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class CartItem {
//    @Id
//    private String id;
    private Product product;
    private int quantity;

    @Override
    public boolean equals(Object o) {

        // If the object is compared with itself then return true
        if (o == this) {
            return true;
        }

        /* Check if o is an instance of CartItem or not
          "null instanceof [type]" also returns false */
        if (!(o instanceof CartItem)) {
            return false;
        }

        // typecast o to CartItem so that we can compare data members
        CartItem c = (CartItem) o;

        // Compare the data members and return accordingly
        return ((CartItem) o).product.getId().equals(this.product.getId());
    }
}

