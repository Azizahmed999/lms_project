package com.hitms.lms;

/**
 * Lab 04 Task 3 - findMax.
 * Bug found while debugging: starting maxValue at 0 gives a wrong answer
 * for all-negative arrays, because 0 is bigger than every value.
 * Fix: start maxValue from numbers[0].
 */
public class DebuggingDemo {
    /**
     * Finds the largest number in the array.
     *
     * @param numbers array to search (must not be empty)
     * @return the largest value
     */
    public int findMax(int[] numbers) {
        int maxValue = numbers[0];
        for (int number : numbers) {
            if (number > maxValue) {
                maxValue = number;
            }
        }
        return maxValue;
    }

    /**
     * Runs the demo with the lab's example array {-5, -2, -9}.
     *
     * @param args command line arguments (not used)
     */
    public static void main(String[] args) {
        DebuggingDemo demo = new DebuggingDemo();
        int[] numbers = {-5, -2, -9};
        System.out.println("Max of {-5, -2, -9} = " + demo.findMax(numbers));
    }
}
