<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Registration Form</title>
    <style>
        .container {
            background-color: #f0f8ff; /* Light blue color */
            color: #333; /* Dark text color */
            padding: 20px;
            border-radius: 10px; /* Rounded corners */
            transition: all 0.3s ease-in-out;
        }
        .container:hover {
            background-color: #e6f2ff; /* Slightly darker blue on hover */
        }
        input {
            width: 100%;
            padding: 12px;
            margin: 8px 0;
            display: inline-block;
            border: 1px solid #ccc;
            border-radius: 4px;
            box-sizing: border-box;
        }
        button {
            padding: 14px 20px;
            margin: 8px 0;
            border: none;
            border-radius: 4px;
            cursor: pointer;
        }
	input, button {
            transition: background-color 0.3s ease, opacity 0.3s ease;
        }
    </style>
</head>
<body>

<form action="action_page.php">
    <div class="container">
	    <h1> Student Registration!</h1>
        <p>Please fill in this form!</p>
        <hr>
        <br>

        <label for="name"><b>Name</b></label>
        <input type="text" placeholder="Enter Name" name="name" id="name" required>
        <br>

        <label for="email"><b>Email</b></label>
        <input type="text" placeholder="Enter Email" name="email" id="email" required>
        <br>

        <label for="psw"><b>Password</b></label>
        <input type="password" placeholder="Enter Password" name="psw" id="psw" required>
        <br>

        <label for="psw-repeat"><b>Repeat Password</b></label>
        <input type="password" placeholder="Repeat Password" name="psw-repeat" id="psw-repeat" required>
        <br>

        <label for="aadhar"><b>Aadhar Number</b></label>
        <input type="text" placeholder="Enter Aadhar Number" name="aadhar" id="aadhar" required>
        <br>

        <label for="mother"><b>Mother Name</b></label>
        <input type="text" placeholder="Mother Name" name="mother" id="mother" required>
        <br>

        <label for="father"><b>Father Name</b></label>
        <input type="text" placeholder="Father Name" name="father" id="father" required>
        <br>

        <label for="brother"><b>Brother Name</b></label>
        <input type="text" placeholder="Brother Name" name="brother" id="brother" required>
        <br>

        <label for="sister"><b>Sister Name</b></label>
        <input type="text" placeholder="Sister Name" name="sister" id="sister" required>
        <br>

        <p>By creating an account you agree to our <a href="#">Terms & Privacy</a>.</p>
        <button type="submit" style="background-color: #4CAF50; color: white;">Register</button>
        <button type="button" style="background-color: #f44336; color: white;">Cancel</button>
    </div>

    <div class="container signin">
        <p>Already have an account? <a href="#">Sign in</a>.</p>
    </div>
</form>

    <script>
    // Add focus and blur event listeners to input elements
    document.querySelectorAll('input').forEach(input => {
        input.addEventListener('focus', event => {
            event.target.style.backgroundColor = '#e6f7ff';
            event.target.style.borderColor = '#3399ff';
        });
        input.addEventListener('blur', event => {
            event.target.style.backgroundColor = '';
            event.target.style.borderColor = '';
        });
    });

    // Add mouseover and mouseout event listeners to button elements
    document.querySelectorAll('button').forEach(button => {
        button.addEventListener('mouseover', event => {
            event.target.style.opacity = '0.8';
            event.target.style.transform = 'scale(1.05)';
        });
        button.addEventListener('mouseout', event => {
            event.target.style.opacity = '1';
            event.target.style.transform = 'scale(1)';
        });
    });
</script>


</body>
</html>

