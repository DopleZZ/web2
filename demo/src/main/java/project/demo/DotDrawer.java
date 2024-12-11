package project.demo;

public class DotDrawer {

    public String addDotToSvg(String svgContent, double x, double y, double r) {
        final int INT_SIZE = 620;
        final int SCALE = 4;
        final int PADDING = 10;
        final int GAP = Math.floorDiv((INT_SIZE - PADDING * 2), (SCALE + 1) * 2);
        final int AXIS_XY = Math.floorDiv(INT_SIZE, 2);
        int physicalX = AXIS_XY + (int) ( x * GAP);
        int physicalY = AXIS_XY - (int) (y * GAP);
        String newDot = String.format(
                "\n<circle cx=\"%d\" cy=\"%d\" r=\"5\" fill=\"red\" stroke=\"red\" stroke-width=\"1px\" />",
                physicalX, physicalY
        );
        return svgContent + newDot;
    }


}
