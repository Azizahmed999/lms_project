package com.hitms.lms;

/** Lab 02 Task 1 - area of a rectangle with proper Java naming. */
public class AreaCalculator {
    /** Default length used in the demo run. */
    public static final int DEFAULT_LENGTH = 5;
    /** Default width used in the demo run. */
    public static final int DEFAULT_WIDTH = 4;

    /**
     * Calculates the area of a rectangle.
     *
     * @param length length of the rectangle
     * @param width width of the rectangle
     * @return length * width
     */
    public int calculateArea(int length, int width) {
        return length * width;
    }

    /**
     * Runs the demo: area of a 5 by 4 rectangle.
     *
     * @param args command line arguments (not used)
     */
    public static void main(String[] args) {
        AreaCalculator calculator = new AreaCalculator();
        int area = calculator.calculateArea(DEFAULT_LENGTH, DEFAULT_WIDTH);
        System.out.println("Area of " + DEFAULT_LENGTH + " x " + DEFAULT_WIDTH + " = " + area);
    }
}
