<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="com.ecommerce.model.Order" %>
<%@ page import="com.ecommerce.model.OrderItem" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Order History - E-Commerce Store</title>
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

        <!-- Order History Content -->
        <div class="container mt-4">
            <h2>Order History</h2>

            <%
                List<Order> orders = (List<Order>) request.getAttribute("orders");
                if (orders != null && !orders.isEmpty()) {
            %>
                <% for (Order order : orders) { %>
                    <div class="card mb-4">
                        <div class="card-header">
                            <div class="row">
                                <div class="col-md-3">
                                    <strong>Order #<%= order.getOrderId() %></strong>
                                </div>
                                <div class="col-md-3">
                                    <span>Date: <%= order.getOrderDate() %></span>
                                </div>
                                <div class="col-md-3">
                                    <span>Status: 
                                        <span class="badge 
                                            <% if ("pending".equals(order.getStatus())) { %>
                                                bg-warning
                                            <% } else if ("shipped".equals(order.getStatus())) { %>
                                                bg-info
                                            <% } else if ("delivered".equals(order.getStatus())) { %>
                                                bg-success
                                            <% } else { %>
                                                bg-secondary
                                            <% } %>
                                        "><%= order.getStatus().toUpperCase() %></span>
                                    </span>
                                </div>
                                <div class="col-md-3">
                                    <strong>Total: ₹<%= order.getTotalAmount() %></strong>
                                </div>
                            </div>
                        </div>
                        <div class="card-body">
                            <h6>Items:</h6>
                            <% if (order.getOrderItems() != null) { %>
                                <% for (OrderItem item : order.getOrderItems()) { %>
                                    <div class="row mb-2">
                                        <div class="col-md-6">
                                            <%= item.getProduct().getName() %>
                                        </div>
                                        <div class="col-md-2">
                                            Qty: <%= item.getQuantity() %>
                                        </div>
                                        <div class="col-md-2">
                                            Price: ₹<%= item.getPrice() %>
                                        </div>
                                        <div class="col-md-2">
                                            Subtotal: ₹<%= item.getSubtotal() %>
                                        </div>
                                    </div>
                                <% } %>
                            <% } %>
                            <hr>
                            <p><strong>Shipping Address:</strong> <%= order.getShippingAddress() %></p>
                        </div>
                    </div>
                <% } %>
            <%
                } else {
            %>
                <div class="alert alert-info">
                    You haven't placed any orders yet. <a href="products">Start shopping</a>
                </div>
            <%
                }
            %>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>