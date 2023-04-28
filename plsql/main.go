package main

import (
	"database/sql"
	"fmt"
	"io/ioutil"
	"log"
	"strings"

	// PostgreSQL driver
	_ "github.com/lib/pq"
	// MySQL driver
	_ "github.com/go-sql-driver/mysql"
)

// ... (Configuration variables and helper functions: checkErr, connectPostgres, connectMySQL, etc.)

// runSQLScript reads a SQL file, splits it into individual statements, and executes them.
func runSQLScript(db *sql.DB, filePath string) {
	// Read the entire file
	scriptBytes, err := ioutil.ReadFile(filePath)
	checkErr(err)
	script := string(scriptBytes)

	// A simple (and naive) way to split statements on semicolon.
	// Note: For complex SQL scripts (with semicolons in strings, comments, etc.), consider using a proper SQL parser.
	statements := strings.Split(script, ";")

	for _, stmt := range statements {
		stmt = strings.TrimSpace(stmt)
		if stmt == "" {
			continue
		}
		// Execute each statement
		_, err := db.Exec(stmt)
		if err != nil {
			log.Fatalf("Error executing statement [%s]: %v", stmt, err)
		} else {
