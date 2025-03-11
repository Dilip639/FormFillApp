<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>E-Commerce Website</title>
    <style>
        body {
            font-family: 'Poppins', sans-serif;
            text-align: center;
            background: linear-gradient(to right, #ff7e5f, #feb47b);
            color: white;
            margin: 0;
            padding: 0;
        }
        h1 {
            margin-top: 20px;
        }
        .categories {
            margin: 20px;
        }
        .category-btn {
            padding: 12px 24px;
            margin: 8px;
            border: none;
            background-color: #0066FF;
            color: white;
            font-size: 16px;
            cursor: pointer;
            border-radius: 5px;
            transition: background 0.3s, transform 0.2s;
        }
        .category-btn:hover {
            background-color: #e68900;
            transform: scale(1.1);
        }
        .products {
            display: flex;
            flex-wrap: wrap;
            justify-content: center;
            padding: 20px;
        }
        .product {
            display: none;
            border-radius: 10px;
            margin: 15px;
            padding: 15px;
            width: 250px;
            text-align: center;
            background: white;
            color: black;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.2);
            transition: transform 0.3s;
            position: relative;
        }
        .product:hover {
            transform: scale(1.05);
        }
        .product img {
            width: 120px;
            height: 120px;
            object-fit: cover;
            border-radius: 8px;
        }
        .add-to-cart {
            margin-top: 10px;
            padding: 8px 16px;
            border: none;
            background-color: #28a745;
            color: white;
            cursor: pointer;
            border-radius: 5px;
            transition: background 0.3s;
        }
        .add-to-cart:hover {
            background-color: #218838;
        }
        .cart {
            margin-top: 20px;
            padding: 20px;
            background: white;
            color: black;
            border-radius: 10px;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.2);
            display: inline-block;
        }
        .show {
            display: block;
        }
    </style>
</head>
<body>
    <h1>Welcome to Our E-Commerce Store</h1>
    
    <div class="categories">
        <button class="category-btn" onclick="filterProducts('all')">All</button>
        <button class="category-btn" onclick="filterProducts('electronics')">Electronics</button>
        <button class="category-btn" onclick="filterProducts('clothing')">Clothing</button>
        <button class="category-btn" onclick="filterProducts('home')">Home</button>
    </div>
    
    <div class="products">
        <div class="product electronics show">
            <img src="https://i.postimg.cc/t48666jY/mini-smartphone-android-7.webp" alt="Smartphone">
            <p>Smartphone - $699</p>
            <button class="add-to-cart" onclick="addToCart('Smartphone', 699)">Add to Cart</button>
        </div>
        <div class="product electronics show">
            <img src="https://i.postimg.cc/zDhSx1NP/4-65e28377-a245-4b2d-b59a-9a4d1d88d331.jpg" alt="Laptop">
            <p>Laptop - $999</p>
            <button class="add-to-cart" onclick="addToCart('Laptop', 999)">Add to Cart</button>
        </div>
        <div class="product clothing show">
            <img src="https://i.postimg.cc/d1wk6gjg/fashion-journal-buying-new-clothes-mob.jpg" alt="T-Shirt">
            <p>T-Shirt - $25</p>
            <button class="add-to-cart" onclick="addToCart('T-Shirt', 25)">Add to Cart</button>
        </div>
        <div class="product clothing show">
            <img src="https://i.postimg.cc/tCNXt7MR/compress-0421-cpdnm-azure-1.jpg" alt="Jeans">
            <p>Jeans - $50</p>
            <button class="add-to-cart" onclick="addToCart('Jeans', 50)">Add to Cart</button>
        </div>
        <div class="product home show">
            <img src="https://i.postimg.cc/MT24FmnC/Gallery-1-Chiyo-L-Shaped-Sofa-Buy-Online.jpg" alt="Sofa">
            <p>Sofa - $499</p>
            <button class="add-to-cart" onclick="addToCart('Sofa', 499)">Add to Cart</button>
        </div>
        <div class="product home show">
            <img src="https://i.postimg.cc/zXsnWt4Y/tl73-10003-3.jpg" alt="Table Lamp">
            <p>Table Lamp - $30</p>
            <button class="add-to-cart" onclick="addToCart('Table Lamp', 30)">Add to Cart</button>
        </div>
    </div>

    <div class="cart">
        <h2>Shopping Cart</h2>
        <ul id="cart-items"></ul>
        <p>Total: $<span id="total-price">0</span></p>
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

        let cart = [];
        function addToCart(productName, price) {
            cart.push({ name: productName, price: price });
            updateCart();
        }

        function updateCart() {
            let cartList = document.getElementById('cart-items');
            let totalPrice = document.getElementById('total-price');
            cartList.innerHTML = '';
            let total = 0;
            cart.forEach(item => {
                let li = document.createElement('li');
                li.textContent = `${item.name} - $${item.price}`;
                cartList.appendChild(li);
                total += item.price;
            });
            totalPrice.textContent = total;
        }
    </script>
</body>
</html>
