package com.hitms.lms.exception;

/** Lab 04 Task 2 - thrown when a book has no copies left to issue. */
public class BookUnavailableException extends Exception {
    /**
     * Creates the exception with a message.
     *
     * @param message explains why the book cannot be issued
     */
    public BookUnavailableException(String message) {
        super(message);
    }
}
