
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Form Fill Application</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
            padding: 20px;
        }

        .container {
            max-width: 800px;
            margin: 0 auto;
            background: white;
            border-radius: 20px;
            box-shadow: 0 20px 40px rgba(0, 0, 0, 0.1);
            overflow: hidden;
        }

        .header {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            padding: 40px;
            text-align: center;
        }

        .header h1 {
            font-size: 2.5rem;
            margin-bottom: 10px;
            font-weight: 300;
        }

        .header p {
            font-size: 1.1rem;
            opacity: 0.9;
        }

        .form-container {
            padding: 40px;
        }

        .form-section {
            margin-bottom: 40px;
        }

        .section-title {
            font-size: 1.5rem;
            color: #333;
            margin-bottom: 20px;
            padding-bottom: 10px;
            border-bottom: 2px solid #667eea;
            display: flex;
            align-items: center;
        }

        .section-title::before {
            content: '';
            width: 20px;
            height: 20px;
            background: #667eea;
            border-radius: 50%;
            margin-right: 15px;
        }

        .form-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 20px;
            margin-bottom: 20px;
        }

        .form-group {
            display: flex;
            flex-direction: column;
        }

        .form-group.full-width {
            grid-column: 1 / -1;
        }

        label {
            font-weight: 600;
            color: #333;
            margin-bottom: 8px;
            font-size: 0.9rem;
        }

        input, select, textarea {
            padding: 12px 16px;
            border: 2px solid #e0e0e0;
            border-radius: 10px;
            font-size: 1rem;
            transition: all 0.3s ease;
            background: #fafafa;
        }

        input:focus, select:focus, textarea:focus {
            outline: none;
            border-color: #667eea;
            background: white;
            box-shadow: 0 0 0 3px rgba(102, 126, 234, 0.1);
        }

        .checkbox-group, .radio-group {
            display: flex;
            flex-wrap: wrap;
            gap: 15px;
            margin-top: 10px;
        }

        .checkbox-item, .radio-item {
            display: flex;
            align-items: center;
            gap: 8px;
        }

        input[type="checkbox"], input[type="radio"] {
            width: 18px;
            height: 18px;
            margin: 0;
        }

        .btn-group {
            display: flex;
            gap: 15px;
            justify-content: center;
            margin-top: 40px;
        }

        .btn {
            padding: 15px 30px;
            border: none;
            border-radius: 10px;
            font-size: 1rem;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
            text-transform: uppercase;
            letter-spacing: 1px;
        }

        .btn-primary {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
        }

        .btn-primary:hover {
            transform: translateY(-2px);
            box-shadow: 0 10px 20px rgba(102, 126, 234, 0.3);
        }

        .btn-secondary {
            background: #f0f0f0;
            color: #333;
        }

        .btn-secondary:hover {
            background: #e0e0e0;
        }

        .error {
            color: #e74c3c;
            font-size: 0.8rem;
            margin-top: 5px;
        }

        .success-message {
            background: #27ae60;
            color: white;
            padding: 20px;
            border-radius: 10px;
            text-align: center;
            margin-bottom: 20px;
            display: none;
        }

        @media (max-width: 768px) {
            .form-grid {
                grid-template-columns: 1fr;
            }
            
            .btn-group {
                flex-direction: column;
            }
            
            .header h1 {
                font-size: 2rem;
            }
            
            .container {
                margin: 10px;
            }
        }

        .progress-bar {
            width: 100%;
            height: 6px;
            background: #e0e0e0;
            border-radius: 3px;
            margin-bottom: 30px;
            overflow: hidden;
        }

        .progress-fill {
            height: 100%;
            background: linear-gradient(90deg, #667eea, #764ba2);
            width: 0%;
            transition: width 0.5s ease;
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="header">
            <h1>📋 Form Fill Application</h1>
            <p>Complete your information below</p>
        </div>

        <div class="form-container">
            <div class="progress-bar">
                <div class="progress-fill" id="progressFill"></div>
            </div>

            <div class="success-message" id="successMessage">
                ✅ Form submitted successfully! Thank you for your information.
            </div>

            <form id="mainForm">
                <!-- Personal Information Section -->
                <div class="form-section">
                    <h2 class="section-title">👤 Personal Information</h2>
                    <div class="form-grid">
                        <div class="form-group">
                            <label for="firstName">First Name *</label>
                            <input type="text" id="firstName" name="firstName" required>
                            <div class="error" id="firstNameError"></div>
                        </div>
                        <div class="form-group">
                            <label for="lastName">Last Name *</label>
                            <input type="text" id="lastName" name="lastName" required>
                            <div class="error" id="lastNameError"></div>
                        </div>
                        <div class="form-group">
                            <label for="dateOfBirth">Date of Birth</label>
                            <input type="date" id="dateOfBirth" name="dateOfBirth">
                        </div>
                        <div class="form-group">
                            <label for="gender">Gender</label>
                            <select id="gender" name="gender">
                                <option value="">Select Gender</option>
                                <option value="male">Male</option>
                                <option value="female">Female</option>
                                <option value="other">Other</option>
                                <option value="prefer-not-to-say">Prefer not to say</option>
                            </select>
                        </div>
                    </div>
                </div>

                <!-- Contact Information Section -->
                <div class="form-section">
                    <h2 class="section-title">📞 Contact Information</h2>
                    <div class="form-grid">
                        <div class="form-group">
                            <label for="email">Email Address *</label>
                            <input type="email" id="email" name="email" required>
                            <div class="error" id="emailError"></div>
                        </div>
                        <div class="form-group">
                            <label for="phone">Phone Number</label>
                            <input type="tel" id="phone" name="phone">
                        </div>
                        <div class="form-group full-width">
                            <label for="address">Street Address</label>
                            <input type="text" id="address" name="address">
                        </div>
                        <div class="form-group">
                            <label for="city">City</label>
                            <input type="text" id="city" name="city">
                        </div>
                        <div class="form-group">
                            <label for="state">State/Province</label>
                            <input type="text" id="state" name="state">
                        </div>
                        <div class="form-group">
                            <label for="zipCode">ZIP/Postal Code</label>
                            <input type="text" id="zipCode" name="zipCode">
                        </div>
                        <div class="form-group">
                            <label for="country">Country</label>
                            <select id="country" name="country">
                                <option value="">Select Country</option>
                                <option value="us">United States</option>
                                <option value="ca">Canada</option>
                                <option value="uk">United Kingdom</option>
                                <option value="au">Australia</option>
                                <option value="de">Germany</option>
                                <option value="fr">France</option>
                                <option value="jp">Japan</option>
                                <option value="other">Other</option>
                            </select>
                        </div>
                    </div>
                </div>

                <!-- Preferences Section -->
                <div class="form-section">
                    <h2 class="section-title">⚙️ Preferences</h2>
                    
                    <div class="form-group">
                        <label>Interests (Select all that apply)</label>
                        <div class="checkbox-group">
                            <div class="checkbox-item">
                                <input type="checkbox" id="sports" name="interests" value="sports">
                                <label for="sports">Sports</label>
                            </div>
                            <div class="checkbox-item">
                                <input type="checkbox" id="music" name="interests" value="music">
                                <label for="music">Music</label>
                            </div>
                            <div class="checkbox-item">
                                <input type="checkbox" id="technology" name="interests" value="technology">
                                <label for="technology">Technology</label>
                            </div>
                            <div class="checkbox-item">
                                <input type="checkbox" id="travel" name="interests" value="travel">
                                <label for="travel">Travel</label>
                            </div>
                            <div class="checkbox-item">
                                <input type="checkbox" id="reading" name="interests" value="reading">
                                <label for="reading">Reading</label>
                            </div>
                            <div class="checkbox-item">
                                <input type="checkbox" id="cooking" name="interests" value="cooking">
                                <label for="cooking">Cooking</label>
                            </div>
                        </div>
                    </div>

                    <div class="form-group">
                        <label>Preferred Contact Method</label>
                        <div class="radio-group">
                            <div class="radio-item">
                                <input type="radio" id="contactEmail" name="contactMethod" value="email">
                                <label for="contactEmail">Email</label>
                            </div>
                            <div class="radio-item">
                                <input type="radio" id="contactPhone" name="contactMethod" value="phone">
                                <label for="contactPhone">Phone</label>
                            </div>
                            <div class="radio-item">
                                <input type="radio" id="contactMail" name="contactMethod" value="mail">
                                <label for="contactMail">Mail</label>
                            </div>
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="newsletter">
                            <input type="checkbox" id="newsletter" name="newsletter" value="yes">
                            Subscribe to our newsletter
                        </label>
                    </div>

                    <div class="form-group full-width">
                        <label for="comments">Additional Comments</label>
                        <textarea id="comments" name="comments" rows="4" placeholder="Tell us anything else you'd like us to know..."></textarea>
                    </div>
                </div>

                <div class="btn-group">
                    <button type="button" class="btn btn-secondary" onclick="clearForm()">Clear Form</button>
                    <button type="submit" class="btn btn-primary">Submit Form</button>
                </div>
            </form>
        </div>
    </div>

    <script>
        // Form validation and progress tracking
        const form = document.getElementById('mainForm');
        const progressFill = document.getElementById('progressFill');
        const successMessage = document.getElementById('successMessage');

        // Calculate and update progress
        function updateProgress() {
            const inputs = form.querySelectorAll('input, select, textarea');
            const totalFields = inputs.length;
            let filledFields = 0;

            inputs.forEach(input => {
                if (input.type === 'checkbox' || input.type === 'radio') {
                    if (input.checked) filledFields++;
                } else if (input.value.trim() !== '') {
                    filledFields++;
                }
            });

            const progress = (filledFields / totalFields) * 100;
            progressFill.style.width = progress + '%';
        }

        // Add event listeners to all form inputs
        const inputs = form.querySelectorAll('input, select, textarea');
        inputs.forEach(input => {
            input.addEventListener('input', updateProgress);
            input.addEventListener('change', updateProgress);
        });

        // Form validation
        function validateForm() {
            let isValid = true;
            const errors = {};

            // Clear previous errors
            document.querySelectorAll('.error').forEach(error => error.textContent = '');

            // Required field validation
            const firstName = document.getElementById('firstName').value.trim();
            if (!firstName) {
                errors.firstName = 'First name is required';
                isValid = false;
            }

            const lastName = document.getElementById('lastName').value.trim();
            if (!lastName) {
                errors.lastName = 'Last name is required';
                isValid = false;
            }

            const email = document.getElementById('email').value.trim();
            if (!email) {
                errors.email = 'Email is required';
                isValid = false;
            } else if (!/\S+@\S+\.\S+/.test(email)) {
                errors.email = 'Please enter a valid email address';
                isValid = false;
            }

            // Display errors
            Object.keys(errors).forEach(field => {
                const errorElement = document.getElementById(field + 'Error');
                if (errorElement) {
                    errorElement.textContent = errors[field];
                }
            });

            return isValid;
        }

        // Form submission
        form.addEventListener('submit', function(e) {
            e.preventDefault();
            
            if (validateForm()) {
                // Simulate form submission
                const formData = new FormData(form);
                const data = {};
                
                // Collect form data
                for (let [key, value] of formData.entries()) {
                    if (data[key]) {
                        if (Array.isArray(data[key])) {
                            data[key].push(value);
                        } else {
                            data[key] = [data[key], value];
                        }
                    } else {
                        data[key] = value;
                    }
                }

                // Log the data (in a real app, you'd send this to a server)
                console.log('Form Data:', data);
                
                // Show success message
                successMessage.style.display = 'block';
                form.style.display = 'none';
                
                // Scroll to top to show success message
                window.scrollTo({ top: 0, behavior: 'smooth' });
            }
        });

        // Clear form function
        function clearForm() {
            if (confirm('Are you sure you want to clear all form data?')) {
                form.reset();
                document.querySelectorAll('.error').forEach(error => error.textContent = '');
                successMessage.style.display = 'none';
                form.style.display = 'block';
                updateProgress();
            }
        }

        // Initialize progress on page load
        updateProgress();

        // Auto-save to localStorage (optional feature)
        function saveToLocalStorage() {
            const formData = new FormData(form);
            const data = {};
            for (let [key, value] of formData.entries()) {
                data[key] = value;
            }
            localStorage.setItem('formData', JSON.stringify(data));
        }

        function loadFromLocalStorage() {
            const savedData = localStorage.getItem('formData');
            if (savedData) {
                const data = JSON.parse(savedData);
                Object.keys(data).forEach(key => {
                    const element = document.getElementById(key) || document.querySelector(`[name="${key}"]`);
                    if (element) {
                        if (element.type === 'checkbox' || element.type === 'radio') {
                            element.checked = element.value === data[key];
                        } else {
                            element.value = data[key];
                        }
                    }
                });
                updateProgress();
            }
        }

        // Auto-save every 30 seconds
        setInterval(saveToLocalStorage, 30000);

        // Load saved data on page load
        window.addEventListener('load', loadFromLocalStorage);
    </script>
</body>
</html>
