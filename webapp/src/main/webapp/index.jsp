<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>E-Commerce Website</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            text-align: center;
        }
        .categories {
            margin: 20px;
        }
        .category-btn {
            padding: 10px 20px;
            margin: 5px;
            border: none;
            background-color: #007BFF;
            color: white;
            cursor: pointer;
        }
        .category-btn:hover {
            background-color: #0056b3;
        }
        .products {
            display: flex;
            flex-wrap: wrap;
            justify-content: center;
        }
        .product {
            display: none;
            border: 1px solid #ddd;
            margin: 10px;
            padding: 10px;
            width: 200px;
        }
        .show {
            display: block;
        }
    </style>
</head>
<body>
    <h1>E-Commerce Store</h1>
    
    <div class="categories">
        <button class="category-btn" onclick="filterProducts('all')">All</button>
        <button class="category-btn" onclick="filterProducts('electronics')">Electronics</button>
        <button class="category-btn" onclick="filterProducts('clothing')">Clothing</button>
        <button class="category-btn" onclick="filterProducts('home')">Home</button>
    </div>
    
    <div class="products">
        <div class="product electronics show">Smartphone</div>
        <div class="product electronics show">Laptop</div>
        <div class="product clothing show">T-Shirt</div>
        <div class="product clothing show">Jeans</div>
        <div class="product home show">Sofa</div>
        <div class="product home show">Table Lamp</div>
    </div>

    <script>
        function filterProducts(category) {
            let products = document.querySelectorAll('.product');
            products.forEach(product => {
                product.classList.remove('show');
                if (category === 'all' || product.classList.contains(category)) {
                    product.classList.add('show');
                }
            });
        }
    </script>
</body>
</html>
