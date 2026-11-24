package com.hitms.lms;

/** Lab 03 Task 1 - average and report of student scores. */
public final class ReportUtil {
    private ReportUtil() {
        // Utility class - no instances needed.
    }

    /**
     * Calculates the average of the scores.
     *
     * @param scores array of student scores
     * @return average score, 0 if the array is empty
     */
    public static double calculateAverage(int[] scores) {
        if (scores.length == 0) {
            return 0;
        }
        int sum = 0;
        for (int score : scores) {
            sum += score;
        }
        return (double) sum / scores.length;
    }

    /**
     * Prints every score and then the average.
     *
     * @param scores array of student scores
     */
    public static void printReport(int[] scores) {
        System.out.println("Student Scores Report");
        for (int score : scores) {
            System.out.println("Score: " + score);
        }
        System.out.println("Average: " + calculateAverage(scores));
    }

    /**
     * Runs the demo with a sample set of scores.
     *
     * @param args command line arguments (not used)
     */
    public static void main(String[] args) {
        int[] scores = {80, 75, 90, 65, 85};
        printReport(scores);
    }
}
