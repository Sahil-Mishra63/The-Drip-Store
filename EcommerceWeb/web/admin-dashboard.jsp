<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Dashboard - E-Commerce Store</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
    <div class="container-fluid">
        <!-- Header -->
        <nav class="navbar navbar-expand-lg navbar-dark bg-dark">
            <div class="container">
                <a class="navbar-brand" href="admin">Admin Panel</a>
                <div class="navbar-nav ms-auto">
                    <a class="nav-link" href="products">View Store</a>
                    <span class="navbar-text">Welcome, <%= session.getAttribute("username") %>!</span>
                    <a class="nav-link" href="logout">Logout</a>
                </div>
            </div>
        </nav>

        <div class="container-fluid">
            <div class="row">
                <!-- Sidebar -->
                <div class="col-md-2 bg-light vh-100">
                    <div class="list-group list-group-flush mt-3">
                        <a href="admin" class="list-group-item list-group-item-action active">Dashboard</a>
                        <a href="admin?action=products" class="list-group-item list-group-item-action">Products</a>
                        <a href="admin?action=orders" class="list-group-item list-group-item-action">Orders</a>
                        <a href="admin?action=users" class="list-group-item list-group-item-action">Users</a>
                    </div>
                </div>

                <!-- Main Content -->
                <div class="col-md-10">
                    <div class="container mt-4">
                        <h2>Admin Dashboard</h2>
                        
                        <div class="row mt-4">
                            <div class="col-md-4">
                                <div class="card text-white bg-primary">
                                    <div class="card-body">
                                        <div class="d-flex justify-content-between">
                                            <div>
                                                <h4>Products</h4>
                                                <h2><%= request.getAttribute("productCount") %></h2>
                                            </div>
                                            <div class="align-self-center">
                                                <i class="fas fa-box fa-3x"></i>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="card-footer">
                                        <a href="admin?action=products" class="text-white">View Details</a>
                                    </div>
                                </div>
                            </div>
                            
                            <div class="col-md-4">
                                <div class="card text-white bg-success">
                                    <div class="card-body">
                                        <div class="d-flex justify-content-between">
                                            <div>
                                                <h4>Orders</h4>
                                                <h2><%= request.getAttribute("orderCount") %></h2>
                                            </div>
                                            <div class="align-self-center">
                                                <i class="fas fa-shopping-cart fa-3x"></i>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="card-footer">
                                        <a href="admin?action=orders" class="text-white">View Details</a>
                                    </div>
                                </div>
                            </div>
                            
                            <div class="col-md-4">
                                <div class="card text-white bg-info">
                                    <div class="card-body">
                                        <div class="d-flex justify-content-between">
                                            <div>
                                                <h4>Users</h4>
                                                <h2><%= request.getAttribute("userCount") %></h2>
                                            </div>
                                            <div class="align-self-center">
                                                <i class="fas fa-users fa-3x"></i>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="card-footer">
                                        <a href="admin?action=users" class="text-white">View Details</a>
                                    </div>
                                </div>
                            </div>
                        </div>
                        
                        <div class="row mt-4">
                            <div class="col-md-12">
                                <div class="card">
                                    <div class="card-header">
                                        <h5>Quick Actions</h5>
                                    </div>
                                    <div class="card-body">
                                        <a href="admin?action=addProduct" class="btn btn-primary me-2">Add New Product</a>
                                        <a href="admin?action=products" class="btn btn-outline-primary me-2">Manage Products</a>
                                        <a href="admin?action=orders" class="btn btn-outline-success">Manage Orders</a>
                                    </div>
                                </div>
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