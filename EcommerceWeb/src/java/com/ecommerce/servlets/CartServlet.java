package com.ecommerce.servlets;

import com.ecommerce.dao.CartDAO;
import com.ecommerce.dao.ProductDAO;
import com.ecommerce.model.CartItem;
import com.ecommerce.model.Product;
import java.io.IOException;
import java.math.BigDecimal;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class CartServlet extends HttpServlet {
    private CartDAO cartDAO;
    private ProductDAO productDAO;
    
    @Override
    public void init() throws ServletException {
        cartDAO = new CartDAO();
        productDAO = new ProductDAO();
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        Integer userId = (Integer) session.getAttribute("userId");
        
        if (userId == null) {
            response.sendRedirect("login");
            return;
        }
        
        List<CartItem> cartItems = cartDAO.getCartItems(userId);
        BigDecimal total = BigDecimal.ZERO;
        
        for (CartItem item : cartItems) {
            total = total.add(item.getSubtotal());
        }
        
        request.setAttribute("cartItems", cartItems);
        request.setAttribute("total", total);
        request.getRequestDispatcher("cart.jsp").forward(request, response);
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        Integer userId = (Integer) session.getAttribute("userId");
        
        if (userId == null) {
            response.sendRedirect("login");
            return;
        }
        
        String action = request.getParameter("action");
        
        if ("add".equals(action)) {
            addToCart(request, response, userId);
        } else if ("remove".equals(action)) {
            removeFromCart(request, response, userId);
        } else if ("clear".equals(action)) {
            clearCart(request, response, userId);
        } else {
            response.sendRedirect("cart");
        }
    }
    
    private void addToCart(HttpServletRequest request, HttpServletResponse response, int userId)
            throws ServletException, IOException {
        
        try {
            int productId = Integer.parseInt(request.getParameter("productId"));
            int quantity = Integer.parseInt(request.getParameter("quantity"));
            
            if (quantity <= 0) {
                request.setAttribute("error", "Invalid quantity");
                response.sendRedirect("products");
                return;
            }
            
            // Check if product exists and has enough stock
            Product product = productDAO.getProductById(productId);
            if (product == null) {
                request.setAttribute("error", "Product not found");
                response.sendRedirect("products");
                return;
            }
            
            if (product.getStock() < quantity) {
                request.setAttribute("error", "Not enough stock available");
                response.sendRedirect("products");
                return;
            }
            
            CartItem cartItem = new CartItem(userId, productId, quantity);
            
            if (cartDAO.addToCart(cartItem)) {
                request.setAttribute("success", "Product added to cart");
            } else {
                request.setAttribute("error", "Failed to add product to cart");
            }
            
        } catch (NumberFormatException e) {
            request.setAttribute("error", "Invalid product or quantity");
        }
        
        response.sendRedirect("products");
    }
    
    private void removeFromCart(HttpServletRequest request, HttpServletResponse response, int userId)
            throws ServletException, IOException {
        
        try {
            int productId = Integer.parseInt(request.getParameter("productId"));
            
            if (cartDAO.removeFromCart(userId, productId)) {
                request.setAttribute("success", "Product removed from cart");
            } else {
                request.setAttribute("error", "Failed to remove product from cart");
            }
            
        } catch (NumberFormatException e) {
            request.setAttribute("error", "Invalid product");
        }
        
        response.sendRedirect("cart");
    }
    
    private void clearCart(HttpServletRequest request, HttpServletResponse response, int userId)
            throws ServletException, IOException {
        
        if (cartDAO.clearCart(userId)) {
            request.setAttribute("success", "Cart cleared");
        } else {
            request.setAttribute("error", "Failed to clear cart");
        }
        
        response.sendRedirect("cart");
    }
}