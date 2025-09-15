<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>E-Commerce Store</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
    <div class="container-fluid">
        <!-- Header -->
        <nav class="navbar navbar-expand-lg navbar-dark bg-dark">
            <div class="container">
                <a class="navbar-brand" href="index.jsp">The Drip Store</a>
                <div class="navbar-nav ms-auto">
                    <a class="nav-link" href="login">Login</a>
                    <a class="nav-link" href="register">Register</a>
                    <a class="nav-link" href="products">Products</a>
                </div>
            </div>
        </nav>

        <!-- Hero Section -->
        <div class="bg-primary text-white text-center py-5">
            <div class="container">
                <h1 class="display-4">Welcome to The Drip Store</h1>
                <p class="lead">Discover amazing products at great prices</p>
                <a href="products" class="btn btn-light btn-lg">Shop Now</a>
            </div>
        </div>

        <!-- Features Section -->
        <div class="container py-5">
            <div class="row">
                <div class="col-md-4 text-center">
                    <div class="card h-100">
                        <div class="card-body">
                            <h5 class="card-title">Quality Products</h5>
                            <p class="card-text">We offer only the highest quality products from trusted brands.</p>
                        </div>
                    </div>
                </div>
                <div class="col-md-4 text-center">
                    <div class="card h-100">
                        <div class="card-body">
                            <h5 class="card-title">Fast Shipping</h5>
                            <p class="card-text">Get your orders delivered quickly with our fast shipping options.</p>
                        </div>
                    </div>
                </div>
                <div class="col-md-4 text-center">
                    <div class="card h-100">
                        <div class="card-body">
                            <h5 class="card-title">24/7 Support</h5>
                            <p class="card-text">Our customer support team is available 24/7 to help you.</p>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- Footer -->
        <footer class="bg-dark text-white text-center py-3">
            <div class="container">
                <p>&copy; 2025 The Drip Store. All rights reserved.</p>
            </div>
        </footer>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>