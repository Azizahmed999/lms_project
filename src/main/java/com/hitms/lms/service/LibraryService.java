package com.hitms.lms.service;

import com.hitms.lms.exception.BookUnavailableException;
import com.hitms.lms.model.Member;

/** Lab 03/04/05 - book issuing service for the LMS catalogue. */
public class LibraryService {
    /**
     * Issues one copy of a book if a copy is available.
     *
     * @param availableCopies copies currently available
     * @param title title of the book
     * @return copies left after issuing
     * @throws BookUnavailableException when no copy is available
     */
    public int issueBook(int availableCopies, String title) throws BookUnavailableException {
        if (availableCopies <= 0) {
            throw new BookUnavailableException("Book '" + title + "' is not available.");
        }
        return availableCopies - 1;
    }

    /**
     * Finds a member by id (Lab 05 branch demo - sample data only).
     *
     * @param id member id to find
     * @return the member, or null when the id is unknown
     */
    public Member findMemberById(int id) {
        if (id == 1) {
            return new Member(1, "Aziz Ahmed");
        }
        return null;
    }
    /**
     * Finds a member by name (added on feature/add-member-lookup).
     *
     * @param name member name to find
     * @return the member, or null when the name is unknown
     */
    public Member findMemberByName(String name) {
        if ("Aziz Ahmed".equals(name)) {
            return new Member(1, "Aziz Ahmed");
        }
        return null;
    }
}


