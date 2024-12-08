<%@ page import="java.util.List" %>
<%@ page import="project.demo.Dot" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>

<html lang="ru">
<head>
    <meta charset="UTF-8" >
    <meta name="viewport" content="width=device-width, initial-scale=1.0" >
    <title>Лабораторная</title>
    <link rel="stylesheet" href="style.css">
    <script>
        "use strict";
        // минимальные и максимальные значения для проверок
        // частично избыточно, так как в кнопках и выпадающем списке
        // заданы списком значений. По идее проверять нужно только input text
        let minX = -5; let maxX = 3;
        let minY = -3; let maxY = 3;
        let minR = 0;  let maxR = 3;

        // ***
        // Ширина и высота квадратной области. Размер можно определить так: по 50px на единицу шкалы в обе стороны + припуск для стрелок и пр.
        // Например, шкала 5, 50px на единицу (от -5 до 5) получается 500px + по 50px отступы от стрелок + по 10px отступ от стрелок до границы канваса. итого: 620px
        // можно в принципе значения наугад, но тогда с округлениями может быть не все хорошо
        const intSize = 620;
        // отступы осей от края
        const padding = 10;
        // цвет осей
        const color = "green";
        // размерность шкалы (в каждую сторону от 0)
        const scale = 4;
        // расстояние между рисками
        const gap = Math.floor((intSize-padding*2)/((scale+1)*2));
        // высота рисок
        const markHeight = 5;
        // координаты осей
        const axisXY = Math.floor(intSize/2); // координаты осей. По х или у в зависимости от необходимости. По сути - центр квадрата. Если область прямоугольная, для х и у нужно считать отдельно

        // *************************************
        // *************************************
        let R = 0; //главная переменная
        // *************************************
        // *************************************
        //function drawX(ctx, size, padding, color) {
        function drawAxis(cnv, ctx, color) {

            let arrowWidth = 2; // половина ширины
            let arrowHeight = 10; // длина

            ctx.strokeStyle = "black";
            ctx.fillStyle = "black";
            // нарисовать оси
            // x
            ctx.beginPath();
            ctx.moveTo(padding, axisXY);
            ctx.lineTo(cnv.width-padding, axisXY);
            ctx.stroke();
            // y
            ctx.beginPath();
            ctx.moveTo(axisXY, padding);
            ctx.lineTo(axisXY, cnv.height-padding);
            ctx.stroke();
            // нарисовать стрелки
            // x
            ctx.beginPath();
            ctx.moveTo(cnv.width-padding-arrowHeight, axisXY-arrowWidth);
            ctx.lineTo(cnv.width-padding, axisXY);
            ctx.lineTo(cnv.width-padding-arrowHeight, axisXY+arrowWidth);
            ctx.stroke();
            // y
            ctx.beginPath();
            ctx.moveTo(axisXY-arrowWidth, padding+arrowHeight);
            ctx.lineTo(axisXY, padding);
            ctx.lineTo(axisXY+arrowWidth, padding+arrowHeight);
            ctx.stroke();
            // шкала. Считаем, что она на одну единицу больше. чем задано в значениях х и у (чтобы место для стрелок и пр. осталось)
            // считаем от центра.
            let startX = axisXY- scale*gap
            let startY = axisXY - scale*gap
            ctx.beginPath();
            for (let i = startX; i < startX * scale * 2; i += gap) {
                ctx.moveTo(i, axisXY-markHeight);
                ctx.lineTo(i, axisXY);
            }
            for (let i = startY; i < startY * scale * 2; i += gap) {
                ctx.moveTo(axisXY+markHeight, i);
                ctx.lineTo(axisXY, i);
            }
            ctx.stroke();
            // рисуем буковки
            ctx.font = "20px Arial";
            ctx.fillText("Y", axisXY+10, padding+20);
            ctx.fillText("X", intSize-padding-15, axisXY-10);
        }
        // рисуем области действия. Функции статические. Если нужно нарисовать в другом квадранте или по другим формулам, просто меняем код
        function drawCircle(ctx, R) {
            R = (R * gap)/2; // радиус R/2 - в задании
            ctx.strokeStyle = "#7FC7FF";
            ctx.fillStyle = "#7FC7FF";
            ctx.beginPath();
            ctx.moveTo(axisXY, axisXY);
            ctx.lineTo(axisXY+ R, axisXY);
            ctx.arc(axisXY, axisXY, R, 0, 0.5*Math.PI)
            ctx.lineTo(axisXY, axisXY);
            ctx.fill();
        }
        function drawRectangle(ctx, R) {
            R = R * gap;
            ctx.fillRect(axisXY, axisXY, -1*R, R/2);
        }
        function drawTriangle(ctx, R) {
            R = R * gap;
            ctx.beginPath();
            ctx.moveTo(axisXY, axisXY);
            ctx.lineTo(axisXY, axisXY-R);
            ctx.lineTo(axisXY-R, axisXY);
            ctx.moveTo(axisXY, axisXY);
            ctx.fill();
        }
        function drawDot(ctx, x, y) {
            ctx.fillStyle = "red"
            ctx.beginPath();
            ctx.arc(x, y, 5, 0, 2 * Math.PI);
            ctx.fill();
        }
        function DrawCanvas(intSize, R) {
            var intBlock = document.getElementById("interactive");
            var ctx = intBlock.getContext('2d');
            intBlock.width  = intSize;
            intBlock.height = intSize;
            ctx.strokeRect(0, 0, intBlock.width, intBlock.height);
            intBlock.addEventListener('mousedown', function(e) {getCursorPosition(ctx, intBlock, e)});
            drawCircle(ctx,R);
            drawRectangle(ctx, R);
            drawTriangle(ctx, R);
            drawAxis(intBlock, ctx, color);
            if (R !=0) {
                ctx.fillText("R", axisXY + R * gap -8 , axisXY-10);
                ctx.fillText("R", axisXY + 10, axisXY - R * gap + 8);
            }
        }
        /* получает значения координат клика по канвасу, пересчитывает в координаты задания
        рисует точку в месте клика *** возможно, в этом месте нужна задаржка, чтобы увидеть точку до того, как форма отправится на сервер ***
        проверяет радиус на "не ноль", если норм - вызывает событие submit формы и отсылает данные на сервер */
        function getCursorPosition(ctx, canvas, event) {
            let pos = {};
            const rect = canvas.getBoundingClientRect()
            //            const x = parseFloat(((event.clientX - rect.left - axisXY)/gap).toFixed(4));
            //            const y = parseFloat(((event.clientY - rect.top - axisXY)/gap * -1).toFixed(4));
            const x = (event.clientX - rect.left);
            const y = (event.clientY - rect.top);
            const r = Number(document.getElementById("valR").value); // берем отсюда потому ,что там уже валидированное значение
            const roundedX = parseFloat(((x - axisXY)/gap).toFixed(4));
            const roundedY = parseFloat(((y - axisXY)/gap * -1).toFixed(4));
            if (r==0) {
                alert ("Должен быть задан радиус");
                return 0;
            }
            else {
                document.getElementById("valX").value = roundedX;
                document.getElementById("valY").value = roundedY;
                drawDot(ctx, x, y);
                console.log("x: " + roundedX + " y: " + roundedY);
                //document.getElementById("calcform").submit();
            }
        }
        // при клике на кнопку должна проверить, не ноль ли R
        function checkR0() {
            const r = Number(document.getElementById("valR").value); // берем отсюда потому ,что там уже валидированное значение
            if (r==0) {
                alert ("Должен быть задан радиус");
                return false;
            }
            else {
                return true;
            }
        }
        //***
        function setX(button) {
            // сначала по имени берем массив кнопок и находим кнопку с тенью. тень убираем
            let allbuttons = document.getElementsByName("varX");
            for (var i = 0; i < allbuttons.length; i++) {
                if (allbuttons[i].getAttribute("selected")) {
                    allbuttons[i].removeAttribute("selected");
                }
            }
            // затем рисуем тень у кнопки, которую нажали (присваиваем аттрибут selected)
            button.setAttribute("selected", true);
            let val = validateN(button.value, minX, maxX);
            if (typeof val === "number") {
                document.getElementById("valX").value = button.value;
            }
        }
        function setY(id) {
            // Передается id текстбокса, чтобы можно было установить его значение после очистки
            // По умолчанию значения - текстовые. Это нужно только для проверки валидности ввода.
            // на сервере всё равно нужно проверять все значения всех полей.

            // алгоритм такой: если валидация не проходит, в текстбоксе остается старый текст,
            // индикатор "Y=" не меняется, "Результат" не меняется. Под текстбоксом появляется
            // красная строчка с ошибкой.
            // Старый текст в текстбоксе для того, чтобы можно было исправить опечатку, не перебивая весь текст.
            let val = validateN(id.value, minY, maxY);
            // если просто проверить на 0, 0==false в js
            if (typeof val === "number") {
                document.getElementById("valY").value = val;
                document.getElementById("errormessage").innerHTML = "";
                // устанавливает нормализованную строку в поле ввода. без лишних нулей, с точкой вместо запятой и тд
                id.value = val;
            } else {
                document.getElementById("errormessage").innerHTML = "Здесь должно быть число от -3 до 3. вычисления не производятся";
            }
        }
        function setR(select) {
            let r = validateN(select.value, minR, maxR);
            if (typeof(r) === "number") {
                document.getElementById("valR").value = r;
                DrawCanvas(intSize, r);
            }
        }
        function validateN(n, min, max) {
            n = is_number(n);
            if (typeof n === "number") {
                if (n >= min && n <= max) {
                    return (n);
                }
            }
            return(false);
        }
        function is_number(str) {
            // считаем, что запятую можно использовать как разделитель
            // точка в начале допустима, в конце - нет
            let val = 0;
            if (/^[\-]*[0-9]*[.,]?[0-9]+$/.test(str)) {
                // запятая не является десятичным разделителем, но мы меняем ее на точку
                // и считаем, что ввели точку. А в текстбоксе потом поменяем запятую на точку.
                // Подразумевается, что локаль русская, нет разделителей разрядов в виде запятой, пробелов и т.д.
                val = Number(str.replace(",", "."));
            } else {
                val = false;
            }
            return val;
        }

        /* init - начальные значения контролов и полей X, Y, R. Полностью хардкод
        у селекта дефолтное значение вписано прямо в код
        в принципе можно добавить массивы начальных значений
        и при загрузке страницы генерить контролы по этим значениям, тогда программа
        будет более универсальной. Эти же массивы можно использовать как списки
        допустимых значений */
        function init() {
            document.getElementById("y").value = 0; // поле ввода. по умолчанию 0
            document.getElementById("varX6").setAttribute("selected", true); // дефолтная кнопка 0 в середине списка
            document.getElementById("valX").value = 0;
            document.getElementById("valY").value = 0;
            document.getElementById("valR").value = 0;
            document.getElementById("errormessage").innerHTML = "";
            DrawCanvas(intSize, R);
        }

        function calc() {

            let vars = {};

            vars.x = document.getElementById("valX").innerHTML;
            vars.y = document.getElementById("valY").innerHTML;
            vars.r = document.getElementById("valR").innerHTML;


            try {
                let response =  fetch("/api/", {
                    method: "POST",
                    headers: {
                        "Content-Type": "application/json; charset=utf-8",
                        "Accept": "application/json",
                    },
                    body: JSON.stringify(vars),
                })
                    .then((response) =>
                        response.text())
                    .then((text) =>{
                        const data = JSON.parse(text);
                        showResult(data.status, vars)
                        return 1
                    })
                    .catch(
                        console.log("1")
                    )





            }
            catch(error) {
                console.log("Произошла ошибка:", error);
            }
        }
    </script>
</head>

<body onload="init()">
<header>
    <h1>Лабораторная</h1>
</header>

<form id = "calcform" method = "POST" action = "http://127.0.0.1:8080/areacheck">
    <div class="index">
        <div class="contentblock">
            <canvas id='interactive'>Обновите браузер</canvas>
            <div id="XY" class="valN"></div>
            <!-- инпуты valX, valY, valR что-то вроде временных переменных. В них попадают либо пересчитанные и округленные
            значения клика мышкой в канвасе, либо значения из полей выбора справа. Сделаны в виде полей ввода с аттрибутом readonly.
            Именно их нужно использовать на сервере.
            По идее после клика мышкой форма должна сразу отправляться, т.е. нет варианта сначала выбрать координаты
            на канвасе, а потом изменить только один из них в форме -->
            <div class="valN"><label for="valX">X =</label><input id="valX" name="valX" readonly></div>
            <div class="valN"><label for="valY">Y =</label><input id="valY" name="valY" readonly></div>
            <div class="valN"><label for="valR">R =</label><input id="valR" name="valR" readonly></div>
        </div>
        <div class="contentblock">
            <div>
                <h2>Переменные</h2>
            </div>
            <fieldset id="x">
                <legend>Выбор X</legend>
                <button id="varX1" type="button" name="varX" value="-5" onclick="setX(this)">-5</button>
                <button id="varX2" type="button" name="varX" value="-4" onclick="setX(this)">-4</button>
                <button id="varX3" type="button" name="varX" value="-3" onclick="setX(this)">-3</button>
                <button id="varX4" type="button" name="varX" value="-2" onclick="setX(this)">-2</button>
                <button id="varX5" type="button" name="varX" value="-1" onclick="setX(this)">-1</button>
                <button id="varX6" type="button" name="varX" value="0" onclick="setX(this)">0</button>
                <button id="varX7" type="button" name="varX" value="1" onclick="setX(this)">1</button>
                <button id="varX8" type="button" name="varX" value="2" onclick="setX(this)">2</button>
                <button id="varX9" type="button" name="varX" value="3" onclick="setX(this)">3</button>
            </fieldset>
            <div>
                <label for="y">Выбор Y</label>
                <input id="y" name ="y" type="text" placeholder="-3...3" onchange="setY(this)" >
                <div id="errormessage">-</div>
            </div>
            <div>
                <label for="r">Выбор R</label>
                <select name="varR" id="r" onchange="setR(this)">
                    <option value="3">3</option>
                    <option value="2.5">2.5</option>
                    <option value="2">2</option>
                    <option value="1.5">1.5</option>
                    <option value="1">1</option>
                    <option value="0" selected>0</option>
                </select>
            </div>
            <div class="warning">
                <p>Внимание: При изменении координат точки на графике, значения в полях выбора не меняются!</p>
                <p>При нажатии кнопки "рассчитать" берутся текущие значения (слева внизу).</p>
            </div>
            <div class="bottomline">
                <!-- checkR0() не дает посылать данные, если R=0 -->
                <button type="submit" id="b" class="num sbutton" onclick="return checkR0();">Рассчитать</button>
            </div>
            <div class ="resulttable">
                <table class="table">
                    <thead>
                    <tr>
                        <th scope="col">Результат</th>
                        <th scope="col">X</th>
                        <th scope="col">Y</th>
                        <th scope="col">R</th>
                    </tr>
                    </thead>
                    <tbody>
                   <%
                       List<Dot> dots = (List<Dot>) request.getSession().getAttribute("dots");
                   %>
                    <%
                        if(dots != null){
                            for (Dot dot : dots) {
                    %>
                            <tr>
                                <td><%= String.valueOf(dot.getX())%></td>
                                <td><%= String.valueOf(dot.getY())%></td>
                                <td><%= String.valueOf(dot.getR())%></td>
                                <td><%= dot.getStatus() ? "Попадание" : "Промах"%></td>
                            </tr>
                   <%
                            }
                        }
                   %>

                    </tbody>
                </table>
            </div>
        </div>
    </div>
</form>

</body>
</html>
