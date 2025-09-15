<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.ecommerce.model.Product" %>
<!DOCTYPE html>
<html>
<head>
    <title>Product Detail</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #fafafa;
            margin: 20px;
        }
        .product-container {
            display: flex;
            max-width: 900px;
            margin: auto;
            background: #fff;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 3px 12px rgba(0,0,0,0.1);
        }
        .product-image img {
            max-width: 100%;
            border-radius: 8px;
        }
        .product-info {
            padding-left: 20px;
        }
        .price {
            font-size: 24px;
            color: #e91e63;
            margin: 10px 0;
        }
        .buttons button {
            background-color: #28a745;
            color: white;
            border: none;
            padding: 10px 18px;
            margin-right: 10px;
            border-radius: 5px;
            cursor: pointer;
        }
        .buttons button:hover {
            background-color: #218838;
        }
        .reviews {
            margin-top: 30px;
        }
        .review {
            background: #f8f9fa;
            padding: 10px;
            border-radius: 5px;
            margin-bottom: 10px;
        }
        .review .rating {
            color: #ffc107;
            font-weight: bold;
        }
    </style>
</head>
<body>

<%
    Product product = (Product) request.getAttribute("product");
    if (product != null) {
%>

<div class="product-container">
    <div class="product-image">
        <img src="<%= product.getImageUrl() %>" alt="<%= product.getName() %>">
    </div>
    <div class="product-info">
        <h1><%= product.getName() %></h1>
        <div class="price">₹<%= product.getPrice() %></div>
        <p><b>Category:</b> <%= product.getCategory() %></p>
        <p><b>Description:</b><br><%= product.getDescription() %></p>
        <p><b>Stock Available:</b> <%= product.getStock() %></p>

        <div class="buttons">
            <button>Add to Cart</button>
            <button>Buy Now</button>
        </div>

        <div class="reviews">
            <h2>Customer Reviews</h2>

            <div class="review">
                <p><b>Rudra Narayan Sahu</b></p>
                <p class="rating">⭐⭐⭐⭐☆</p>
                <p>Guru, ki baneicho guru, masttt</p>
            </div>

            <div class="review">
                <p><b>Divya</b></p>
                <p class="rating">⭐⭐⭐⭐⭐</p>
                <p>Excellent quality and exactly as described.</p>
            </div>

            <div class="review">
                <p><b>Mike Tyson</b></p>
                <p class="rating">⭐⭐⭐☆☆</p>
                <p>Good product but delivery took longer than expected.</p>
            </div>
        </div>
    </div>
</div>

<% } else { %>
    <h2 style="text-align:center; color:red;">Product not found.</h2>
<% } %>

</body>
</html>
