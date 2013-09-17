/*
 * Class for finding solution for 2-equation system
 *       tg(x - y + k) - xy = 0
 *       ax^2 + 2y^2 = 1
 */
package hw2.newtonsys;

import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.PrintWriter;

/**
 *
 */
public class NewtonSystem {

    /**
     * Constructor
     * @param aParameter - a for system
     * @param kParameter - k for system
     */
    public NewtonSystem(double aParameter, double kParameter) throws FileNotFoundException {
        this.aParam = aParameter;
        this.kParam = kParameter;
        String path = "a" + Double.toString(aParam) + "k" + Double.toString(kParam) + ".txt";
        this.printer = new PrintWriter(new FileOutputStream(path));
    }
    
    /*
     * Calculates value of first function
     */
    public double calcFirstFunc(double x, double y) {
        return (Math.tan(x - y + kParam) - x*y);
    }
    
    /*
     * Calculates value of second function
     */
    public double calcSecondFunc(double x, double y) {
        return (aParam*Math.pow(x,2) + 2*Math.pow(y, 2) - 1);
    }
    
    /*
     * Calculates X derivation
     */
    public double calcFirstDerX(double x, double y) {
        return (Math.pow(Math.cos(x - y + kParam), -2) - y);
    }
    
    /*
     * Calculates Y derivation
     */
    public double calcFirstDerY(double x, double y) {
        return (-Math.pow(Math.cos(x - y + kParam), -2) - x);
    }
    
    /*
     * Calculates X derivation
     */
    public double calcSecondDerX(double x, double y) {
        return (2*aParam*x);
    }
    
    /** 
     * Calculates Y derivation
     */
    public double calcSecondDerY(double x, double y) {
        return (4*y);
    }
    
    /*
     * Main method, where we are lookin' for  result
     */
    public void runApprox() {
        double pointX = lowEdge;
        double pointY = lowEdge;
        printer.println(" a = " + aParam + " k = " + kParam);
        System.out.println(" a = " + aParam + " k = " + kParam);
        while (pointY < highEdge) {
            while (pointX < highEdge) {
                if ((Math.abs(calcFirstFunc(pointX, pointY)) < 0.1) && (Math.abs(calcSecondFunc(pointX, pointY)) < 0.1)) {
                    NewtonAlg(pointX, pointY);
                }
                pointX = pointX + delta;
            }
            pointX = lowEdge;
            pointY = pointY + delta;
        }
        printer.close();
    }
    
    /*
     * Root findin' algorithm
     */
    private void NewtonAlg(double x, double y) {
        int step = 1;
        printer.println();
        printer.println("New point x = " + x + "  y = " + y);
        printer.println("k |          X         |         Y          |          f(X,Y)      |        g(X,Y)");
        System.out.println();
        System.out.println("New point x = " + x + "  y = " + y);
        System.out.println("k |          X         |         Y          |          f(X,Y)      |        g(X,Y)");
        double prevX = x;
        double prevY = y;
        double nextX = prevX + (-calcFirstFunc(x,y)*calcSecondDerY(x,y) + calcSecondFunc(x,y)*calcFirstDerY(x,y))
                / determinant(x,y);
        double nextY = prevY + (-calcFirstDerX(x,y)*calcSecondFunc(x,y) + calcFirstFunc(x,y)*calcSecondDerX(x,y))
                / determinant(x,y);
        while ((Math.abs(nextY - prevY) > epsilon)&& (Math.abs(nextX - prevY) > epsilon)) {
            System.out.println(step + " | " + nextX + " | " + nextY + " | " + calcFirstFunc(nextX, nextY) + " | " + calcSecondFunc(nextX, nextY));
            
            printer.println(step + " | " + nextX + " | " + nextY + " | " + calcFirstFunc(nextX, nextY) + " | " + calcSecondFunc(nextX, nextY));
            prevX = nextX;
            prevY = nextY;
            nextX = prevX + (-calcFirstFunc(prevX,prevY)*calcSecondDerY(prevX,prevY) + calcSecondFunc(prevX,prevY)*calcFirstDerY(prevX,prevY))
                / determinant(prevX,prevY);
            nextY = prevY + (-calcFirstDerX(prevX,prevY)*calcSecondFunc(prevX,prevY) + calcFirstFunc(prevX,prevY)*calcSecondDerX(prevX,prevY))
                / determinant(prevX,prevY);
            step++;
        }
        System.out.println();
        printer.println();
    }
    
    public double determinant(double x, double y) {
        double answer = (calcFirstDerX(x,y)*calcSecondDerY(x,y) - calcFirstDerY(x,y)*calcSecondDerX(x,y));
        return answer;
    }
    
    
    private final double epsilon = Math.pow(10, -6);
    private final double delta = 0.05;
    private final double lowEdge = -2;
    private final double highEdge = 2;
    
    private double aParam;
    private double kParam;
    private PrintWriter printer;
}
