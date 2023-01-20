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

    // Configuration for MySQL
    private static final String MYSQL_USER = "root";
    private static final String MYSQL_PASSWORD = ""; // updated to remove sensitive information
    private static final String MYSQL_HOST = "localhost";
    private static final String MYSQL_PORT = "3306";
    // For demonstration, using the "mysql" database
    private static final String MYSQL_DB = "mysql";

    // Helper method for PostgreSQL connection
    public static Connection connectPostgres(String dbName) throws SQLException {
        String url = "jdbc:postgresql://" + PG_HOST + ":" + PG_PORT + "/" + dbName;
        Connection conn = DriverManager.getConnection(url, PG_USER, PG_PASSWORD);
        System.out.println("Connected to PostgreSQL database: " + dbName);
        return conn;
    }

    // Helper method for MySQL connection
    public static Connection connectMySQL(String dbName) throws SQLException {
        String url = "jdbc:mysql://" + MYSQL_HOST + ":" + MYSQL_PORT + "/" + dbName;
