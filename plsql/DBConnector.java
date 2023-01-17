import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Scanner;

public class DBConnector {
    // Configuration for PostgreSQL
    private static final String PG_USER = "postgres";
    private static final String PG_PASSWORD = "";// updated to remove sensitive information
    // For security reasons, avoid hardcoding sensitive information like passwords in the code.
    private static final String PG_HOST = "localhost";
    private static final String PG_PORT = "5432";
    // For PostgreSQL, the default database to connect and list other db's is often "postgres"
    private static final String PG_DEFAULT_DB = "postgres";

    // Configuration for MySQL
    private static final String MYSQL_USER = "root";
    private static final String MYSQL_PASSWORD = ""; // updated to remove sensitive information
    private static final String MYSQL_HOST = "localhost";
    private static final String MYSQL_PORT = "3306";
    // For MySQL, we can connect to the "mysql" system database to list available ones.
    private static final String MYSQL_DEFAULT_DB = "mysql";

    // Helper method to read user input
    private static String readInput(Scanner scanner, String prompt) {
        System.out.print(prompt);
        return scanner.nextLine().trim();
    }

    // Connect to PostgreSQL
    public static Connection connectPostgres(String dbName) throws SQLException {
        String url = "jdbc:postgresql://" + PG_HOST + ":" + PG_PORT + "/" + dbName;
        Connection conn = DriverManager.getConnection(url, PG_USER, PG_PASSWORD);
        System.out.println("Connected to PostgreSQL database: " + dbName);
        return conn;
    }

    // Connect to MySQL
    public static Connection connectMySQL(String dbName) throws SQLException {
        String url = "jdbc:mysql://" + MYSQL_HOST + ":" + MYSQL_PORT + "/" + dbName;
        Connection conn = DriverManager.getConnection(url, MYSQL_USER, MYSQL_PASSWORD);
        System.out.println("Connected to MySQL database: " + dbName);
        return conn;
    }

    // List PostgreSQL databases
    public static void listPostgresDatabases(Connection conn) throws SQLException {
        String sql = "SELECT datname FROM pg_database WHERE datistemplate = false";
        Statement stmt = conn.createStatement();
        ResultSet rs = stmt.executeQuery(sql);
        System.out.println("\nAvailable PostgreSQL databases:");
        int index = 1;
        while (rs.next()) {
            System.out.println("  " + (index++) + ") " + rs.getString("datname"));
        }
        rs.close();
        stmt.close();
    }

    // List MySQL databases
    public static void listMySQLDatabases(Connection conn) throws SQLException {
        String sql = "SHOW DATABASES";
        Statement stmt = conn.createStatement();
        ResultSet rs = stmt.executeQuery(sql);
        System.out.println("\nAvailable MySQL databases:");
        int index = 1;
        while (rs.next()) {
            System.out.println("  " + (index++) + ") " + rs.getString(1));
        }
        rs.close();
        stmt.close();
    }

    // Create database method (for both PostgreSQL and MySQL)
