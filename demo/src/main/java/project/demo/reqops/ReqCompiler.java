package project.demo.reqops;

import jakarta.servlet.http.HttpServletRequest;

import java.io.BufferedReader;

public class ReqCompiler {
    Parser parser = new Parser();

    public RequestBody toBody(HttpServletRequest request) {
        try {
            request.setCharacterEncoding("UTF-8");
            StringBuilder jsonBuffer = new StringBuilder();
            String line;
            try (BufferedReader reader = request.getReader()) {
                while ((line = reader.readLine()) != null) {
                    jsonBuffer.append(line);
                }
            }

            return parser.getParams(jsonBuffer.toString());
        } catch (Exception e) {
            return new RequestBody(0, 0, 0);
        }
    }
}
