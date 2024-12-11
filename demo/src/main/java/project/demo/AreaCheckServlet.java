package project.demo;


import com.google.gson.Gson;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;


public class AreaCheckServlet extends HttpServlet {
    AreaChecker areaChecker = new AreaChecker();
    ArrayList<Dot> dots = new ArrayList<>();
    DotDrawer drawer  = new DotDrawer();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
        double x = Double.parseDouble(request.getAttribute("x").toString());
        double y = Double.parseDouble(request.getAttribute("y").toString());
        double r = Double.parseDouble(request.getAttribute("r").toString());
        String svg = request.getAttribute("svg").toString();
        Dot dot = new Dot(x,y,r);
        try {
            dot.setStatus(areaChecker.isInTheSpot(dot));
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
        dots = (ArrayList<Dot>) request.getSession().getAttribute("dots");
        if (dots == null) {
            dots = new ArrayList<>();
            request.getSession().setAttribute("dots", dots);
        }
        dots.add(dot);
        String finalSVG = drawer.addDotToSvg(svg, dot.getX(), dot.getY(), dot.getR());
        request.getSession().setAttribute("svg", finalSVG);
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        Map<String, Object> jsonResponse = new HashMap<>();
        jsonResponse.put("x", dot.getX());
        jsonResponse.put("y", dot.getY());
        jsonResponse.put("r", dot.getR());
        jsonResponse.put("status", dot.getStatus());
        jsonResponse.put("svg", finalSVG);
        response.getWriter().write(new Gson().toJson(jsonResponse));
    }
}

