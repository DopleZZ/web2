package project.demo;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;
import project.demo.reqops.ReqCompiler;
import project.demo.reqops.RequestBody;

import java.io.IOException;

public class ControllerServlet extends HttpServlet {

    ReqCompiler comp = new ReqCompiler();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        System.out.println("got request");

        RequestBody body = comp.toBody(request);

        System.out.println(body.getX());
        System.out.println(body.getY());
        System.out.println(body.getR());


        if (body.getX() == 0 &
                body.getY() == 0 &
                body.getR() == 0) {
            System.out.println("1111");
            request.getRequestDispatcher("index.jsp").forward(request, response);
        } else {
            request.setAttribute("x", body.getX());
            request.setAttribute("y", body.getY());
            request.setAttribute("r", body.getR());
            request.getRequestDispatcher("/areacheck").forward(request, response);

        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException {
        response.setStatus(HttpServletResponse.SC_METHOD_NOT_ALLOWED);
        String answer = "{ error: Method not allowed}";
        response.getWriter().write(answer);
    }
}
