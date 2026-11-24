package com.hitms.lms;

import com.hitms.lms.exception.BookUnavailableException;
import com.hitms.lms.service.LibraryService;

/** Lab 04 Task 2 - demo of issuing a book, success and failure. */
public class BookIssueDemo {
    /**
     * Runs both cases: 2 copies available, then 0 copies available.
     *
     * @param args command line arguments (not used)
     */
    public static void main(String[] args) {
        LibraryService service = new LibraryService();
        try {
            int left = service.issueBook(2, "Software Construction");
            System.out.println("Book issued. Copies left: " + left);
        } catch (BookUnavailableException e) {
            System.out.println(e.getMessage());
        }
        try {
            int left = service.issueBook(0, "Software Construction");
            System.out.println("Book issued. Copies left: " + left);
        } catch (BookUnavailableException e) {
            System.out.println("Error: " + e.getMessage());
        }
    }
}
