<?php

header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: POST");
header("Access-Control-Allow-Headers: Content-Type");

$request_body = file_get_contents('php://input');
$data = json_decode($request_body, true);

// Connect to the database
require_once 'dbConnection.php';
$conn = openDbConnection();


// Get the POST data from the request
$username = $data['username'];
$email = $data['email'];
$password = $data['password'];
$picture = $data['picture'];
$interests = $data['fiInterest'];

// Hash the password
$hashed_password = password_hash($password, PASSWORD_DEFAULT);

$query = "SELECT COUNT(*) FROM tblUser WHERE dtEmail='$email'";
$result = mysqli_query($conn, $query);
$countEmail = mysqli_fetch_array($result)[0];

$query = "SELECT COUNT(*) FROM tblUser WHERE dtUsername='$username'";
$result = mysqli_query($conn, $query);
$countUsername = mysqli_fetch_array($result)[0];

if ($countEmail > 0 && $countUsername > 0) {
  $message = array('status' => 'Error', 'message' => 'Email and Username already in use.');
  echo json_encode($message);
} elseif ($countEmail > 0) {
  $message = array('status' => 'Error', 'message' => 'Email already in use.');
  echo json_encode($message);
} elseif ($countUsername > 0) {
  $message = array('status' => 'Error', 'message' => 'Username already in use.');
  echo json_encode($message);
} else {
  // Insert the user data into the tblUser table
  $stmt = $conn->prepare("INSERT INTO tblUser (dtUsername, dtEmail, dtPassword, dtPicture) VALUES (?, ?, ?, ?)");
  $stmt->bind_param("sssi", $username, $email, $hashed_password, $picture);
  $stmt->execute();

  // Get the user ID of the newly inserted user
  $fiUser = $conn->insert_id;

  // Insert the user's selected interest IDs into the tblUserInterest table
  foreach ($interests as $interest) {
    $stmt = $conn->prepare("INSERT INTO tblUserInterest (fiUser, fiInterest) VALUES (?, ?)");
    $stmt->bind_param("ii", $fiUser, $interest);
    $stmt->execute();
  }
  $message = array('status' => 'Success', 'message' => 'User created, please login');
  echo json_encode($message);
}
$conn->close();