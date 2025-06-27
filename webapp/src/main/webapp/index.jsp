
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Contact Form</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Arial', sans-serif;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 20px;
        }

        .form-container {
            background: white;
            border-radius: 15px;
            box-shadow: 0 20px 40px rgba(0, 0, 0, 0.1);
            padding: 40px;
            width: 100%;
            max-width: 600px;
        }

        .form-header {
            text-align: center;
            margin-bottom: 30px;
        }

        .form-header h1 {
            color: #333;
            font-size: 28px;
            margin-bottom: 10px;
        }

        .form-header p {
            color: #666;
            font-size: 16px;
        }

        .form-group {
            margin-bottom: 20px;
        }

        .form-row {
            display: flex;
            gap: 15px;
        }

        .form-row .form-group {
            flex: 1;
        }

        label {
            display: block;
            margin-bottom: 8px;
            color: #333;
            font-weight: 600;
            font-size: 14px;
        }

        .required {
            color: #e74c3c;
        }

        input[type="text"],
        input[type="email"],
        input[type="tel"],
        select,
        textarea {
            width: 100%;
            padding: 12px 15px;
            border: 2px solid #e1e8ed;
            border-radius: 8px;
            font-size: 16px;
            transition: all 0.3s ease;
            background-color: #f8f9fa;
        }

        input[type="text"]:focus,
        input[type="email"]:focus,
        input[type="tel"]:focus,
        select:focus,
        textarea:focus {
            outline: none;
            border-color: #667eea;
            background-color: white;
            box-shadow: 0 0 0 3px rgba(102, 126, 234, 0.1);
        }

        textarea {
            resize: vertical;
            min-height: 120px;
        }

        .checkbox-group,
        .radio-group {
            display: flex;
            flex-direction: column;
            gap: 10px;
        }

        .checkbox-item,
        .radio-item {
            display: flex;
            align-items: center;
            gap: 10px;
        }

        input[type="checkbox"],
        input[type="radio"] {
            width: 18px;
            height: 18px;
            accent-color: #667eea;
        }

        .submit-btn {
            width: 100%;
            padding: 15px;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            border: none;
            border-radius: 8px;
            font-size: 18px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
            margin-top: 10px;
        }

        .submit-btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 10px 20px rgba(102, 126, 234, 0.3);
        }

        .submit-btn:active {
            transform: translateY(0);
        }

        .error-message {
            color: #e74c3c;
            font-size: 14px;
            margin-top: 5px;
            display: none;
        }

        .success-message {
            background-color: #d4edda;
            color: #155724;
            padding: 15px;
            border-radius: 8px;
            margin-bottom: 20px;
            border: 1px solid #c3e6cb;
            display: none;
        }

        @media (max-width: 768px) {
            .form-row {
                flex-direction: column;
                gap: 0;
            }
            
            .form-container {
                padding: 20px;
            }
        }
    </style>
</head>
<body>
    <div class="form-container">
        <div class="form-header">
            <h1>Dilip Form</h1>
            <p>Please fill out the form below and we'll get back to you soon.</p>
        </div>

        <div class="success-message" id="successMessage">
            Thank you! Your form has been submitted successfully.
        </div>

        <form id="contactForm" method="post" action="submitForm.jsp">
            <div class="form-row">
                <div class="form-group">
                    <label for="firstName">First Name <span class="required">*</span></label>
                    <input type="text" id="firstName" name="firstName" required>
                    <div class="error-message" id="firstNameError">Please enter your first name</div>
                </div>
                <div class="form-group">
                    <label for="lastName">Last Name <span class="required">*</span></label>
                    <input type="text" id="lastName" name="lastName" required>
                    <div class="error-message" id="lastNameError">Please enter your last name</div>
                </div>
            </div>

            <div class="form-group">
                <label for="email">Email Address <span class="required">*</span></label>
                <input type="email" id="email" name="email" required>
                <div class="error-message" id="emailError">Please enter a valid email address</div>
            </div>

            <div class="form-group">
                <label for="phone">Phone Number</label>
                <input type="tel" id="phone" name="phone">
            </div>

            <div class="form-group">
                <label for="subject">Subject <span class="required">*</span></label>
                <select id="subject" name="subject" required>
                    <option value="">Please select a subject</option>
                    <option value="general">General Inquiry</option>
                    <option value="support">Technical Support</option>
                    <option value="sales">Sales Question</option>
                    <option value="feedback">Feedback</option>
                    <option value="other">Other</option>
                </select>
                <div class="error-message" id="subjectError">Please select a subject</div>
            </div>

            <div class="form-group">
                <label>Preferred Contact Method</label>
                <div class="radio-group">
                    <div class="radio-item">
                        <input type="radio" id="contactEmail" name="contactMethod" value="email" checked>
                        <label for="contactEmail">Email</label>
                    </div>
                    <div class="radio-item">
                        <input type="radio" id="contactPhone" name="contactMethod" value="phone">
                        <label for="contactPhone">Phone</label>
                    </div>
                </div>
            </div>

            <div class="form-group">
                <label for="message">Message <span class="required">*</span></label>
                <textarea id="message" name="message" placeholder="Please describe your inquiry in detail..." required></textarea>
                <div class="error-message" id="messageError">Please enter your message</div>
            </div>

            <div class="form-group">
                <div class="checkbox-group">
                    <div class="checkbox-item">
                        <input type="checkbox" id="newsletter" name="newsletter" value="yes">
                        <label for="newsletter">Subscribe to our newsletter</label>
                    </div>
                    <div class="checkbox-item">
                        <input type="checkbox" id="terms" name="terms" required>
                        <label for="terms">I agree to the terms and conditions <span class="required">*</span></label>
                    </div>
                </div>
                <div class="error-message" id="termsError">You must agree to the terms and conditions</div>
            </div>

            <button type="submit" class="submit-btn">Send Message</button>
        </form>
    </div>

    <script>
        document.getElementById('contactForm').addEventListener('submit', function(e) {
            e.preventDefault();
            
            // Clear previous error messages
            const errorMessages = document.querySelectorAll('.error-message');
            errorMessages.forEach(msg => msg.style.display = 'none');
            
            let isValid = true;
            
            // Validate first name
            const firstName = document.getElementById('firstName').value.trim();
            if (!firstName) {
                document.getElementById('firstNameError').style.display = 'block';
                isValid = false;
            }
            
            // Validate last name
            const lastName = document.getElementById('lastName').value.trim();
            if (!lastName) {
                document.getElementById('lastNameError').style.display = 'block';
                isValid = false;
            }
            
            // Validate email
            const email = document.getElementById('email').value.trim();
            const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
            if (!email || !emailRegex.test(email)) {
                document.getElementById('emailError').style.display = 'block';
                isValid = false;
            }
            
            // Validate subject
            const subject = document.getElementById('subject').value;
            if (!subject) {
                document.getElementById('subjectError').style.display = 'block';
                isValid = false;
            }
            
            // Validate message
            const message = document.getElementById('message').value.trim();
            if (!message) {
                document.getElementById('messageError').style.display = 'block';
                isValid = false;
            }
            
            // Validate terms agreement
            const terms = document.getElementById('terms').checked;
            if (!terms) {
                document.getElementById('termsError').style.display = 'block';
                isValid = false;
            }
            
            if (isValid) {
                // Show success message
                document.getElementById('successMessage').style.display = 'block';
                
                // Reset form
                this.reset();
                
                // Scroll to top
                window.scrollTo({ top: 0, behavior: 'smooth' });
                
                // In a real application, you would submit the form data here
                // For demo purposes, we're just showing the success message
                console.log('Form submitted successfully!');
            }
        });
        
        // Add real-time validation
        const inputs = document.querySelectorAll('input, select, textarea');
        inputs.forEach(input => {
            input.addEventListener('blur', function() {
                const errorId = this.id + 'Error';
                const errorElement = document.getElementById(errorId);
                
                if (errorElement) {
                    if (this.hasAttribute('required') && !this.value.trim()) {
                        errorElement.style.display = 'block';
                    } else if (this.type === 'email' && this.value) {
                        const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
                        if (!emailRegex.test(this.value)) {
                            errorElement.style.display = 'block';
                        } else {
                            errorElement.style.display = 'none';
                        }
                    } else {
                        errorElement.style.display = 'none';
                    }
                }
            });
        });
    </script>
</body>
</html>

