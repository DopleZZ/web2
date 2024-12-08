package project.demo;

import java.io.IOException;


public class Dot {

    private final int x;
    private final double y;
    private final double r;
    private boolean status;

    public Dot(int x, double y, double r) throws IOException {
        this.x = x;
        this.y = y;
        this.r = r;

    }

    public int getX() {
        return x;
    }

    public double getY() {
        return y;
    }

    public double getR() {
        return r;
    }

    public boolean getStatus(){
        return this.status;
    }

    public void setStatus(boolean status){
        this.status = status;
    }
}