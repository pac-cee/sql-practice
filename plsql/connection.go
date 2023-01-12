package main

import (
	"bufio"
	"database/sql"
	"fmt"
	"log"
	"os"
	"strings"

	// PostgreSQL driver
	_ "github.com/lib/pq"
	// MySQL driver
	_ "github.com/go-sql-driver/mysql"
)

// Configuration variables
var (
	// PostgreSQL
	pgUser     = "postgres"
	pgPassword = ""          // updated to remove sensitive information
	pgHost     = "localhost" // update to your Docker container or alias if needed
	pgPort     = "5432"
	// MySQL
	mysqlUser     = "root"
	mysqlPassword = ""          // updated to remove sensitive information
	mysqlHost     = "localhost" // update to your Docker container or alias if needed
	mysqlPort     = "3306"
)

// Helper function to handle errors
func checkErr(err error) {
	if err != nil {
		log.Fatal(err)
	}
}

// connectPostgres connects to PostgreSQL with the provided dbName.
func connectPostgres(dbName string) *sql.DB {
	connStr := fmt.Sprintf("host=%s port=%s user=%s password=%s dbname=%s sslmode=disable",
		pgHost, pgPort, pgUser, pgPassword, dbName)
	db, err := sql.Open("postgres", connStr)
	checkErr(err)
	err = db.Ping()
	checkErr(err)
	fmt.Printf("Connected to PostgreSQL database: %s\n", dbName)
	return db
}

// connectMySQL connects to MySQL with the provided dbName.
func connectMySQL(dbName string) *sql.DB {
	connStr := fmt.Sprintf("%s:%s@tcp(%s:%s)/%s",
		mysqlUser, mysqlPassword, mysqlHost, mysqlPort, dbName)
	db, err := sql.Open("mysql", connStr)
	checkErr(err)
	err = db.Ping()
	checkErr(err)
	fmt.Printf("Connected to MySQL database: %s\n", dbName)
	return db
}

// listPostgresDatabases returns a slice of available PostgreSQL databases.
func listPostgresDatabases(db *sql.DB) []string {
	query := "SELECT datname FROM pg_database WHERE datistemplate = false"
	rows, err := db.Query(query)
	checkErr(err)
	defer rows.Close()

	var databases []string
	for rows.Next() {
		var dbname string
		err := rows.Scan(&dbname)
		checkErr(err)
		databases = append(databases, dbname)
	}
	return databases
}

// listMySQLDatabases returns a slice of available MySQL databases.
func listMySQLDatabases(db *sql.DB) []string {
	query := "SHOW DATABASES"
	rows, err := db.Query(query)
	checkErr(err)
	defer rows.Close()

	var databases []string
	for rows.Next() {
		var dbname string
		err := rows.Scan(&dbname)
		checkErr(err)
		databases = append(databases, dbname)
	}
	return databases
}

// createDatabase creates a new database with the provided name.
func createDatabase(db *sql.DB, query string, dbName string) {
	_, err := db.Exec(query)
	if err != nil {
		log.Fatalf("Error creating database %s: %v", dbName, err)
	}
	fmt.Printf("Database '%s' created successfully.\n", dbName)
}

// readInput reads a line from standard input.
func readInput(prompt string) string {
	fmt.Print(prompt)
	reader := bufio.NewReader(os.Stdin)
	text, err := reader.ReadString('\n')
	checkErr(err)
	return strings.TrimSpace(text)
}

func connectionMain() {
