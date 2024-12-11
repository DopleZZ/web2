<%@ page import="java.util.List" %>
<%@ page import="project.demo.Dot" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>

<html lang="ru">
<head>
    <meta charset="UTF-8" >
    <meta name="viewport" content="width=device-width, initial-scale=1.0" >
    <title>Лабораторная Бондаренко Р3210</title>
    <link rel="stylesheet" href="style.css">
    <script src="script.js"></script>
</head>

<body onload="init()">
<header>
    <h1>Лабораторная</h1>
</header>


    <div class="index">
        <div class="contentblock">
            <%

                String svg = (String) request.getSession().getAttribute("svg");
            %>

            <%
                if (svg != null) {
                    %>
            <svg xmlns="http://www.w3.org/2000/svg" version="1.1" width="620" height="620" id="svg"><%= svg %></svg>
            <%
                } else {
            %>
            <svg xmlns="http://www.w3.org/2000/svg" version="1.1" width="620" height="620" id="svg"></svg>
             <% } %>
            <div id="XY" class="valN"></div>
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
                    <option value="1" selected>1</option>
                    <option value="0">0</option>
                </select>
            </div>
            <div class="warning">
                <p>При нажатии кнопки "рассчитать" берутся текущие значения (слева внизу).</p>
            </div>
            <div class="bottomline">

                <button type="button" id="b" class="num sbutton" onclick="return checkR0();">Рассчитать</button>
            </div>
            <div class ="resulttable">
                <table class="table" id="tablichka">
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
                                <td><%= dot.getStatus() ? "Попадание" : "Промах"%></td>
                                <td><%= String.valueOf(dot.getX())%></td>
                                <td><%= String.valueOf(dot.getY())%></td>
                                <td><%= String.valueOf(dot.getR())%></td>
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


</body>
</html>
