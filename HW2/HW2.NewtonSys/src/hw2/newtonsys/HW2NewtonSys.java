package hw2.newtonsys;

import java.io.BufferedReader;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.IOException;

/**
 *
 * @author AirVan
 */
public class HW2NewtonSys {

    /**
     * @param args the command line arguments
     */
    public static void main(String[] args) {
        // Text file, where
        // First line contains int a value
        // Second line contains k values
        // tg(x - y + k) - xy = 0
        // ax^2 + 2y^2 = 1
        String filePath = "c:\\NumMath\\HW2\\data.txt";
        try {
            BufferedReader reader = new BufferedReader(new FileReader(filePath));
            String line = reader.readLine();
            // Splitting coefficient string, using " " as a selector
            String[] lineOne = line.split(" ");
            int dimensionOne = lineOne.length;
            double[] aArray = new double[dimensionOne];
      
            line = reader.readLine();
            // Splitting coefficient string, using " " as a selector            
            String[] lineTwo = line.split(" ");
            int dimensionTwo = lineTwo.length;
            double[] kArray = new double[dimensionTwo];
            // FullFilling array of a's
            for (int j = 0; j < dimensionOne; j++) {
                double first = Double.parseDouble(lineOne[j]);
                aArray[j] = first;
            }
            // FullFilling array of k's
            for (int i = 0; i < dimensionTwo; i++) {
                double second = Double.parseDouble(lineTwo[i]);
                kArray[i] = second;
            }
            NewtonSystem mainObj = new NewtonSystem(aArray[0], kArray[0]);
            mainObj.runApprox();                        
//            for (int i = 0; i < dimensionOne; i++) {
//                for (int j = 0; j < dimensionTwo; j++) {
//                    NewtonSystem mainObj = new NewtonSystem(aArray[i], kArray[j]);
//                    mainObj.runApprox();
//                }
//            }
        } catch (FileNotFoundException ex) {
            System.out.println(ex.toString());
        } catch (IOException ex) {
            System.out.println(ex.toString());
        }
    }
}
