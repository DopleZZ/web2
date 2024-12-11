"use strict";

let minX = -5; let maxX = 3;
let minY = -3; let maxY = 3;
let minR = 0;  let maxR = 3;






const intSize = 620;

const padding = 10;

const color = "green";

const scale = 4;

const gap = Math.floor((intSize-padding*2)/((scale+1)*2));
const markHeight = 5;

const axisXY = Math.floor(intSize/2);


let R = 1;

function drawAxis(cnv, ctx, color) {

    let arrowWidth = 2;
    let arrowHeight = 10;

    ctx.strokeStyle = "black";
    ctx.fillStyle = "black";

    ctx.beginPath();
    ctx.moveTo(padding, axisXY);
    ctx.lineTo(cnv.width-padding, axisXY);
    ctx.stroke();

    ctx.beginPath();
    ctx.moveTo(axisXY, padding);
    ctx.lineTo(axisXY, cnv.height-padding);
    ctx.stroke();


    ctx.beginPath();
    ctx.moveTo(cnv.width-padding-arrowHeight, axisXY-arrowWidth);
    ctx.lineTo(cnv.width-padding, axisXY);
    ctx.lineTo(cnv.width-padding-arrowHeight, axisXY+arrowWidth);
    ctx.stroke();

    ctx.beginPath();
    ctx.moveTo(axisXY-arrowWidth, padding+arrowHeight);
    ctx.lineTo(axisXY, padding);
    ctx.lineTo(axisXY+arrowWidth, padding+arrowHeight);
    ctx.stroke();

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

    ctx.font = "20px Arial";
    ctx.fillText("Y", axisXY+10, padding+20);
    ctx.fillText("X", intSize-padding-15, axisXY-10);
}

function drawCircle(ctx, R) {
    R = (R * gap)/2;
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

let dots = [];
let dots_copy = [];

function drawDot(ctx, x, y) {
    ctx.fillStyle = "red"
    ctx.beginPath();
    console.log(x);
    console.log(y)
    ctx.arc(x, y, 5, 0, 2 * Math.PI);
    ctx.fill();
    dots.push({x,y});
    localStorage.setItem("dots", JSON.stringify(dots));
    console.log("draw dot")
}

function drawDots(){
    let intBlock = document.getElementById("interactive");
    let ctx = intBlock.getContext('2d');
    dots_copy = JSON.parse(localStorage.getItem("dots")) || [];
    dots_copy.forEach(dot => drawDot(ctx, dot.x, dot.y));

}

function DrawCanvas(intSize, R) {
    var intBlock = document.getElementById("interactive");
    var ctx = intBlock.getContext('2d');


    intBlock.width = intSize;
    intBlock.height = intSize;


    intBlock.replaceWith(intBlock.cloneNode(true));
    intBlock = document.getElementById("interactive");

    ctx = intBlock.getContext('2d');
    ctx.strokeRect(0, 0, intBlock.width, intBlock.height);


    intBlock.addEventListener('mousedown', function (e) {
        getCursorPosition(ctx, intBlock, e);
    });


    drawCircle(ctx, R);
    drawRectangle(ctx, R);
    drawTriangle(ctx, R);
    drawAxis(intBlock, ctx, color);

    if (R !== 0) {
        ctx.fillText("R", axisXY + R * gap - 8, axisXY - 10);
        ctx.fillText("R", axisXY + 10, axisXY - R * gap + 8);
    }
}

function getCursorPosition(ctx, canvas, event) {
    let pos = {};
    const rect = canvas.getBoundingClientRect()

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
        drawDot(ctx, x, y);
        console.log("x: " + roundedX + " y: " + roundedY);
        calc();
    }
}

function checkR0() {
    const r = Number(document.getElementById("valR").value);
    let intBlock = document.getElementById("interactive");
    let ctx = intBlock.getContext('2d');

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


function init() {
    document.getElementById("y").value = 0;
    document.getElementById("varX6").setAttribute("selected", true);
    document.getElementById("valX").value = 0;
    document.getElementById("valY").value = 0;
    document.getElementById("valR").value = 1;
    document.getElementById("errormessage").innerHTML = "";
    DrawCanvas(intSize, R);
    drawDots()

}

function calc() {

    let vars = {};

    vars.x = document.getElementById("valX").value;
    vars.y = document.getElementById("valY").value;
    vars.r = document.getElementById("valR").value;

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

                document.getElementById('tablichka').prepend(row)
            })
            .catch(
                console.log("error while fetch")
            )
}

