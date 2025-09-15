package com.ecommerce.servlets;

import com.ecommerce.dao.ProductDAO;
import com.ecommerce.model.Product;
import java.io.IOException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class ProductServlet extends HttpServlet {
    private ProductDAO productDAO;
    
    @Override
    public void init() throws ServletException {
        productDAO = new ProductDAO();
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String action = request.getParameter("action");
        String category = request.getParameter("category");
        String productId = request.getParameter("id");
        
        if ("view".equals(action) && productId != null) {
            // View single product
            try {
                int id = Integer.parseInt(productId);
                Product product = productDAO.getProductById(id);
                
                if (product != null) {
                    request.setAttribute("product", product);
                    request.getRequestDispatcher("product-detail.jsp").forward(request, response);
                } else {
                    response.sendRedirect("products");
                }
            } catch (NumberFormatException e) {
                response.sendRedirect("products");
            }
        } else {
            // List products
            List<Product> products;
            
            if (category != null && !category.trim().isEmpty()) {
                products = productDAO.getProductsByCategory(category);
                request.setAttribute("selectedCategory", category);
            } else {
                products = productDAO.getAllProducts();
            }
            
            request.setAttribute("products", products);
            request.getRequestDispatcher("products.jsp").forward(request, response);
        }
    }
}