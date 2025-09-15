<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Order Success - E-Commerce Store</title>
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
                    <a class="nav-link" href="order?action=history">Orders</a>
                    <span class="navbar-text">Welcome, <%= session.getAttribute("username") %>!</span>
                    <a class="nav-link" href="logout">Logout</a>
                </div>
            </div>
        </nav>

        <!-- Success Content -->
        <div class="container mt-5">
            <div class="row justify-content-center">
                <div class="col-md-6">
                    <div class="card">
                        <div class="card-body text-center">
                            <div class="mb-4">
                                <i class="fas fa-check-circle text-success" style="font-size: 4rem;"></i>
                            </div>
                            <h2 class="text-success">Order Placed Successfully!</h2>
                            
                            <% if (request.getAttribute("success") != null) { %>
                                <div class="alert alert-success">
                                    <%= request.getAttribute("success") %>
                                </div>
                            <% } %>
                            
                            <% if (request.getAttribute("orderId") != null) { %>
                                <p class="lead">Your Order ID: <strong>#<%= request.getAttribute("orderId") %></strong></p>
                            <% } %>
                            
                            <p>Thank you for your purchase! You will receive an email confirmation shortly.</p>
                            
                            <div class="mt-4">
                                <a href="products" class="btn btn-primary me-2">Continue Shopping</a>
                                <a href="order?action=history" class="btn btn-outline-secondary">View Orders</a>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
    <script src="https://kit.fontawesome.com/your-fontawesome-kit.js"></script>
</body>
</html>