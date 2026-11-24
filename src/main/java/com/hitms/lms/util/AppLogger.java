package com.hitms.lms.util;

import java.io.IOException;
import java.util.logging.FileHandler;
import java.util.logging.Logger;
import java.util.logging.SimpleFormatter;

/** Lab 04 Task 4 - logging to app.log instead of println. */
public class AppLogger {
    private static final Logger LOGGER = Logger.getLogger(AppLogger.class.getName());

    /**
     * Writes two log messages into app.log.
     *
     * @param args command line arguments (not used)
     * @throws IOException when the log file cannot be created
     */
    public static void main(String[] args) throws IOException {
        FileHandler handler = new FileHandler("app.log", true);
        handler.setFormatter(new SimpleFormatter());
        LOGGER.addHandler(handler);
        LOGGER.info("LMS application started.");
        LOGGER.info("Book issued successfully.");
        handler.close();
        System.out.println("Logs written to app.log");
    }
}
