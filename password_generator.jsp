<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Password Generator</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined" rel="stylesheet" />

    <style>
        @import url("https://fonts.googleapis.com/css?family=Inter:400,700");
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body {
            font-family: 'Inter', sans-serif;
            background: black;
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 20px;
            flex-direction: column;
        }
        .container {
            justify-content: center;
            align-items: center;
            width: 946px;
            height: 608px;
            border-radius: 20px;
            box-shadow: 0px 0px 40px 16.97px #c274ff;
            background: linear-gradient(135deg,
                rgba(255,255,255,0.65) 0%,
                rgba(230,191,255,0.7) 25%,
                rgba(209,209,209,0.68) 35%,
                rgba(204,128,255,0.7) 50%,
                rgba(179,64,255,0.7) 75%,
                rgba(153,0,255,0.5) 100%),
                linear-gradient(0deg,
                rgba(255,255,255,1) 0%,
                rgba(255,255,255,1) 100%);
            overflow: hidden;
            animation: glow 3s ease-in-out infinite;
            padding: 40px;
        }

        .title {
            text-align: center;
            font-size: 44px;
            font-weight: 700;
            color: #4f0084;
            margin-bottom: 40px;
        }

        .password-display {
            width: 100%;
            height: 70px;
            border: 2px solid #4f0084;
            border-radius: 8px;
            background: transparent;
            color: #4f0084;
            font-size: 18px;
            font-weight: 700;
            padding: 0 16px;
            margin-bottom: 30px;
            outline: none;
        }

        .password-container {
            position: relative;
        }

        

        .password-container:hover .copy-btn {
            opacity: 1;
        }

        .length-section, .option-item {
            margin-bottom: 16px;
        }

        .length-label, .option-label {
            font-size: x-large;
            font-weight: 700;
            color: #4f0084;
        }

        .slider-container {
            margin-top: 10px;
        }

        .slider {
            width: 100%;
            height: 10px;
            border-radius: 70px;
            background: #d9d9d9;
        }

        .slider::-webkit-slider-thumb {
            appearance: none;
            width: 22px;
            height: 22px;
            border-radius: 50%;
            background: #fff;
            border: 2px solid #4f0084;
        }

        .options-grid {
            display: grid;
            grid-template-columns: repeat(2, 1fr); /* 2 columns */
            gap: 20px 80px; /* row-gap and column-gap */
            justify-content: center;
            align-items: center;
        }

        .option-item {
            display: flex;
            align-items: center;
            justify-content: space-between;
            width: 220px; 
            
        }

        .option-item label {
            font-weight: bold;
            color: #4F0084;
            font-size: x-large;
             width: 100px;
        }


        .switch {
            width: 50px;
            height: 25px;
            background: #4F0084;
            border-radius: 25px;
            position: relative;
            cursor: pointer;
        }

        .switch.active {
            background: #4f0084;
        }

        .switch-thumb {
            position: absolute;
            top: 2.5px;
            left: 2.5px;
            width: 20px;
            height: 20px;
            background: #f2e6ff;
            border-radius: 50%;
            transition: all 0.3s ease;
        }

        .switch.active .switch-thumb {
            transform: translateX(25px);
        }
        .menu-bar {
            display: flex;
            justify-content: center;
            background-color: #f2e6ff;
            border: 1px solid #4f0084;
            box-shadow: 0 0 20px rgba(128, 0, 128, 0.3);
            margin-bottom: 40px;
            position: relative;
            overflow: hidden;
            width: fit-content;
            width:944px;
            height : 10vh;
            font-size: 1.3em;
            align-items: center;
            margin-top: -200px;

        }

        .tab {
            padding: 16px 28px;
            font-weight: 600;
            color: #4f0084;
            cursor: pointer;
            transition: background-color 0.3s ease;
            border-right: 1px solid #4f0084;
            text-align: center;
            white-space: nowrap;
        }

        .tab:last-child {
            border-right: none;
        }

        .tab:hover {
            background-color: #e5bfff;
        }

        .tab.active {
            background-color: #e5bfffd1;
        }

        .tab a {
            text-decoration: none;
            color: inherit;
        }


       
    </style>
</head>
<body>
    <div class="menu-bar">
        <div class="tab"><a href="password_analyzer.jsp">Password Strength Analyzer</a></div>
        <div class="tab active">Password Generator</div>
        <div class="tab"><a href="wordlist_generator.jsp">Custom Wordlist Generator</a></div>
    </div>
     <br> <br><br><br><br>
<div class="container">
    
    <h1 class="title">Password Generator</h1>
    <div class="password-container">
        <input type="text" class="password-display" id="passwordDisplay" readonly placeholder="Generated password here...">
        
    </div>

    <div class="length-section">
        <label class="length-label">Password Length: <span id="lengthValue">13</span></label>
        <div class="slider-container">
            <input type="range" class="slider" id="lengthSlider" min="4" max="30" value="13">
        </div>
    </div>

    <div class="options-grid">
        <div class="option-item">
            <label>Uppercase</label>
            <div class="switch" id="uppercaseSwitch"><div class="switch-thumb"></div></div>
        </div>
        <div class="option-item">
            <label>Lowercase</label>
            <div class="switch" id="lowercaseSwitch"><div class="switch-thumb"></div></div>
        </div>
        <div class="option-item">
            <label>Numbers</label>
            <div class="switch" id="numbersSwitch"><div class="switch-thumb"></div></div>
        </div>
        <div class="option-item">
            <label>Symbols</label>
            <div class="switch" id="symbolsSwitch"><div class="switch-thumb"></div></div>
        </div>
    </div>



   
</div>

<script>
    class PasswordGenerator {
        constructor() {
            this.passwordLength = 13;
            this.options = {
                uppercase: true,
                lowercase: true,
                numbers: true,
                symbols: true
            };
            this.characters = {
                uppercase: 'ABCDEFGHIJKLMNOPQRSTUVWXYZ',
                lowercase: 'abcdefghijklmnopqrstuvwxyz',
                numbers: '0123456789',
                symbols: '!@#$%^&*()_+-=[]{}|;:,.<>?'
            };
            this.init();
        }

        init() {
            this.lengthSlider = document.getElementById('lengthSlider');
            this.lengthValue = document.getElementById('lengthValue');
            this.passwordDisplay = document.getElementById('passwordDisplay');
           
            this.generateBtn = document.getElementById('generateBtn');

            this.switches = {
                uppercase: document.getElementById('uppercaseSwitch'),
                lowercase: document.getElementById('lowercaseSwitch'),
                numbers: document.getElementById('numbersSwitch'),
                symbols: document.getElementById('symbolsSwitch')
            };

            this.lengthSlider.addEventListener('input', () => {
                this.passwordLength = parseInt(this.lengthSlider.value);
                this.lengthValue.textContent = this.passwordLength;
                this.generatePassword();
            });

            Object.keys(this.switches).forEach(key => {
                this.switches[key].addEventListener('click', () => this.toggleOption(key));
            });

            this.generateBtn.addEventListener('click', () => this.generatePassword());
           
            this.generatePassword();
        }

        toggleOption(key) {
            this.options[key] = !this.options[key];
            this.switches[key].classList.toggle('active');

            if (!Object.values(this.options).includes(true)) {
                this.options[key] = true;
                this.switches[key].classList.add('active');
            }
            this.generatePassword();
        }

        generatePassword() {
            let charset = '';
            if (this.options.uppercase) charset += this.characters.uppercase;
            if (this.options.lowercase) charset += this.characters.lowercase;
            if (this.options.numbers) charset += this.characters.numbers;
            if (this.options.symbols) charset += this.characters.symbols;

            if (charset === '') {
                this.passwordDisplay.value = 'Please select at least one option';
                return;
            }

            let password = '';
            if (this.options.uppercase) password += this.randomChar(this.characters.uppercase);
            if (this.options.lowercase) password += this.randomChar(this.characters.lowercase);
            if (this.options.numbers) password += this.randomChar(this.characters.numbers);
            if (this.options.symbols) password += this.randomChar(this.characters.symbols);

            for (let i = password.length; i < this.passwordLength; i++) {
                password += this.randomChar(charset);
            }

            this.passwordDisplay.value = this.shuffle(password);
        }

        randomChar(set) {
            return set.charAt(Math.floor(Math.random() * set.length));
        }

        shuffle(str) {
            return str.split('').sort(() => 0.5 - Math.random()).join('');
        }

        
    }

    document.addEventListener('DOMContentLoaded', () => {
        new PasswordGenerator();
    });
</script>
</body>
</html>
