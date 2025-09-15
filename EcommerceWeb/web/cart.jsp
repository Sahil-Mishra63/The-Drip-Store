<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="java.math.BigDecimal" %>
<%@ page import="com.ecommerce.model.CartItem" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Checkout - E-Commerce Store</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
    <div class="container-fluid">
        <!-- Header -->
        <nav class="navbar navbar-expand-lg navbar-dark bg-dark">
            <div class="container">
                <a class="navbar-brand" href="index.jsp">The Drip Store</a>
                <div class="navbar-nav ms-auto">
                    <a class="nav-link" href="products">Products</a>
                    <a class="nav-link" href="cart">Cart</a>
                    <span class="navbar-text">Welcome, <%= session.getAttribute("username") %>!</span>
                    <a class="nav-link" href="logout">Logout</a>
                </div>
            </div>
        </nav>

        <!-- Checkout Content -->
        <div class="container mt-4">
            <h2>Checkout</h2>
            
            <% if (request.getAttribute("error") != null) { %>
                <div class="alert alert-danger">
                    <%= request.getAttribute("error") %>
                </div>
            <% } %>

            <%
                List<CartItem> cartItems = (List<CartItem>) request.getAttribute("cartItems");
                BigDecimal total = (BigDecimal) request.getAttribute("total");
            %>

            <div class="row">
                <div class="col-md-8">
                    <div class="card">
                        <div class="card-header">
                            <h5>Shipping Information</h5>
                        </div>
                        <div class="card-body">
                            <form method="post" action="order">
                                <input type="hidden" name="action" value="place">
                                
                                <div class="mb-3">
                                    <label for="shippingAddress" class="form-label">Shipping Address *</label>
                                    <textarea class="form-control" id="shippingAddress" name="shippingAddress" rows="4" required></textarea>
                                </div>
                                
                                <div class="d-grid">
                                    <button type="submit" class="btn btn-success btn-lg">Place Order</button>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
                
                <div class="col-md-4">
                    <div class="card">
                        <div class="card-header">
                            <h5>Order Summary</h5>
                        </div>
                        <div class="card-body">
                            <% if (cartItems != null) { %>
                                <% for (CartItem item : cartItems) { %>
                                    <div class="d-flex justify-content-between mb-2">
                                        <span><%= item.getProduct().getName() %> x <%= item.getQuantity() %></span>
                                        <span>₹<%= item.getSubtotal() %></span>
                                    </div>
                                <% } %>
                                <hr>
                                <div class="d-flex justify-content-between">
                                    <strong>Total:</strong>
                                    <strong>₹<%= total %></strong>
                                </div>
                            <% } %>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>