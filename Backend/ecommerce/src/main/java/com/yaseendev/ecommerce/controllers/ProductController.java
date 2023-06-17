package com.yaseendev.ecommerce.controllers;

import com.mongodb.lang.Nullable;
import com.yaseendev.ecommerce.models.Product;
import com.yaseendev.ecommerce.services.ProductService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.mongodb.core.MongoTemplate;
import org.springframework.data.mongodb.core.query.Criteria;
import org.springframework.data.mongodb.core.query.Query;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.math.BigDecimal;
import java.util.List;

@RestController
@RequestMapping("api/v1/products")
public class ProductController {

    private ProductService productService;
    private MongoTemplate mongoTemplate;

    @Autowired
    public ProductController(ProductService productService, MongoTemplate mongoTemplate) {
        this.productService = productService;
        this.mongoTemplate = mongoTemplate;
    }

    @PostMapping("/add")
    @ResponseStatus(HttpStatus.CREATED)
    public Product addCategory(
            @RequestBody Product product) {
        return productService.add(product);
    }

    @GetMapping
    public Object fetchProducts(
            @RequestParam(required = false) String id
    ) {

        return id == null ? productService.getAllProducts()
                : productService.getProduct(id);
    }

    @GetMapping("/search")
    @ResponseBody
    public List<Product> searchProducts(
            @RequestParam(required = true) String term
    ) {
        final Query query = new Query();
        query.addCriteria(Criteria.where("title").regex(term,"i"));
        return mongoTemplate.find(query, Product.class);
    }

    @GetMapping("/{categoryId}")
    @ResponseBody
    public List<Product> getCategoryProducts(
            @PathVariable(required = true) String categoryId
    ) {
        return productService.getCategoryProducts(categoryId);
    }

    @GetMapping("/deal-of-day")
    @ResponseBody
    public Product getDealOfDay() {
        return productService.getDealOfDay();
    }

    @GetMapping("/most-popular")
    @ResponseBody
    public List<Product> getMostPopularProducts() {

        return productService.getMostPopular();
    }

    @GetMapping("/most-rated")
    @ResponseBody
    public List<Product> getMostRatedProducts() {

        return productService.getMostRated();
    }

    @GetMapping("/newly-added")
    @ResponseBody
    public List<Product> getNewlyAddedProducts() {
        return productService.getNewProducts();
    }

    @GetMapping("/search-filtered")
    @ResponseBody
    public List<Product> searchProductsFiltered(
            @RequestParam(required = true) String term,
            @RequestParam(required = false) List<String> categoryIds,
            @RequestParam(required = false) BigDecimal startPrice,
            @RequestParam(required = false) BigDecimal endPrice,
            @RequestParam(required = false) @Nullable Double startRating,
            @Nullable @RequestParam(required = false) Double endRating,
            @RequestParam(required = false, defaultValue = "most_relv") String sort,
            @RequestParam(required = false) List<String> brands
    ) {
        System.out.println("Brands: " + brands);
        //List.of(term, categoryIds);
        return productService.searchProducts(term, categoryIds,startPrice,endPrice, startRating, endRating, sort, brands);
    }

    @GetMapping("/ads")
    @ResponseBody
    public ResponseEntity<List<String>> getAds() {

        return ResponseEntity.ok(List.of(
                "https://images.news18.com/ibnlive/uploads/2019/08/realme-5-series.jpg",
                "https://mybroadband.co.za/news/wp-content/uploads/2014/09/iPhone-6-and-iPhone-6-Plus-press-shot.jpg",
                "https://s3.amazonaws.com/media.mediapost.com/dam/cropped/2019/12/06/screenshot-2019-12-05-at-23107-pm_kKdoMd4.png",
                "https://queue-it.com/media/ppcp1twv/product-drop.jpg",
                "https://m.media-amazon.com/images/G/31/selldot/Images/WebpImages/BannerImage-PopularcategoriestoSellOnline.webp"
                ));
    }

    @GetMapping("/brands")
    @ResponseBody
    public Object getProductsBrands() {
        return productService.getAllProductsBrands();
    }

}
