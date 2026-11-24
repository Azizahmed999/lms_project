package com.hitms.lms;

/** Lab 04 Task 1 - safe division with ArithmeticException handling. */
public class DivisionDemo {
    /**
     * Divides safely: returns 0 and prints a message when dividing by zero.
     *
     * @param numerator numerator
     * @param denominator denominator
     * @return numerator / denominator, or 0 when denominator is 0
     */
    public int safeDivide(int numerator, int denominator) {
        try {
            return numerator / denominator;
        } catch (ArithmeticException e) {
            System.out.println("Error: Cannot divide by zero.");
            return 0;
        }
    }

    /**
     * Runs the demo: 10 / 2 and 10 / 0.
     *
     * @param args command line arguments (not used)
     */
    public static void main(String[] args) {
        DivisionDemo demo = new DivisionDemo();
        System.out.println("10 / 2 = " + demo.safeDivide(10, 2));
        System.out.println("10 / 0 = " + demo.safeDivide(10, 0));
    }
}
