package com.hitms.lms;

import org.fusesource.jansi.AnsiConsole;

import static org.fusesource.jansi.Ansi.ansi;

/** Lab 01 Task 3 - coloured output with the Jansi library. */
public class Colors {
    /**
     * Prints the greeting in green using Jansi.
     *
     * @param args command line arguments (not used)
     */
    public static void main(String[] args) {
        AnsiConsole.systemInstall();
        System.out.println(ansi().fgGreen().a("Hello, Software Construction!").reset());
        AnsiConsole.systemUninstall();
    }
}
