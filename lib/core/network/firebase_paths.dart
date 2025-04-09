import 'package:cloud_firestore/cloud_firestore.dart';

class FirebasePaths {
 static CollectionReference numberProfiles = FirebaseFirestore.instance.collection('numberProfiles');
 static CollectionReference profiles = FirebaseFirestore.instance.collection('profiles');
}
