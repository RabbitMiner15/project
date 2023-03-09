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
$email = $data['email'];
$password = $data['password'];

$stmt = $conn->prepare("SELECT dtPassword FROM tblUser WHERE dtEmail = ?");
$stmt->bind_param("s", $email);
$stmt->execute();
$result = $stmt->get_result();

if ($result->num_rows > 0) {
  $user = $result->fetch_assoc();
  if (password_verify($password, $user['dtPassword'])) {
    $stmt = $conn->prepare("SELECT u.idUser, u.dtUsername, u.dtEmail, u.dtPicture, u.dtGroupInvites, u.dtTemperature, u.dtDistance,u.dtVolume,u.dtWeight, u.dtSummary, u.dtWebsiteNoti, u.dtEmailNoti, u.dtDiscordNoti, u.dtPrivate, i.fiInterest FROM tblUser u INNER JOIN tblUserInterest i ON u.idUser = i.fiUser WHERE u.dtEmail = ?");
    $stmt->bind_param("s", $email);
    $stmt->execute();
    $result = $stmt->get_result();

    $result_array = array();
    while ($row = $result->fetch_assoc()) {
      if (!isset($result_array['idUser'])) {
        $result_array["idUser"] = $row["idUser"];
        $result_array["dtUsername"] = $row["dtUsername"];
        $result_array["dtEmail"] = $row["dtEmail"];
        $result_array["dtPicture"] = $row["dtPicture"];
        $result_array["dtGroupInvites"] = $row["dtGroupInvites"];
        $result_array["dtTemperature"] = $row["dtTemperature"];
        $result_array["dtDistance"] = $row["dtDistance"];
        $result_array["dtVolume"] = $row["dtVolume"];
        $result_array["dtWeight"] = $row["dtWeight"];
        $result_array["dtSummary"] = $row["dtSummary"];
        $result_array["dtWebsiteNoti"] = $row["dtWebsiteNoti"];
        $result_array["dtEmailNoti"] = $row["dtEmailNoti"];
        $result_array["dtDiscordNoti"] = $row["dtDiscordNoti"];
        $result_array["idUsedtPrivater"] = $row["dtPrivate"];
        $result_array["interests"] = array();
      }
      $result_array["interests"][] = $row["fiInterest"];

    }
    $message = array('status' => 'Success', 'message' => 'Welcome back', 'data' => $result_array);
    echo json_encode($message);
  } else {
    $message = array('status' => 'Error', 'message' => 'Wrong credentials!');
    echo json_encode($message);
  }
} else {
  $message = array('status' => 'Error', 'message' => 'Wrong credentials!');
  echo json_encode($message);
}
$conn->close();