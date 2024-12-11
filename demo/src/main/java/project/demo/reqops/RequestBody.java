package project.demo.reqops;

public class RequestBody {

    private double x;
    private double y;
    private double r;
    private String svg;

    public RequestBody(double x, double y, double r, String svg){
        this.x = x;
        this.y = y;
        this.r = r;
        this.svg = svg;
    }

    public double getX(){
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

    public void setSVG(String svg){ this.svg = svg;}

    public String getSVG(){ return this.svg;}
}
