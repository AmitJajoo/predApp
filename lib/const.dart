import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

var buttonColor = Color(0xffd0242c);
var backgroundColor = Colors.black;
var textButtonColor = Colors.white;
var kPrimaryColor = Color(0xFFE07C24);
var kPrimaryLightColor = Color(0xFFF1E6FF);

//FIREBASE
FirebaseAuth firebaseAuth = FirebaseAuth.instance;
FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
FirebaseStorage firebaseStorage = FirebaseStorage.instance;
