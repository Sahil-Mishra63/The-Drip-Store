package com.ecommerce.servlets;

import com.ecommerce.dao.CartDAO;
import com.ecommerce.dao.OrderDAO;
import com.ecommerce.dao.ProductDAO;
import com.ecommerce.model.CartItem;
import com.ecommerce.model.Order;
import com.ecommerce.model.OrderItem;
import java.io.IOException;
import java.math.BigDecimal;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class OrderServlet extends HttpServlet {
    private OrderDAO orderDAO;
    private CartDAO cartDAO;
    private ProductDAO productDAO;
    
    @Override
    public void init() throws ServletException {
        orderDAO = new OrderDAO();
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
        
        String action = request.getParameter("action");
        
        if ("checkout".equals(action)) {
            // Show checkout page
            List<CartItem> cartItems = cartDAO.getCartItems(userId);
            
            if (cartItems.isEmpty()) {
                request.setAttribute("error", "Your cart is empty");
                response.sendRedirect("cart");
                return;
            }
            
            BigDecimal total = BigDecimal.ZERO;
            for (CartItem item : cartItems) {
                total = total.add(item.getSubtotal());
            }
            
            request.setAttribute("cartItems", cartItems);
            request.setAttribute("total", total);
            request.getRequestDispatcher("checkout.jsp").forward(request, response);
            
        } else if ("history".equals(action)) {
            // Show order history
            List<Order> orders = orderDAO.getOrdersByUserId(userId);
            request.setAttribute("orders", orders);
            request.getRequestDispatcher("order-history.jsp").forward(request, response);
            
        } else {
            response.sendRedirect("products");
        }
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
        
        if ("place".equals(action)) {
            placeOrder(request, response, userId);
        } else {
            response.sendRedirect("products");
        }
    }
    
    private void placeOrder(HttpServletRequest request, HttpServletResponse response, int userId)
            throws ServletException, IOException {
        
        String shippingAddress = request.getParameter("shippingAddress");
        
        if (shippingAddress == null || shippingAddress.trim().isEmpty()) {
            request.setAttribute("error", "Shipping address is required");
            request.getRequestDispatcher("checkout.jsp").forward(request, response);
            return;
        }
        
        // Get cart items
        List<CartItem> cartItems = cartDAO.getCartItems(userId);
        
        if (cartItems.isEmpty()) {
            request.setAttribute("error", "Your cart is empty");
            response.sendRedirect("cart");
            return;
        }
        
        // Calculate total
        BigDecimal total = BigDecimal.ZERO;
        for (CartItem item : cartItems) {
            total = total.add(item.getSubtotal());
        }
        
        // Create order
        Order order = new Order(userId, total, "pending", shippingAddress);
        int orderId = orderDAO.createOrder(order);
        
        if (orderId > 0) {
            // Add order items and update stock
            boolean success = true;
            
            for (CartItem cartItem : cartItems) {
                OrderItem orderItem = new OrderItem(orderId, cartItem.getProductId(), 
                                                  cartItem.getQuantity(), cartItem.getProduct().getPrice());
                
                if (!orderDAO.addOrderItem(orderItem)) {
                    success = false;
                    break;
                }
                
                // Update product stock
                int newStock = cartItem.getProduct().getStock() - cartItem.getQuantity();
                if (!productDAO.updateStock(cartItem.getProductId(), newStock)) {
                    success = false;
                    break;
                }
            }
            
            if (success) {
                // Clear cart
                cartDAO.clearCart(userId);
                
                request.setAttribute("success", "Order placed successfully! Order ID: " + orderId);
                request.setAttribute("orderId", orderId);
                request.getRequestDispatcher("order-success.jsp").forward(request, response);
            } else {
                request.setAttribute("error", "Failed to process order. Please try again.");
                request.getRequestDispatcher("checkout.jsp").forward(request, response);
            }
        } else {
            request.setAttribute("error", "Failed to create order. Please try again.");
            request.getRequestDispatcher("checkout.jsp").forward(request, response);
        }
    }
}