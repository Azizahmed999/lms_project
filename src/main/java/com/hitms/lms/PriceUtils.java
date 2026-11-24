package com.hitms.lms;

/** Lab 02 Task 2 - price totals and averages with Javadoc. */
public final class PriceUtils {
    private PriceUtils() {
        // Utility class - no instances needed.
    }

    /**
     * Adds up all the prices in the array.
     *
     * @param prices array of book prices
     * @return sum of all prices, 0 if the array is empty
     */
    public static double total(double[] prices) {
        double sum = 0;
        for (double price : prices) {
            sum += price;
        }
        return sum;
    }

    /**
     * Finds the average of the prices in the array.
     *
     * @param prices array of book prices
     * @return average price, 0 if the array is empty
     */
    public static double average(double[] prices) {
        if (prices.length == 0) {
            return 0;
        }
        return total(prices) / prices.length;
    }

    /**
     * Runs the demo with three sample book prices.
     *
     * @param args command line arguments (not used)
     */
    public static void main(String[] args) {
        double[] prices = {500, 750, 1000};
        System.out.println("Total: " + total(prices));
        System.out.println("Average: " + average(prices));
    }
}
