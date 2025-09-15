<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="com.ecommerce.model.Product" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Products - E-Commerce Store</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
    <div class="container-fluid">
        <!-- Header -->
        <nav class="navbar navbar-expand-lg navbar-dark bg-dark">
            <div class="container">
                <a class="navbar-brand" href="index.jsp">The Drip Store</a>
                <div class="navbar-nav ms-auto">
                    <% if (session.getAttribute("user") != null) { %>
                        <a class="nav-link" href="cart">Cart</a>
                        <a class="nav-link" href="order?action=history">Orders</a>
                        <span class="navbar-text">Welcome, <%= session.getAttribute("username") %>!</span>
                        <a class="nav-link" href="logout">Logout</a>
                    <% } else { %>
                        <a class="nav-link" href="login">Login</a>
                        <a class="nav-link" href="register">Register</a>
                    <% } %>
                </div>
            </div>
        </nav>

        <!-- Products Section -->
        <div class="container mt-4">
            <div class="row">
                <!-- Sidebar -->
                <div class="col-md-3">
                    <div class="card">
                        <div class="card-header">
                            <h5>Categories</h5>
                        </div>
                        <div class="card-body">
                            <div class="list-group">
                                <a href="products" class="list-group-item list-group-item-action">All Products</a>
                                <a href="products?category=Electronics" class="list-group-item list-group-item-action">Electronics</a>
                                <a href="products?category=Clothing" class="list-group-item list-group-item-action">Clothing</a>
                                <a href="products?category=Books" class="list-group-item list-group-item-action">Books</a>
                                <a href="products?category=Home" class="list-group-item list-group-item-action">Home & Garden</a>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Products Grid -->
                <div class="col-md-9">
                    <% if (request.getAttribute("error") != null) { %>
                        <div class="alert alert-danger">
                            <%= request.getAttribute("error") %>
                        </div>
                    <% } %>
                    
                    <% if (request.getAttribute("success") != null) { %>
                        <div class="alert alert-success">
                            <%= request.getAttribute("success") %>
                        </div>
                    <% } %>

                    <h2>Products
                        <% if (request.getAttribute("selectedCategory") != null) { %>
                            - <%= request.getAttribute("selectedCategory") %>
                        <% } %>
                    </h2>

                    <div class="row">
                        <%
                            List<Product> products = (List<Product>) request.getAttribute("products");
                            if (products != null && !products.isEmpty()) {
                                for (Product product : products) {
                        %>
                            <div class="col-md-4 mb-4">
                                <div class="card h-100">
                                    <% if (product.getImageUrl() != null && !product.getImageUrl().isEmpty()) { %>
                                        <img src="<%= product.getImageUrl() %>" class="card-img-top" alt="<%= product.getName() %>" style="height: 200px; object-fit: cover;">
                                    <% } else { %>
                                        <div class="card-img-top bg-light d-flex align-items-center justify-content-center" style="height: 200px;">
                                            <span class="text-muted">No Image</span>
                                        </div>
                                    <% } %>
                                    <div class="card-body d-flex flex-column">
                                        <h5 class="card-title"><%= product.getName() %></h5>
                                        <p class="card-text"><%= product.getDescription() %></p>
                                        <p class="card-text"><strong>Price: ₹<%= product.getPrice() %></strong></p>
                                        <p class="card-text"><small class="text-muted">Stock: <%= product.getStock() %></small></p>
                                        <div class="mt-auto">
                                            <% if (session.getAttribute("user") != null) { %>
                                                <form method="post" action="cart" class="d-inline">
                                                    <input type="hidden" name="action" value="add">
                                                    <input type="hidden" name="productId" value="<%= product.getProductId() %>">
                                                    <div class="input-group mb-2">
                                                        <input type="number" name="quantity" value="1" min="1" max="<%= product.getStock() %>" class="form-control" style="max-width: 80px;">
                                                        <button type="submit" class="btn btn-primary">Add to Cart</button>
                                                    </div>
                                                </form>
                                            <% } else { %>
                                                <a href="login" class="btn btn-primary">Login to Buy</a>
                                            <% } %>
                                            <a href="products?action=view&id=<%= product.getProductId() %>" class="btn btn-outline-secondary">View Details</a>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        <%
                                }
                            } else {
                        %>
                            <div class="col-12">
                                <div class="alert alert-info">
                                    No products found.
                                </div>
                            </div>
                        <%
                            }
                        %>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>