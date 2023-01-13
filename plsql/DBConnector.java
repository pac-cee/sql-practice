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
