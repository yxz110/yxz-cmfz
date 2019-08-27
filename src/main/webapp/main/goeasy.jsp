<%@page pageEncoding="UTF-8" isELIgnored="false" contentType="text/html; utf-8" %>

<!doctype html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport"
          content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>Document</title>
    <script src="​http(s)://cdn-hangzhou.goeasy.io/goeasy.js​"></script>
</head>
<body>

<script>
    var goEasy = new GoEasy({
        appkey: "BC-83d8b11f69dd4897904cfcf5e9d36dab"
    });
    goEasy.subscribe({
        channel: "my_channel",
        onMessage: function (message) {
            alert("Channel:" + message.channel + " content:" + message.content);
        }
    });
</script>
ssssss
</body>
</html>