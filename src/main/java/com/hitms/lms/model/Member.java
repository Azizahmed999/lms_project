package com.hitms.lms.model;

/** Lab 03 LMS model - one library member. */
public class Member {
    private final int id;
    private final String name;

    /**
     * Creates a library member.
     *
     * @param id member id
     * @param name member name
     */
    public Member(int id, String name) {
        this.id = id;
        this.name = name;
    }

    public int getId() {
        return id;
    }

    public String getName() {
        return name;
    }
}
