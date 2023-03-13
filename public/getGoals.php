<?php

$request_body = file_get_contents('php://input');
$data = json_decode($request_body, true);
$idUser = $data['idUser'];

// Connect to the database
require_once 'dbConnection.php';
$conn = openDbConnection();


$stmt = $conn->prepare("SELECT idGoal,fiInterest,dtTarget,dtDeadline,dtCreationDate FROM tblGoal WHERE fiUser = ?");
$stmt->bind_param("i", $idUser);
$stmt->execute();
$result = $stmt->get_result();
$goals = $result->fetch_all(MYSQLI_ASSOC);
$stmt->close();

$stmt = $conn->prepare("SELECT dtValue,fiInterest,dtTimestamp FROM tblProgress WHERE fiUser = ?");
$stmt->bind_param("i", $idUser);
$stmt->execute();
$result = $stmt->get_result();
$progress = [];

while ($row = mysqli_fetch_assoc($result)) {
  $interest = $row['fiInterest'];
  $value = $row["dtValue"];
  $timestamp = $row["dtTimestamp"];

  if (!isset($progress[$interest])) {
    $progress[$interest] = ['values' => []];
  }

  $progress[$interest]['values'][] = ["value" => $value, "timestamp" => $timestamp];
}
$stmt->close();

$output = [
  ['label' => "Goals", 'value' => $goals],
  ['label' => "Progress", 'progress' => $progress],
];
echo json_encode($output);

$conn->close();