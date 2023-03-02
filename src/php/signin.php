<?php
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: PUT, GET, POST");
header("Access-Control-Allow-Headers: Origin, X-Requested-With, Content-Type, Accept");

$request = json_decode(file_get_contents('php://input'));



if ($request->email === 'KreMa914@school.lu' && $request->password === '123') {
  echo json_encode(['success' => true]);
} else {
  echo json_encode(['success' => false, 'message' => 'Invalid email or password']);
}