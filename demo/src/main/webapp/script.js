"use strict";

let minX = -5; let maxX = 3;
let minY = -3; let maxY = 3;
let minR = 0;  let maxR = 3;







const padding = 10;

const color = "green";

const scale = 4;


const intSize = 620;

const gap = Math.floor((intSize-padding*2)/((scale+1)*2));
const markHeight = 5;

const axisXY = Math.floor(intSize/2);


let R = 1;

function drawCircle(svg, R) {
    R = (R * gap)/2;
    let strokeStyle = "#7FC7FF";
    let fillStyle = "#7FC7FF";
    var newElement = document.createElementNS("http://www.w3.org/2000/svg", 'path');
    let endY = 310 + R;
    let startX = 310 + R;
    var CirclePath = `M ${startX} 310 A ${R} ${R} 0 0 1 310 ${endY} L 310 310 z`
    newElement.setAttribute("d",CirclePath); //Set path's data
    newElement.style.fill = fillStyle;
    newElement.style.stroke = strokeStyle;
    newElement.style.strokeWidth = "1px";
    svg.appendChild(newElement);
}
function drawRectangle(svg, R) {
    R = R * gap;
    let strokeStyle = "#7FC7FF";
    let fillStyle = "#7FC7FF";
    var rect = document.createElementNS("http://www.w3.org/2000/svg", 'rect');
    let rHeight = R/2;
    let rWidth = R;
    let startX = 310 - R;
    rect.setAttribute('x', startX);
    rect.setAttribute('y', '310');
    rect.setAttribute('height', rHeight);
    rect.setAttribute('width', rWidth);
    rect.style.fill = fillStyle;
    rect.style.stroke = strokeStyle;
    rect.style.strokeWidth = "1px"; //Set stroke width
    svg.appendChild(rect);
}
function drawTriangle(svg, R) {
    R = R * gap;
    var tri = document.createElementNS("http://www.w3.org/2000/svg", 'path');
    let strokeStyle = "#7FC7FF";
    let fillStyle = "#7FC7FF";
    let endX = 310 - R;
    let endY = 310 - R;
    var triPath = `M 310 310 L ${endX} 310 L 310 ${endY} z`
    tri.setAttribute("d",triPath);
    tri.style.fill = fillStyle;
    tri.style.stroke = strokeStyle;
    tri.style.strokeWidth = "1px";
    svg.appendChild(tri);
}

function drawAxis(ctx, R) {
    const svg = document.getElementById("svg");


    const rect = document.createElementNS("http://www.w3.org/2000/svg", "polygon");
    rect.setAttribute("points", "0,0 0,620 620,620 620,0");
    rect.setAttribute("stroke", "#000");
    rect.setAttribute("stroke-width", "1");
    rect.setAttribute("fill", "#fff");
    rect.setAttribute("fill-rule", "nonzero");
    svg.appendChild(rect);
    const verticalLine = document.createElementNS("http://www.w3.org/2000/svg", "line");
    verticalLine.setAttribute("x1", "310");
    verticalLine.setAttribute("y1", "10");
    verticalLine.setAttribute("x2", "310");
    verticalLine.setAttribute("y2", "610");
    verticalLine.setAttribute("stroke", "#000");
    verticalLine.setAttribute("stroke-width", "1");
    svg.appendChild(verticalLine);
    const horizontalLine = document.createElementNS("http://www.w3.org/2000/svg", "line");
    horizontalLine.setAttribute("x1", "10");
    horizontalLine.setAttribute("y1", "310");
    horizontalLine.setAttribute("x2", "610");
    horizontalLine.setAttribute("y2", "310");
    horizontalLine.setAttribute("stroke", "#000");
    horizontalLine.setAttribute("stroke-width", "1");
    svg.appendChild(horizontalLine);
    const arrowY = document.createElementNS("http://www.w3.org/2000/svg", "polygon");
    arrowY.setAttribute("points", "308,20 310,10 312,20");
    arrowY.setAttribute("stroke", "#000");
    arrowY.setAttribute("stroke-width", "1");
    arrowY.setAttribute("fill", "#000");
    svg.appendChild(arrowY);
    const arrowX = document.createElementNS("http://www.w3.org/2000/svg", "polygon");
    arrowX.setAttribute("points", "600,308 610,310 600,312");
    arrowX.setAttribute("stroke", "#000");
    arrowX.setAttribute("stroke-width", "1");
    arrowX.setAttribute("fill", "#000");
    svg.appendChild(arrowX);
    const yLines = [70, 130, 190, 250, 370, 430, 490, 550];
    yLines.forEach(y => {
        const line = document.createElementNS("http://www.w3.org/2000/svg", "line");
        line.setAttribute("x1", "310");
        line.setAttribute("y1", y);
        line.setAttribute("x2", "315");
        line.setAttribute("y2", y);
        line.setAttribute("stroke", "#000");
        line.setAttribute("stroke-width", "1");
        svg.appendChild(line);
    });
    const xLines = [70, 130, 190, 250, 370, 430, 490, 550];
    xLines.forEach(x => {
        const line = document.createElementNS("http://www.w3.org/2000/svg", "line");
        line.setAttribute("x1", x);
        line.setAttribute("y1", "310");
        line.setAttribute("x2", x);
        line.setAttribute("y2", "305");
        line.setAttribute("stroke", "#000");
        line.setAttribute("stroke-width", "1");
        svg.appendChild(line);
    });
    const textY = document.createElementNS("http://www.w3.org/2000/svg", "text");
    textY.setAttribute("x", "320");
    textY.setAttribute("y", "20");
    textY.setAttribute("class", "small");
    textY.textContent = "Y";
    svg.appendChild(textY);
    const textX = document.createElementNS("http://www.w3.org/2000/svg", "text");
    textX.setAttribute("x", "600");
    textX.setAttribute("y", "300");
    textX.setAttribute("class", "small");
    textX.textContent = "X";
    svg.appendChild(textX);
}

let dots = [];
let dots_copy = [];

function drawDot(svg, x, y) {
    let fillStyle = "red";
    var circle = document.createElementNS("http://www.w3.org/2000/svg", 'circle');
    circle.setAttribute('cx', x);
    circle.setAttribute('cy', y);
    circle.setAttribute('r', 5);
    circle.style.fill = fillStyle;
    circle.strokeStyle = fillStyle;
    circle.style.strokeWidth = "1px";
    svg.appendChild(circle);
}


function DrawCanvas(intSize, R) {
    var ctx  = document.getElementsByTagName('svg')[0];
    drawAxis(ctx, R)
    drawCircle(ctx,R);
    drawRectangle(ctx, R);
    drawTriangle(ctx, R);

}

function getCursorPosition(ctx, event) {
    let pos = {};
    const rect = ctx.getBoundingClientRect()

    const x = (event.clientX - rect.left);
    const y = (event.clientY - rect.top);
    const r = Number(document.getElementById("valR").value);
    const roundedX = parseFloat(((x - axisXY)/gap).toFixed(4));
    const roundedY = parseFloat(((y - axisXY)/gap * -1).toFixed(4));
    if (r==0) {
        alert ("Должен быть задан радиус");
        return 0;
    }
    else {
        document.getElementById("valX").value = roundedX;
        document.getElementById("valY").value = roundedY;

        console.log("x: " + roundedX + " y: " + roundedY);
        calc();
    }
}

function checkR0() {
    const r = Number(document.getElementById("valR").value);
    var ctx = document.getElementById("svg");

    if (r===0) {
        alert ("Должен быть задан радиус");
        return false;
    }
    else {
        let physicalX = axisXY + Number(document.getElementById("valX").value) * gap;
        let physicalY = axisXY - Number(document.getElementById("valY").value) * gap;
        drawDot(ctx, physicalX, physicalY);
        calc();

        return true;
    }
}

function setX(button) {
    let allbuttons = document.getElementsByName("varX");
    for (var i = 0; i < allbuttons.length; i++) {
        if (allbuttons[i].getAttribute("selected")) {
            allbuttons[i].removeAttribute("selected");
        }
    }

    button.setAttribute("selected", true);
    let val = validateN(button.value, minX, maxX);
    if (typeof val === "number") {
        document.getElementById("valX").value = button.value;
    }
}
function setY(id) {
    let val = validateN(id.value, minY, maxY);
    if (typeof val === "number") {
        document.getElementById("valY").value = val;
        document.getElementById("errormessage").innerHTML = "";
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
    let val = 0;
    if (/^[\-]*[0-9]*[.,]?[0-9]+$/.test(str)) {
        val = Number(str.replace(",", "."));
    } else {
        val = false;
    }
    return val;
}

function reviveSVG() {
    console.log(document.getElementById("svg").innerHTML)
    if (document.getElementById("svg").innerHTML === "") {

        DrawCanvas(intSize, R);
    }
}


function init() {
    document.getElementById("y").value = 0;
    document.getElementById("varX6").setAttribute("selected", true);
    document.getElementById("valX").value = 0;
    document.getElementById("valY").value = 0;
    document.getElementById("valR").value = 1;
    document.getElementById("errormessage").innerHTML = "";
    reviveSVG();
    var ctx = document.getElementById("svg");
    ctx.addEventListener('mousedown', function(e) {getCursorPosition(ctx, e)});





}

function calc() {

    let vars = {};

    vars.x = document.getElementById("valX").value;
    vars.y = document.getElementById("valY").value;
    vars.r = document.getElementById("valR").value;
    vars.svg = document.getElementById("svg").innerHTML;


    console.log(vars.x, vars.y, vars.r)



        let response =  fetch("/controller", {
            method: "POST",
            headers: {
                "Content-Type": "application/json; charset=utf-8",
                "Accept": "application/json",
            },
            body: JSON.stringify(vars),
        })
            .then(response => response.json())
            .then(data => {

                console.log(data)
                console.log("post")
                let row = document.createElement('tr');
                row.innerHTML = `
                <td>${data.status}</td>
                <td>${data.x}</td>
                <td>${data.y}</td>
                <td>${data.r}</td>
                `;
                document.getElementById("svg").innerHTML = data.svg;
                document.getElementById('tablichka').prepend(row)
            })
            .catch(
                console.log("error while fetch")
            )
}

