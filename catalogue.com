<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Shop - Dee's Gadget</title>
  <link rel="stylesheet" href="style.css">

  <style>
    /* Reset */
    * { box-sizing: border-box; margin: 0; padding: 0; }

    body {
      font-family: Arial, sans-serif;
      background:#f5f6fa;
      color:#222;
      line-height:1.4;
    }

    /* NAVBAR */
    .navbar {
      display:flex;
      align-items:center;
      justify-content:space-between;
      gap:20px;
      padding:10px 20px;
      background:#2c3e50;
      color:#fff;
      position:sticky;
      top:0;
      z-index:100;
    }

    .logo img {
      height:50px;
      width:auto;
      display:block;
    }

    .nav-links {
      display:flex;
      list-style:none;
      gap:18px;
      align-items:center;
    }

    .nav-links a {
      color:#fff;
      text-decoration:none;
      font-weight:600;
    }

    .nav-links a:hover {
      color:#FFD700;
    }

    /* PRODUCTS */
    .products {
      display: grid;
      grid-template-columns: repeat(auto-fill, minmax(250px, 1fr));
      gap: 20px;
      padding: 40px;
      max-width:1200px;
      margin:auto;
    }

    .product-card {
      border: 1px solid #ddd;
      border-radius: 10px;
      padding: 15px;
      text-align: center;
      background: #fff;
      box-shadow: 0 4px 6px rgba(0,0,0,0.1);
      transition: transform 0.3s;
    }

    .product-card:hover {
      transform: translateY(-5px);
    }

    .product-card img {
      width: 100%;
      height: 220px;
      object-fit: cover;
      border-radius: 8px;
    }

    .product-card h3 {
      margin: 10px 0;
      font-size: 18px;
    }

    .product-card p {
      font-size: 16px;
      color: #333;
    }

    .btn {
      background: #1435EB;
      color: white;
      padding: 10px 15px;
      border: none;
      border-radius: 5px;
      cursor: pointer;
      margin-top: 10px;
      transition: background 0.3s;
    }

    .btn:hover {
      background: #0f2bc2;
    }

    footer {
      text-align:center;
      padding:14px;
      color:#666;
      font-size:14px;
    }
  </style>
</head>
<body onload="catalogueInit()">

  <header>
    <nav class="navbar">
      <div class="logo">
        <a href="index.html"><img src="project/dg.png" alt="Website Logo"></a>
      </div>
      <ul class="nav-links">
        <li><a href="index.html">Home</a></li>
        <li><a href="catalogue.html" class="active">Shop</a></li>
        <li><a href="about.html">About</a></li>
        <li><a href="contact.html">Contact</a></li>
        <li><a href="cart.html" class="cart-link">Cart 🛒 <span class="cart-count">0</span></a></li>
      </ul>
    </nav>
  </header>

  <section class="products">
    <div class="product-card">
      <img src="PROJECT/DIVINE4.JPG" alt="iPhone 14">
      <h3>IPHONE</h3>
      <p>₦700,000</p>
      <button class="btn" onclick="addToCart(1)">Add to Cart</button>
    </div>

    <div class="product-card">
      <img src="PROJECT/samsung.jpg" alt="Samsung Galaxy S23">
      <h3>Samsung Galaxy S23</h3>
      <p>₦500,000</p>
      <button class="btn" onclick="addToCart(2)">Add to Cart</button>
    </div>

    <div class="product-card">
      <img src="PRODUCTS/ip14w.jpg" alt="AirPods Pro">
      <h3>AirPods Pro</h3>
      <p>₦150,000</p>
      <button class="btn" onclick="addToCart(3)">Add to Cart</button>
    </div>
  </section>

  <footer>
    <p>© 2025 Dee's Gadget. All rights reserved.</p>
  </footer>

  <script>
    // Product Data
    const PRODUCTS = [
      {id:1, title:'iPhone 14 Pro', price:700000, img:'project/ip14w.jpg'},
      {id:2, title:'Samsung Galaxy S23', price:500000, img:'project/samsung.jpg'},
      {id:3, title:'Infinix Note 12', price:120000, img:'project/infinix.jpg'},
      {id:4, title:'AirPods Pro', price:150000, img:'project/airpods.jpg'}
    ];

    // Cart Utilities
    function getCart() { return JSON.parse(localStorage.getItem('dg_cart') || '[]'); }
    function saveCart(cart) { localStorage.setItem('dg_cart', JSON.stringify(cart)); }
    function addToCart(id, qty=1) {
      const cart = getCart();
      const found = cart.find(i=>i.id===id);
      if(found) found.qty += qty; else cart.push({id, qty});
      saveCart(cart);
      updateCartCount();
      alert('Added to cart ✅');
    }
    function updateCartCount() {
      const cart = getCart();
      const total = cart.reduce((s,i)=>s+i.qty,0);
      const el = document.querySelector('.cart-count');
      if(el) el.textContent = total;
    }

    // Initialize Page
    function catalogueInit() {
      updateCartCount();
    }

    document.addEventListener('DOMContentLoaded', updateCartCount);
  </script>

</body>
</html>
