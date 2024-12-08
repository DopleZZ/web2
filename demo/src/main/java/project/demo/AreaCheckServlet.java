package project.demo;


import com.google.gson.Gson;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.ArrayList;


public class AreaCheckServlet extends HttpServlet {
    AreaChecker areaChecker = new AreaChecker();
    Gson gson = new Gson();

    ArrayList<Dot> dots = new ArrayList<>();
    Dot dot;
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
        try {
            long start = System.nanoTime();
            int x = Integer.parseInt(request.getParameter("x"));
            double y = Double.parseDouble(request.getParameter("y"));
            double r = Double.parseDouble(request.getParameter("r"));
            dot = new Dot(x, y, r);
            dot.setStatus(areaChecker.isInTheSpot(dot));
            dots = (ArrayList<Dot>) request.getSession().getAttribute("dots");
            if (dots == null) {
                dots = new ArrayList<>();
                request.getSession().setAttribute("dots", dots);
            }
            dots.add(dot);
            response.setStatus(HttpServletResponse.SC_OK);
            String res = String.format(gson.toJson(dot));
            response.getWriter().write(res);
            System.out.println("Response JSON: " + res);
        }
        catch (IllegalParameterException e) {
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            String answer = "{ error: " + e.getMessage() + "}";
            response.getWriter().write(answer);
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
    }
}
