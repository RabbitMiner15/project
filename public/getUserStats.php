<?php

$request_body = file_get_contents('php://input');
$data = json_decode($request_body, true);
$idUser = $data['idUser'];

// Connect to the database
require_once 'dbConnection.php';
$conn = openDbConnection();




$stmt = $conn->prepare("SELECT fiAchievement,dtVisible FROM tblUserAchievements WHERE fiUser = ? AND dtCompleted = 1");
$stmt->bind_param("i", $idUser);
$stmt->execute();
$result = $stmt->get_result();
$achievements = $result->fetch_all(MYSQLI_ASSOC);
$stmt->close();

$stmt = $conn->prepare("SELECT g.idGroup, g.fiUser, g.dtGroupName, g.dtDescription FROM tblGroup g JOIN tblUserGroup ug ON g.idGroup = ug.fiGroup WHERE ug.fiUser = ? AND ug.dtAccepted = 1 LIMIT 3");
$stmt->bind_param("i", $idUser);
$stmt->execute();
$result = $stmt->get_result();
$groups = [];
while ($group = mysqli_fetch_assoc($result)) {
  $groupId = $group['idGroup'];
  $stmt = $conn->prepare("SELECT u.idUser, u.dtUsername, u.dtEmail, u.dtPicture FROM tblUser u JOIN tblUserGroup ug ON u.idUser = ug.fiUser WHERE ug.fiGroup = ? AND ug.dtAccepted = 1");
  $stmt->bind_param("i", $groupId);
  $stmt->execute();
  $result2 = $stmt->get_result();
  $members = $result2->fetch_all(MYSQLI_ASSOC);
  $group['members'] = $members;
  $groups[]= $group;
}
$stmt->close();

$stmt = $conn->prepare("SELECT idGoal,fiInterest,dtTarget,dtDeadline FROM tblGoal WHERE fiUser = ? AND dtDeadline >= CURDATE()  LIMIT 3");
$stmt->bind_param("i", $idUser);
$stmt->execute();
$result = $stmt->get_result();
$goals = $result->fetch_all(MYSQLI_ASSOC);
$stmt->close();

$stmt = $conn->prepare("SELECT dtValue,fiInterest FROM tblProgress WHERE fiUser = ? AND DATE(dtTimestamp) = CURDATE() LIMIT 3");
$stmt->bind_param("i", $idUser);
$stmt->execute();
$result = $stmt->get_result();
$dailyProgress = [];

while($row = mysqli_fetch_assoc($result)){
  $interest = $row['fiInterest'];
  $value = $row["dtValue"];

  if(!isset($dailyProgress[$interest])){
    $dailyProgress[$interest] = ['values' => []];
  }

  $dailyProgress[$interest]['values'][] = $value;
}
$stmt->close();


$stats = [
  ['label' => "Achievements", 'value' => $achievements],
  ['label' => "Goals", 'value' => $goals],
  ['label' => "Groups", 'value' => $groups],
  ['label' => "DailyProgress", 'progress' => $dailyProgress],
];
echo json_encode($stats);

$conn->close();