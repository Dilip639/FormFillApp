<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Wedding Invitation</title>
    <link rel="stylesheet" href="styles.css">
</head>
<body>
    <div class="invitation-container">
        <h1>You're Invited!</h1>
        <p>Join us for the wedding of</p>
        <h2>Suresh & Padmini</h2>
        <p>on</p>
        <p class="date">April 20, 2025</p>
        <p>at</p>
        <p class="location">The Grand Venue, Sangareddy</p>
        <button onclick="RSVP()">RSVP</button>
        <p id="rsvp-message"></p>
    </div>
    <script src="script.js"></script>
</body>
<style>
body {
    font-family: 'Arial, sans-serif';
    background-color: #f0f8ff;
    margin: 0;
    display: flex;
    justify-content: center;
    align-items: center;
    height: 100vh;
}

.invitation-container {
    text-align: center;
    background-color: #fff;
    padding: 2rem;
    border-radius: 10px;
    box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
}

h1 {
    color: #d23669;
    font-size: 2.5rem;
}

h2 {
    color: #4a4a4a;
    font-size: 2rem;
}

p {
    color: #606060;
    margin: 0.5rem 0;
}

.date, .location {
    font-weight: bold;
}

button {
    margin-top: 1rem;
    padding: 0.5rem 1rem;
    background-color: #d23669;
    color: #fff;
    border: none;
    border-radius: 5px;
    cursor: pointer;
}

button:hover {
    background-color: #b52b53;
}

#rsvp-message {
    margin-top: 1rem;
    color: #28a745;
}
</style>
<script>function RSVP() {
    document.getElementById('rsvp-message').innerText = "Thank you for your RSVP!";
}
</script>
</html>
