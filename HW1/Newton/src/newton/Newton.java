/*
 * Finding equation's roots, using Newton's method
 */
package newton;

import java.io.BufferedReader;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.IOException;

/**
 * @author AirVan
 */
public class Newton {

    public static void main(String[] args) throws IOException {
        // Text file, where
        // First line contains monoms' power values
        // Second line contains coefficients, startin' with major monom coefficient 
        String filePath = "c:\\NumMath\\HW1\\EQ3.txt";
        try {
            BufferedReader reader = new BufferedReader(new FileReader(filePath));
            String line = reader.readLine();
            String[] lineOne = line.split(" ");
            int dimension = lineOne.length;

            double[] coefArray = new double[dimension];
            int[] powArray = new int[dimension];
            line = reader.readLine();
            String[] lineTwo = line.split(" ");
            // Splitting coefficient string, using " " as a selector
            for (int j = 0; j < dimension; j++) {
                int power = Integer.parseInt(lineOne[j]);
                double value = Double.parseDouble(lineTwo[j]);
                powArray[j] = power;
                coefArray[j] = value;
                if (coefArray[j] < 0) {
                    System.out.print(" " + coefArray[j]);
                } else {
                    System.out.print(" + " + coefArray[j]);

                }
                if (powArray[j] != 0) {
                    System.out.print("*" + "x^(" + (powArray[j]) + ")");
                }
            }
            System.out.println(" = 0");
            System.out.println();

            NewtonCalc mainObj = new NewtonCalc(coefArray, powArray);
            System.out.println("UpLimPositive = " + mainObj.upLimPlus());
            System.out.println("LowLimNegative = " + mainObj.lowLimNeg());
            mainObj.findSignChange();
        } catch (FileNotFoundException ex) {
            System.out.println(ex.toString());
        } catch (IOException ex) {
            System.out.println(ex.toString());
        }

    }
}
