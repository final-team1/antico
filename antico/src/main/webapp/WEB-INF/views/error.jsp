<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>CHILL ERROR 😎</title>
    <style>
        body {
            background: url('https://antico-uploads-files.s3.ap-northeast-2.amazonaws.com/error/chill_guy_img.jpg') no-repeat center center fixed;
            background-size: cover;
            color: white;
            font-family: "Comic Sans MS", sans-serif;
            text-align: center;
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            height: 100vh;
            margin: 0;
        }
        h1 {
            font-size: 2.5rem;
            text-shadow: 2px 2px 10px rgba(0, 0, 0, 0.2);
        }
        .chill-guy {
            font-size: 5rem;
            animation: chill 2s infinite alternate;
        }
        @keyframes chill {
            from { transform: translateY(0px); }
            to { transform: translateY(10px); }
        }
        .btn {
            padding: 15px 25px;
            font-size: 1.2rem;
            background: #222;
            color: white;
            border: none;
            border-radius: 10px;
            cursor: pointer;
            transition: 0.3s;
            margin-top: 20px;
        }
        .btn:hover {
            background: #555;
        }
    </style>
</head>
<body>
    <h1>에러가 나도 <span class="chill-guy">😎</span> CHILL하게 넘기자</h1>
    <h1>그렇지만 해결은 해야해!</h1>

    <button class="btn" onclick="window.location.href='${pageContext.request.contextPath}/'">홈으로 가기</button>
    <button class="btn" onclick="playMusic()">🎵 Chill 음악 재생</button>

    <audio id="chillAudio" src="https://antico-uploads-files.s3.ap-northeast-2.amazonaws.com/error/chill_guy_bgm.mp3" preload="auto"></audio>

    <script>
        function playMusic() {
            const audio = document.getElementById("chillAudio");
            audio.play()
                .then(() => console.log("🎶 MP3 재생 시작!"))
                .catch(e => console.log("❌ 재생 차단됨:", e));
        }
    </script>
</body>
</html>
