/*
 * Files for table function counting
 */
package hw3.tablefunction;

import java.io.IOException;


/**
 * @author AirVan
 */
public class HW3TableFunction {

    /**
     * @param args the command line arguments
     */
    public static void main(String[] args) {
        String path = "c:\\NumMath\\NumCalculation\\HW3\\data.txt";
        String outpath = "c:\\NumMath\\NumCalculation\\HW3\\output.txt";
        try {
            ExtendFunction extend = new ExtendFunction(path, outpath);
            extend.outputData();
            extend.outputEQ();
        } catch (IOException ex) {
            System.out.println(ex.toString());
        }
    }
}
