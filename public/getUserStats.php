<?php

$request_body = file_get_contents('php://input');
$data = json_decode($request_body, true);
$idUser = $data['idUser'];

// Connect to the database
require_once 'dbConnection.php';
$conn = openDbConnection();




$stmt = $conn->prepare("SELECT COUNT(*) FROM tblUserAchievements WHERE fiUser = ? AND dtCompleted = 1");
$stmt->bind_param("i", $idUser);
$stmt->execute();
$stmt->bind_result($achievements);
$stmt->fetch();
$stmt->close();

$stmt = $conn->prepare("SELECT COUNT(*) FROM tblUserGroup WHERE fiUser = ? AND dtAccepted = 1");
$stmt->bind_param("i", $idUser);
$stmt->execute();
$stmt->bind_result($groups);
$stmt->fetch();
$stmt->close();

$stmt = $conn->prepare("SELECT COUNT(*) FROM tblGoal WHERE fiUser = ? AND dtDeadline >= CURDATE() ");
$stmt->bind_param("i", $idUser);
$stmt->execute();
$stmt->bind_result($goals);
$stmt->fetch();
$stmt->close();


$stats = [
  ['label' => "Achievements", 'value' => $achievements],
  ['label' => "Goals", 'value' => $goals],
  ['label' => "Groups", 'value' => $groups],
];
echo json_encode($stats);

$conn->close();