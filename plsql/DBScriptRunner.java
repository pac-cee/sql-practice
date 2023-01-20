import java.io.BufferedReader;
import java.io.FileReader;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Scanner;

public class DBScriptRunner {

    // Configuration for PostgreSQL
    private static final String PG_USER = "postgres";
    private static final String PG_PASSWORD = ""; // updated to remove sensitive information
    private static final String PG_HOST = "localhost";
    private static final String PG_PORT = "5432";
    // For demonstration, we will use the "postgres" database to run our SQL script.
    private static final String PG_DB = "postgres";

