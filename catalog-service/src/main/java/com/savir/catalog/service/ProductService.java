package com.savir.catalog.service;

import com.savir.catalog.model.Product;
import com.savir.catalog.repository.ProductRepository;
import org.springframework.stereotype.Service;
import java.util.List;
import java.util.Optional;

@Service
public class ProductService {
    private final ProductRepository productRepository;

    public ProductService(ProductRepository productRepository) {
        this.productRepository = productRepository;
    }

    public List<Product> findAll() { return productRepository.findAll(); }
    public Optional<Product> findById(String id) { return productRepository.findById(id); }
    private void validate(Product product) {
        if (product.getPrice() == null || product.getPrice() <= 0) throw new RuntimeException("O preço não pode ser zero ou negativo.");
        if (product.getStock() == null || product.getStock() <= 0) throw new RuntimeException("O estoque não pode ser zero ou negativo.");
    }

    public Product create(Product product) {
        validate(product);
        return productRepository.save(product);
    }

    public Product update(String id, Product updated) {
        validate(updated);
        return productRepository.findById(id).map(p -> {
            p.setName(updated.getName());
            p.setDescription(updated.getDescription());
            p.setPrice(updated.getPrice());
            p.setStock(updated.getStock());
            return productRepository.save(p);
        }).orElseThrow(() -> new RuntimeException("Produto não encontrado: " + id));
    }

    public void delete(String id) {
        if (!productRepository.existsById(id)) throw new RuntimeException("Produto não encontrado");
        productRepository.deleteById(id);
    }
}
