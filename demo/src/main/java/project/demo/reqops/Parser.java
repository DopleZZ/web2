package project.demo.reqops;

import com.google.gson.JsonObject;
import com.google.gson.JsonParser;

import java.util.Arrays;

public class Parser {
    public RequestBody getParams(String requestString) {
        try {
            JsonObject jsonObject = JsonParser.parseString(requestString).getAsJsonObject();
            double x = jsonObject.has("x") ? jsonObject.get("x").getAsDouble() : 0;
            double y = jsonObject.has("y") ? jsonObject.get("y").getAsDouble() : 0;
            double r = jsonObject.has("r") ? jsonObject.get("r").getAsDouble() : 0;
            String svg = jsonObject.has("svg") ? jsonObject.get("svg").getAsString() : "";
            return new RequestBody(x, y, r, svg);
        } catch (Exception e) {
            return new RequestBody(0, 0, 0, "");
        }
    }
}