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
