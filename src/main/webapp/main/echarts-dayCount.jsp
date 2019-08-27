<%@page pageEncoding="UTF-8" isELIgnored="false" contentType="text/html; utf-8" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set value="${pageContext.request.contextPath}" var="path"></c:set>
<!doctype html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport"
          content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>Document</title>
    <link rel="icon" href="../img/favicon.ico">
    <script src="../echarts/echarts.min.js"></script>
    <script src="../boot/js/jquery-2.2.1.min.js"></script>
    <script src="../echarts/china.js"></script>
    <script src="http://cdn-hangzhou.goeasy.io/goeasy.js"></script>

    <script>
        $(function () {
            var myChart = echarts.init(document.getElementById('main'));
            var option = {
                title: {
                    text: '七天注册变化'
                },
                tooltip: {},
                legend: {
                    data: ['注册量']
                },
                xAxis: {
                    data: ["1天内", "2天内", "3天内", "4天内", "5天内", "6天内", "7天内"]
                },
                yAxis: {},

            };
            myChart.setOption(option);

            $.ajax({
                url: "${pageContext.request.contextPath}/user/getByDayCount",
                datatype: "json",
                type: "post",
                success: function (data) {
                    //console.log(result);
                    console.log(data);
                    myChart.setOption({
                        series: [{
                            // 根据名字对应到相应的系列
                            name: '注册量',
                            type: 'line',
                            data: [data.one, data.two, data.three, data.four, data.five, data.six, data.seven]
                        }]
                    });

                }
            })

            var goEasy = new GoEasy({appkey: "BS-4c66f7037cd8435da704698da0f2f81f"});
            goEasy.subscribe({
                channel: "my_channel",
                onMessage: function (message) {
                    console.log(message);
                    var result = JSON.parse(message.content);
                    myChart.setOption({
                        series: [{
                            data: result
                        }]
                    });
                }
            });

        })
    </script>
</head>
<body>

</body>
</html>