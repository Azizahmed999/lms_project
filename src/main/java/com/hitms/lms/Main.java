package com.hitms.lms;

import com.hitms.lms.util.LibraryUtils;
import java.time.LocalDate;

/** Lab 03 Task 2 - entry point that uses the LibraryUtils module. */
public class Main {
    /**
     * Runs the LibraryUtils demo.
     *
     * @param args command line arguments (not used)
     */
    public static void main(String[] args) {
        System.out.println("Formatted title: " + LibraryUtils.formatTitle("  software construction  "));
        LocalDate issueDate = LocalDate.of(2026, 11, 10);
        LocalDate returnDate = LocalDate.of(2026, 11, 24);
        System.out.println("Days between: " + LibraryUtils.daysBetween(issueDate, returnDate));
    }
}
