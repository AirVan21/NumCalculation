package hw3.tablefunction;
import java.io.BufferedReader;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.FileReader;
import java.io.IOException;
import java.io.PrintWriter;
import java.text.NumberFormat;


/*
 * Class for function extention in the beginning or in the end of table
 */
public class ExtendFunction {
    
    public ExtendFunction(String path, String outpath) throws FileNotFoundException, IOException {
        BufferedReader reader = new BufferedReader(new FileReader(path));
        // Reads step length for argument
        String line = reader.readLine();
        String[] hLine = line.split(" ");
        hLength = Double.parseDouble(hLine[0]);
        int counter = 0;
        //Seting the mark in the beginnig 
        reader.mark(1);
        while (reader.readLine() != null) {
            counter++;
        }
        // Set array length
        argument = new double[counter];
        differenceTable = new double[counter][deltaDegree + 1];
        reader.close();
        
        reader = new BufferedReader(new FileReader(path));
        // skip first line
        reader.readLine();
        for (int i = 0; i < counter; i++) {
            line = reader.readLine();
            String[] data = line.split(" ");
            // Gets values arguments and function values
            argument[i] = Double.parseDouble(data[0]);
            differenceTable[i][0] = Double.parseDouble(data[1]);
        }
        reader.close();
        countFinitDifferences();
        printer = new PrintWriter(new FileOutputStream(outpath));
    }
    
    public void outputData() {
        printer.println(" x  |    f(x)   |   Δf(x)   |   Δ2f(x)   |  Δ3f(x)   |  Δ4f(x)  ");
        printer.println("__________________________________________________________________");
        NumberFormat formatter = NumberFormat.getNumberInstance();
        formatter.setMaximumFractionDigits(7);
        formatter.setMinimumFractionDigits(7);
        String number;
    
        for (int i = 0; i < differenceTable.length; i++) {
            printer.print(argument[i]);
            for (int j = 0; j <= deltaDegree; j++) {
                number = formatter.format(differenceTable[i][j]);
                printer.print(" | " + number);
            }
            printer.println();
        }
    }
    
    public void outputEQ() {
        printer.println();
        printer.println("Для начала таблицы:");
        printer.println("x3* = " + x3);
        printer.println("x0 = " + nearestSmall(x3));
        printer.println("t = " + calcParamBegin(x3));
        printer.println("P(t) = " + calcFunctionBegin(x3));
        printer.println();
        printer.println("Для конца таблицы:");
        printer.println("x3* = " + x3);
        printer.println("x0 = " + nearestBig(x3));
        printer.println("t = " + calcParamEnd(x3));
        printer.println("P(t) = " + calcFunctionEnd(x3));
        printer.println();
        printer.println("Для середины таблицы:");
        printer.println("x3* = " + x3);
        printer.println("x0 = " + nearestSmall(x3));
        printer.println("t = " + calcParamBegin(x3));
        printer.println("P(t) = " + calcFunctionMid(x3));
        printer.close();
    }
    
    
    /*
     * Finding Δf(x) 
     */
    private void countFinitDifferences() {
        for (int i = 1; i <= deltaDegree; i++) {
            for (int j = 0; (j < differenceTable.length - i); j++) {
                differenceTable[j][i] = differenceTable[j + 1][i - 1] - differenceTable[j][i - 1];
            }     
        }
    }
    
    /*
     * Finds nearest value that smaller then param 
     */
    private double nearestSmall(double param) {
        double near = 0;
        for (int i = 0; i < argument.length - 1; i++) {
            if ((argument[i] < param) && (argument[i+1]) > param) {
                near = argument[i];
            }
        }
        return near;
    }
    
    /*
     * Find nearest value that bigger then param
     */
    private double nearestBig(double param) {
        double near = 0;
        for (int i = argument.length - 1; i > 0; i--) {
            if ((argument[i] > param) && (argument[i - 1]) < param) {
                near = argument[i];
            }
        }
        return near;
    }
    
    /*
     * Parameter counting for the beginnig of the table
     */
    public double calcParamBegin(double param) {
        return ((param - nearestSmall(param))/this.hLength);
    }
    
    /*
     * Parameter counting for the ending of the table
     */
    public double calcParamEnd(double param) {
        return ((param - nearestBig(param))/this.hLength);
    }
    
    /**
     * Finds required function value from param
     * @param param - function argument
     * @return function value
     */
    public double calcFunctionBegin(double param) {
        double t = calcParamBegin(param);
        double nearSmall = nearestSmall(param);
        int index = findIndex(nearSmall);
        double sum1 = differenceTable[index][0] + t*differenceTable[index][1] + (t*(t - 1)/2)*differenceTable[index][2]  
                + (t*(t - 1)*(t - 2)/6)*differenceTable[index][3] + (t*(t - 1)*(t - 2)*(t - 3)/24)*differenceTable[index][4];
        return sum1;
    }
    
    /**
     * Finds required function value from param
     * @param param - function argument
     * @return function value
     */
    public double calcFunctionEnd(double param) {
        double t = calcParamEnd(param);
        double nearBig = nearestBig(param);
        int index = findIndex(nearBig);
        double sum1 = differenceTable[index][0] + t*differenceTable[index - 1][1] + (t*(t + 1)/2)*differenceTable[index - 2][2]
                + (t*(t + 1)*(t + 2)/6)*differenceTable[index - 3][3] + (t*(t + 1)*(t + 2)*(t + 3)/24)*differenceTable[index - 4][4]; 
        return sum1;
    }
    
    /**
     * Finds required function value frim param
     * @param param - function argument
     * @return functuin value
     */
    public double calcFunctionMid(double param) {
        double t = calcParamBegin(param);
        double nearSmall = nearestSmall(param);
        int index = findIndex(nearSmall);
        double sum1 = differenceTable[index][0] + t*differenceTable[index][1] + (t*(t - 1)/2)*differenceTable[index - 1][2]
                + (t*(t - 1)*(t + 1)/6)*differenceTable[index - 1][3] + (t*(t - 1)*(t + 1)*(t - 2)/24)*differenceTable[index - 2][4];
        return sum1;
    }
    /**
     * Finding index of current value
     * @param number value, which index we are searching
     * @return position in array
     */
    private int findIndex(double number) {
        int index = 0;
        for (int i = 0; i < argument.length; i++) {
            if (number == argument[i]) {
                index = i;
            }
        }
        return index;
    }
    
    /*
     * Step length for argument 
     */
    private double hLength;
    
    /*
     * Arguments for function
     */
    private double[] argument;
    
    /**
     * Function values from appropriate arguments
     */
    private double[] funcValue;
    
    /**
     * Table for finit differences
     */
    private double[][] differenceTable;
    
    /*
     * Finit differences degree
     */
    private final int deltaDegree = 4;
    
    /**
     * Points to calculate
     */
    private final double x1 = 0.124141;
    private final double x2 = 0.792321;
    private final double x3 = 0.329726;
    private final double y1 = 1.680208;
    
    private PrintWriter printer;
}
