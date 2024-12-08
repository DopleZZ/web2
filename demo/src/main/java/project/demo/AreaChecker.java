package project.demo;

public class AreaChecker {

    private boolean isTriangle(Dot dot) {
        var equation = -dot.getR()/2*dot.getX() - dot.getR()/2;

        if (dot.getY() < 0 || dot.getX() < 0 || dot.getY() > equation){
            return false;
        }
        return true;
    }


    private boolean isCircle(Dot dot) {
        return dot.getX() * (dot.getR()/2) >= 0 && dot.getY() * (dot.getR()/2) >= 0 && Math.sqrt(dot.getX() * dot.getX() + dot.getY() * dot.getY()) <= (dot.getR()/2);
    }

    private boolean isRectangle(Dot dot) {
        return dot.getX() * dot.getR() <= 0 && dot.getY() * dot.getR() >= 0 && dot.getY() <= dot.getR() && dot.getX() >= dot.getR();
    }

    public boolean isInTheSpot(Dot dot) throws Exception {
        if (!checkY(dot) || !checkR(dot) || !checkX(dot)) {
            return false;
        }

        if (isCircle(dot) || isTriangle(dot) || isRectangle(dot)) {
            return true;
        }

        return false;
    }


    private boolean checkY(Dot dot) throws Exception {
        if( dot.getY() <= 3 && dot.getY() >= -3){
            return true;
        }
        throw new Exception("Invalid value");
    }
    private boolean checkR(Dot dot) throws Exception {

        double[] array = new double[] {1.0, 1.5, 2.0, 2.5, 3.0};
        for(int i = 0; i < array.length; i++) {
            if(dot.getR() == array[i]) {
                return true;
            }
        }
        throw new Exception("Invalid value");
    }


    private boolean checkX(Dot dot) throws Exception {
        int[] array = new int[] {-5, -4, -3, -2, -1, 0, 1, 2, 3};
        for(int i = 0; i < array.length; i++) {
            if(dot.getX() == array[i]) {
                return true;
            }
        }
        throw new Exception("Invalid value");
    }
}