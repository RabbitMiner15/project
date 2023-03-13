<?php

$request_body = file_get_contents('php://input');
$data = json_decode($request_body, true);
$idUser = $data['idUser'];

// Connect to the database
require_once 'dbConnection.php';
$conn = openDbConnection();

$stmt = $conn->prepare("SELECT g.idGroup, g.fiUser, g.dtGroupName, g.dtDescription, ug.dtAccepted FROM tblGroup g JOIN tblUserGroup ug ON g.idGroup = ug.fiGroup WHERE ug.fiUser = ? ");
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
  $groups[] = $group;
}
$stmt->close();

$groups = [
  ['label' => "Groups", 'value' => $groups],
];
echo json_encode($groups);

$conn->close();