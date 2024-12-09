package project.demo.reqops;

import java.util.Arrays;

public class Parser {
    public RequestBody getParams(String requestString) {
        System.out.println(requestString);
        requestString = requestString.replace("{", "")
                .replace("}", "")
                .replace("\"", "")
                .replace("x:", "")
                .replace("y:", "")
                .replace("r:", "");
        String[] elements = requestString.split(",");

        System.out.println(Arrays.toString(elements));

        if (elements.length != 3) {
            return new RequestBody(0,0,0);
        }
        try {
            RequestBody body = new RequestBody(
                    Integer.parseInt(elements[0]),
                    Double.parseDouble(elements[1]),
                    Double.parseDouble(elements[2]));
            return body;
        } catch (Exception e) {
            return new RequestBody(0,0,0);
        }
    }
}
