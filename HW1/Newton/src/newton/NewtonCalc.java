package newton;

import java.lang.Math;

/**
 * @author AirVan
 */
public class NewtonCalc {
    
    /*
     * Constructor
     */
    public NewtonCalc(double[] coefArray, int[] powerArray) {
        equationCoef = coefArray;
        equationPower = powerArray;
    }
    
    /**
     * Counting Uppest limit for postive roots
     * @return 
     */
    public double upLimPlus() {
        // Finding max negative value
        double maxModul = 0;
        for (int i = 0; i < equationCoef.length; i++) {
            if (Math.abs(equationCoef[i]) > maxModul) {
                maxModul = Math.abs(equationCoef[i]); 
            }
        }
        // Finding first negative num index
        boolean check = true;
        double powerCoef = 0;
        for (int i = 0; i < equationCoef.length; i++) {
            if ((equationCoef[i] < 0) && check)  {
                powerCoef = i;
                check = false;
            }
        }
        double underRoot = maxModul / equationCoef[0];
        double upLimP = 1 + Math.pow(underRoot, (1.0/powerCoef)); 
        return upLimP;
    }
    
    /**
     * Counting Uppest limit for postive roots
     * @return 
     */
    private double upLimPlus(double[] coefArray) {
        // Finding max negative value
        double maxModul = 0;
        for (int i = 0; i < coefArray.length; i++) {
            if (Math.abs(coefArray[i]) > maxModul) {
                maxModul = Math.abs(coefArray[i]); 
            }
        }
        // Finding first negative num index
        boolean check = true;
        double powerCoef = 0;
        for (int i = 0; i < coefArray.length; i++) {
            if ((coefArray[i] < 0) && check)  {
                powerCoef = i;
                check = false;
            }
        }
        double underRoot = maxModul / coefArray[0];
        double upLimP = 1 + Math.pow(underRoot, (1.0/powerCoef)); 
        return upLimP;
    }
    
    /**
     * Counting Lowest limit for negative roots
     * @return 
     */
    public double lowLimNeg() {
        double[] helpArray = new double[equationCoef.length];
        for (int i = 0; i < equationCoef.length; i++) {
            if (equationPower[i] % 2 == 0) {
                helpArray[i] =  equationCoef[i];
            } else {
                helpArray[i] = - equationCoef[i];
            }
        }
        
        // First polinom coef cshoul be positive
        if (helpArray[0] < 0) {
            for (int j = 0; j < helpArray.length; j++) {
                helpArray[j] = - helpArray[j];
            }
        } 
        double lowLimN = - this.upLimPlus(helpArray);
        return lowLimN;
    }
    
    /**
     * Finds intervals , where sign is changing
     */
    public void findSignChange() {
        double upLim = this.upLimPlus();
        double lowLim = this.lowLimNeg();
        // Choosing delta for intervals
        double delta = (Math.abs(upLim) + Math.abs(lowLim)) / 100;
        System.out.println("delta = " + delta);
        double point1 = lowLim;
        double point2 = lowLim + delta;
        double value1 = 0;
        double value2 = 0;
        int step = 0;
        while (point2 < upLim) {
            value1 = calcValue(point1);
            value2 = calcValue(point2);
            if ((value1 * value2) <= 0){
                step++;
                System.out.println(step + ")");
                System.out.println("f(" + point1 + ") = " + value1);
                System.out.println("f(" + point2 + ") = " + value2);
                newtonAlg(point1 + delta / 2);
            }
            point1 = point2;
            point2 = point2 + delta;
        }
    }
    
    /*
     * Calculating value of current function in point
     */
    private double calcValue(double point) {
        double value = 0;
        for (int i = 0; i < equationCoef.length; i++) {
            if (equationPower[i] != 0) {
                value = value + equationCoef[i] * Math.pow(point, equationPower[i]);
            } else {
                value = value + equationCoef[i];
            }
        }
        return value;
    }
    
    /*
     * Calculating value of derivative of current function in point
     */
    private double calcDerivative(double point) {
        double value = 0;
        for (int  i = 0; i < equationCoef.length; i++) {
            if (equationPower[i] != 0) {
                if (equationPower[i] == 1) {
                    value = value + equationCoef[i]; 
                } else {
                    value = value + equationCoef[i] * equationPower[i] * Math.pow(point, equationPower[i] - 1);
                }
            }
        }
        return value;
    }
    
    /**
     * Newton's Algorithm for finding root
     * @param point in root interval
     * @return 
     */
    private void newtonAlg(double point) {
        int count = 1;
        double step = point;
        double nextStep = point - calcValue(point)/calcDerivative(point);
        double epsilon = Math.pow(10, -5);
        while (Math.abs(nextStep - step) > epsilon) {
            System.out.println("Step №" + count + ", Root = " + nextStep + "  F(X) = " + calcValue(nextStep));
            count++;
            step = nextStep;
            nextStep = step - calcValue(step)/calcDerivative(step);
        }
        System.out.println("Step №" + count + ", Root = " + nextStep + "   F(X) = " + calcValue(nextStep));
    }
    
    /*
     * Contains equation coefficients
     */
    private double[] equationCoef;
    
    /**
     * Contains equation powers 
     */
    private int[] equationPower;
}
