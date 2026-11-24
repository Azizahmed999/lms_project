package com.hitms.lms.util;

import java.time.LocalDate;
import java.time.temporal.ChronoUnit;

/** Lab 03 Task 2 - small helper methods used by the LMS. */
public final class LibraryUtils {
    private LibraryUtils() {
        // Utility class - no instances needed.
    }

    /**
     * Formats a book title: trims spaces and capitalises the first letter.
     *
     * @param title raw book title
     * @return formatted title
     */
    public static String formatTitle(String title) {
        String trimmed = title.trim();
        if (trimmed.isEmpty()) {
            return trimmed;
        }
        return trimmed.substring(0, 1).toUpperCase() + trimmed.substring(1);
    }

    /**
     * Counts the days between two dates.
     *
     * @param date1 start date
     * @param date2 end date
     * @return number of days from date1 to date2
     */
    public static long daysBetween(LocalDate date1, LocalDate date2) {
        return ChronoUnit.DAYS.between(date1, date2);
    }
}
