<?php

$request_body = file_get_contents('php://input');
$data = json_decode($request_body, true);
$idUser = $data['idUser'];

// Connect to the database
require_once 'dbConnection.php';
$conn = openDbConnection();


$stmt = $conn->prepare("SELECT idGoal,fiInterest,dtTarget,dtDeadline FROM tblGoal WHERE fiUser = ?");
$stmt->bind_param("i", $idUser);
$stmt->execute();
$result = $stmt->get_result();
$goals = $result->fetch_all(MYSQLI_ASSOC);
$stmt->close();

$stats = [
  ['label' => "Goals", 'value' => $goals],
];
echo json_encode($stats);

$conn->close();