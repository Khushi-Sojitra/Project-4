<%@ page import="java.util.regex.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String password = request.getParameter("password");
    int score = -1;
    String suggestion = "";
    String strengthClass = "";

    if (password != null && !password.trim().isEmpty()) {
        score = 0;
        if (password.length() >= 8) score++;
        if (Pattern.compile("[A-Z]").matcher(password).find()) score++;
        if (Pattern.compile("[0-9]").matcher(password).find()) score++;
        if (Pattern.compile("[^a-zA-Z0-9]").matcher(password).find()) score++;

        switch (score) {
            case 0:
            case 1:
                suggestion = "Use longer passwords with mix of upper, lower, numbers, symbols.";
                strengthClass = "weak";
                break;
            case 2:
                suggestion = "Add another word or two. Uncommon words are better.";
                strengthClass = "weak";
                break;
            case 3:
                suggestion = "Good! Try using a special symbol.";
                strengthClass = "medium";
                break;
            case 4:
                suggestion = "Strong password! You're doing great.";
                strengthClass = "strong";
                break;
        }
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Password Strength Analyzer</title>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;600;700&display=swap" rel="stylesheet">
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Inter', -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif;
            background-color: #000000;
            min-height: 100vh;
            display: flex;
            justify-content: center;
            align-items: start;
            padding-top: 60px;
        }

        .container {
            display: flex;
            flex-direction: column;
            align-items: center;
            width: 100%;
            max-width: 1440px;
        }

        /* 🟪 Top Tab Menu Card */
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

        /* 🟣 Main Card */
        .card {
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
        }
        .main-content {
            display: flex;
            justify-content: center;
            align-items: center;
            height: 70vh; /* adjust if top menu is 80px */
            background-color: #000;
        }


        .card-content {
            width: 100%;
            height: 100%;
            position: relative;
            padding: 0;
        }

        .main-title {
            position: absolute;
            top: 90px;
            left: 193px;
            color: #4f0084;
            font-size: 40px;
            font-weight: 700;
            font-family: 'Inter', sans-serif;
        }

        /* 📥 Analyzer Input Section */
        .analyzer-section {
            position: absolute;
            width: 855px;
            height: 192px;
            top: 200px;
            left: 44px;
        }

        .input-section {
            display: flex;
            align-items: center;
            gap: 10px;
            margin-bottom: 20px;
        }

        .input-label {
            font-family: 'Inter', sans-serif;
            font-weight: 700;
            color: #4f0084;
            font-size: 24px;
        }

        .password-input {
            width: 329px;
            height: 33px;
            border-radius: 3px;
            border: 1px solid #4f0084;
            background: transparent;
            padding: 8px 12px;
            font-size: 16px;
            color: #4f0084;
            outline: none;
            transition: border-color 0.3s ease, box-shadow 0.3s ease;
        }

        .password-input:focus,
        .password-input:hover {
            border-color: #7c3aed;
            box-shadow: 0 0 0 2px rgba(124, 58, 237, 0.2);
        }

        .password-input::placeholder {
            color: #9ca3af;
            opacity: 0.7;
        }

        /* 🔢 Score Section */
        .score-section {
            display: flex;
            align-items: center;
            gap: 10px;
            margin-bottom: 20px;
            font-family: 'Inter', sans-serif;
            font-size: 24px;
        }

        .score-label {
            color: #4f0084;
            font-weight: 700;
        }

        .score-value {
            font-weight: 700;
        }

        .score-value.weak {
            color: #ff0925;
        }

        .score-value.strong {
            color: #1fc42a;
        }

        /* 💡 Suggestions Section */
        .suggestions-section {
            display: flex;
            align-items: center;
            gap: 10px;
            font-family: 'Inter', sans-serif;
            font-size: 24px;
        }

        .suggestions-label {
            font-weight: 700;
            color: #4f0084;
        }

        .suggestions-text {
            font-weight: 600;
            font-style: italic;
            color: #009009;
        }

        /* 🌟 Glow Animation */
        @keyframes glow {
            0%, 100% {
                box-shadow: 0px 0px 40px 16.97px #c274ff;
            }
            50% {
                box-shadow: 0px 0px 50px 20px #c274ff;
            }
        }

        /* 📱 Responsive */
        @media (max-width: 1024px) {
            .card {
                width: 90%;
                height: auto;
                padding: 40px 20px;
            }

            .main-title {
                position: static;
                text-align: center;
                margin-bottom: 20px;
                font-size: 32px;
            }

            .analyzer-section {
                position: static;
                width: 100%;
                padding: 0;
            }

            .input-section,
            .score-section,
            .suggestions-section {
                flex-direction: column;
                align-items: flex-start;
                gap: 12px;
                font-size: 20px;
            }

            .password-input {
                width: 100%;
                max-width: 100%;
            }

            .input-label {
                margin-bottom: 8px;
            }

            .tab {
                font-size: 16px;
                padding: 12px 18px;
            }
        }

        @media (max-width: 480px) {
            .main-title {
                font-size: 24px;
            }

            .input-label, .score-section, .suggestions-section {
                font-size: 18px;
            }

            .menu-bar {
                flex-direction: column;
                align-items: stretch;
            }

            .tab {
                border-right: none;
                border-bottom: 1px solid #4f0084;
            }

            .tab:last-child {
                border-bottom: none;
            }
        }

    </style>
</head>
<body>
    <div class="container">
        <div class="app-wrapper">
            <div class="menu-bar">
                <div class="tab active">Password Strength Analyzer</div>
                <div class="tab"><a href="password_generator.jsp">Password Generator</a></div>
                <div class="tab"><a href="wordlist_generator.jsp">Custom Wordlist Generator</a></div>
            </div>



            <main class="main-content">
                <div class="card">
                    <div class="card-content">
                        <h1 class="main-title">Password Strength Analyzer</h1>
                        <div class="analyzer-section">
                            <form method="post">
                                <div class="input-section">
                                    <label for="password-input" class="input-label">Enter a password:</label><br>
                                    <input type="password" id="password-input" name="password" class="password-input" placeholder="Type your password here..." value="<%= (password != null) ? password : "" %>">
                                </div>
                                
                            </form>
                            
                                
                                <% if (score >= 0) { %>
                                    <div class="score-section">
                                        <span class="score-label">Password Strength Score: </span>
                                        <span class="score-value <%= strengthClass %>"><%= score %></span>
                                        <span class="score-label"> (</span>
                                        <span class="score-weak">0</span>
                                        <span class="score-label">=Weak, </span>
                                        <span class="score-strong">4</span>
                                        <span class="score-label">=Strong)</span>
                                    </div>

                                    <div class="suggestions-section">
                                        <span class="suggestions-label">Suggestions:</span>
                                        <span class="suggestions-text"><%= suggestion %></span>
                                    </div>
                                <% } %>
                             
                        </div>
                    </div>
                </div>
            </main>
        </div>
    </div>
</body>
</html>
