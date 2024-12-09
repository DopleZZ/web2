package project.demo;


import com.google.gson.Gson;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.ArrayList;


public class AreaCheckServlet extends HttpServlet {
    AreaChecker areaChecker = new AreaChecker();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
        int x = (int) request.getAttribute("x");
        double y = (double) request.getAttribute("y");
        double r = (double) request.getAttribute("r");

        Dot dot = new Dot(x,y,r);
        try {
            dot.setStatus(areaChecker.isInTheSpot(dot));
        } catch (Exception e) {
            throw new RuntimeException(e);
        }

        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        String resp = String.format("{\"x\":%d,\"y\":%.2f,\"r\":%.2f,\"status\":\"%s\"}",
                dot.getX(), dot.getY(), dot.getR(), dot.getStatus());

        response.getWriter().write(resp);



    }
}
