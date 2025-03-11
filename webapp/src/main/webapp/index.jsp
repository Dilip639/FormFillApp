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
            background: url('https://source.unsplash.com/1600x900/?shopping,mall') no-repeat center center/cover;
            color: white;
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
            text-align: center;
        }
        .product img {
            width: 100px;
            height: 100px;
            object-fit: cover;
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
        <div class="product electronics show">
            <img src="https://i.postimg.cc/t48666jY/mini-smartphone-android-7.webp" alt="Smartphone">
            <p>Smartphone</p>
        </div>
        <div class="product electronics show">
            <img src="https://via.placeholder.com/100" alt="Laptop">
            <p>Laptop</p>
        </div>
        <div class="product clothing show">
            <img src="https://via.placeholder.com/100" alt="T-Shirt">
            <p>T-Shirt</p>
        </div>
        <div class="product clothing show">
            <img src="https://via.placeholder.com/100" alt="Jeans">
            <p>Jeans</p>
        </div>
        <div class="product home show">
            <img src="https://via.placeholder.com/100" alt="Sofa">
            <p>Sofa</p>
        </div>
        <div class="product home show">
            <img src="https://via.placeholder.com/100" alt="Table Lamp">
            <p>Table Lamp</p>
        </div>
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
