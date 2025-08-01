<?php

// -----------------------------------------------------------------------------
// Database Connection Configuration
// IMPORTANT: Replace the placeholders with your actual database credentials.
// -----------------------------------------------------------------------------
$servername = "localhost"; // Use "localhost" if the database is on the same server
$username   = "your_db_username";  // REPLACE with your database username
$password   = "your_db_password";  // REPLACE with your database password
$dbname     = "your_db_name";      // REPLACE with your database name

// -----------------------------------------------------------------------------
// Establish a connection to the MySQL database
// -----------------------------------------------------------------------------
$conn = new mysqli($servername, $username, $password, $dbname);

// Check the connection
if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}

// -----------------------------------------------------------------------------
// Process the form data
// -----------------------------------------------------------------------------
// Check if the form was submitted via POST method
if ($_SERVER["REQUEST_METHOD"] == "POST") {

    // Sanitize and validate the input
    // Using a prepared statement is the most secure way to handle this.
    $username_input = $_POST['username'];
    $email_input    = $_POST['email'];

    // SQL query to insert data into a 'users' table
    // The '?' placeholders are for prepared statements, preventing SQL injection.
    $sql = "INSERT INTO users (username, email) VALUES (?, ?)";

    // Prepare the statement
    $stmt = $conn->prepare($sql);

    if ($stmt === false) {
        die("Error preparing statement: " . $conn->error);
    }

    // Bind parameters to the statement
    // "ss" indicates that both parameters are strings
    $stmt->bind_param("ss", $username_input, $email_input);

    // Execute the statement
    if ($stmt->execute()) {
        // Successful insertion
        echo "<script>
                document.getElementById('response-message').innerHTML = 'New record created successfully!';
                document.getElementById('response-message').classList.remove('text-red-500');
                document.getElementById('response-message').classList.add('text-green-500');
              </script>";
    } else {
        // Failed insertion
        echo "<script>
                document.getElementById('response-message').innerHTML = 'Error: " . $stmt->error . "';
                document.getElementById('response-message').classList.remove('text-green-500');
                document.getElementById('response-message').classList.add('text-red-500');
              </script>";
    }

    // Close the statement
    $stmt->close();
}

// Close the database connection
$conn->close();

?>
