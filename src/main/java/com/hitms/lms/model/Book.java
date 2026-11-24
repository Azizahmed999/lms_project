package com.hitms.lms.model;

/** Lab 03 LMS model - one book in the library. */
public class Book {
    private final String title;
    private int availableCopies;

    /**
     * Creates a book with its title and copy count.
     *
     * @param title book title
     * @param availableCopies copies available to issue
     */
    public Book(String title, int availableCopies) {
        this.title = title;
        this.availableCopies = availableCopies;
    }

    public String getTitle() {
        return title;
    }

    public int getAvailableCopies() {
        return availableCopies;
    }

    public void setAvailableCopies(int availableCopies) {
        this.availableCopies = availableCopies;
    }
}
