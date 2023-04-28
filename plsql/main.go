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
