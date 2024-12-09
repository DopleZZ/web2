package project.demo.reqops;

public class RequestBody {

    private int x;
    private double y;
    private double r;

    public RequestBody(int x, double y, double r){
        this.x = x;
        this.y = y;
        this.r = r;
    }

    public int getX(){
        return this.x;
    }

    public void setX(int x){
        this.x = x;
    }

    public double getY(){
        return this.y;
    }

    public void setY(double y){
        this.y=y;
    }

    public double getR(){
        return this.r;
    }

    public void setR(double r){
        this.r=r;
    }
}
