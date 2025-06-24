<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Custom Wordlist Generator</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <style>
        @import url("https://fonts.googleapis.com/css2?family=Inter:wght@400;700&display=swap");
        body {
            font-family: 'Inter', sans-serif;
            color:#4f0084;
            background: black;
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 20px;
            flex-direction: column;
        }
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
            overflow-y: auto; 
            animation: glow 3s ease-in-out infinite;
            padding: 40px;
            scrollbar-width: thin;
            scrollbar-color: #4f0084 transparent; /* thumb color purple, track invisible */
        }

        /* Chrome, Safari, Edge */
        .card::-webkit-scrollbar {
            width: 6px;
        }

        .card::-webkit-scrollbar-track {
            background: transparent; /* no track/bar */
        }

        .card::-webkit-scrollbar-thumb {
            background-color: #4f0084;  /* purple scroll thumb */
            border-radius: 10px;
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
        <div class="tab"><a href="password_generator.jsp">Password Generator</a></div>
        <div class="tab active">Custom Wordlist Generator</div>
    </div>
     <br> <br><br><br><br>
<div class="card">
    <h1 class="text-4xl text-center text-purple-900 font-bold mb-10">Custom Wordlist Generator</h1>
    <form id="wordlistForm" onsubmit="return false;">
        <div class="form-field mb-6">
            <label class="block text-purple-800 font-bold text-lg mb-1" for="name">Enter your name:</label>
            <input type="text" id="name" class="w-full border border-purple-600 rounded px-4 py-2" required>
        </div>

        <div class="form-field mb-6">
            <label class="block text-purple-800 font-bold text-lg mb-1" for="birthYear">Enter your birth year:</label>
            <input type="number" id="birthYear" class="w-full border border-purple-600 rounded px-4 py-2" required>
        </div>

        <div class="form-field mb-6">
            <label class="block text-purple-800 font-bold text-lg mb-1" for="color">Enter your favourite colour:</label>
            <input type="text" id="color" class="w-full border border-purple-600 rounded px-4 py-2" required>
        </div>

        <div class="form-field mb-6">
            <label class="block text-purple-800 font-bold text-lg mb-1" for="extraQuestions">Do you want to add extra personal questions? (yes/no):</label>
            <input type="text" id="extraQuestions" class="w-40 border border-purple-600 rounded px-4 py-2" required>
        </div>

        <div id="qaContainer"></div>

    </form>

    <div id="wordlistOutput" class="mt-6 text-purple-900 text-lg font-semibold"></div>
    <div id="downloadBtnContainer" class="mt-4"></div>
</div>

<script>
    const extraQuestionsInput = document.getElementById("extraQuestions");
    const qaContainer = document.getElementById("qaContainer");
    const outputDiv = document.getElementById("wordlistOutput");
    const downloadBtnContainer = document.getElementById("downloadBtnContainer");

    let extraAnswers = [];

    extraQuestionsInput.addEventListener("change", function () {
        const val = this.value.trim().toLowerCase();
        if (val === "yes") {
            addQAField();
        } else if (val === "no") {
            generateWordlist();
        } else {
            alert("Please type 'yes' or 'no'");
        }
    });

    function addQAField() {
        const qaDiv = document.createElement("div");
        qaDiv.classList.add("mb-6");

        qaDiv.innerHTML = `
            <div class="mb-2">
                <label class="block text-purple-800 font-bold text-lg mb-1">Enter a personal question (or type 'done' to finish):</label>
                <input type="text" class="questionInput w-full border border-purple-600 rounded px-4 py-2">
            </div>
        `;

        qaContainer.appendChild(qaDiv);

        const questionInput = qaDiv.querySelector(".questionInput");
        questionInput.focus();

        questionInput.addEventListener("change", function () {
    const question = this.value.trim();
    if (question.toLowerCase() === "done") {
        extraQuestionsInput.value = "no";
        generateWordlist();
        return;
    }

    if (question !== "") {
        setTimeout(() => {
            const answerDiv = document.createElement("div");
            answerDiv.classList.add("mb-6");

            // Use template literal correctly here
            answerDiv.innerHTML = `
                <label class="block text-purple-800 font-bold text-lg mb-1">
                    Your answer :
                </label>
                <input type="text" class="answerInput w-full border border-purple-600 rounded px-4 py-2">
            `;

            qaContainer.appendChild(answerDiv);

            const answerInput = answerDiv.querySelector(".answerInput");
            answerInput.focus();
            answerInput.addEventListener("change", function () {
                const answer = this.value.trim();
                if (answer) extraAnswers.push(answer);
                addQAField();
            });
        }, 0); // Delay ensures DOM updates after value is correctly read
    }
});

    }

    function generateWordlist() {
        const name = document.getElementById("name").value.trim();
        const year = document.getElementById("birthYear").value.trim();
        const color = document.getElementById("color").value.trim();

        if (!name || !year || !color) {
            alert("Please fill all fields correctly.");
            return;
        }

        const allWords = [name, year, color, ...extraAnswers];
        let wordlist = [];

        function permute(arr, prefix = "") {
            if (arr.length === 0) {
                if (prefix) wordlist.push(prefix);
                return;
            }
            for (let i = 0; i < arr.length; i++) {
                const newPrefix = prefix + arr[i];
                const rest = arr.slice(0, i).concat(arr.slice(i + 1));
                permute(rest, newPrefix);
            }
        }

        permute(allWords);
        wordlist = [...new Set(wordlist)];

        outputDiv.innerHTML = '<div class="mb-2">Generated ' + wordlist.length + ' passwords:</div>' +
            '<textarea class="w-full p-3 border border-purple-500 rounded bg-white text-sm" rows="10">' +
            wordlist.join('\n') + '</textarea>';

        const blob = new Blob([wordlist.join("\n")], { type: "text/plain" });
        const url = URL.createObjectURL(blob);

        downloadBtnContainer.innerHTML = '<a href="' + url + '" download="custom_wordlist.txt" class="inline-block mt-3 px-4 py-2 bg-purple-700 text-white rounded hover:bg-purple-900 transition">Download Wordlist</a>';
    }
</script>
</body>
</html>
