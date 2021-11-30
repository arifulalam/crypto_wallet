import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

Future<bool> signIn(String email, String password) async{
  try{
    await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);
    return true;
  }catch (e){
    print(e.toString());
  }
  return false;
}

Future<bool> signUp(String email, String password) async{
  try{
    await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password);
    return true;
  }on FirebaseAuthException catch (e){
    if(e.code == 'weak-password'){
      print('The password provided is too weak.');
    }else if(e.code == 'email-already-in-use'){
      print('The account already exists for that email.');
    }
  }catch (e){
    print(e.toString());
  }
  return false;
}

Future<bool> addCoin(String id, String amount) async{
  try{
    String uid = FirebaseAuth.instance.currentUser!.uid;
    var value = double.parse(amount);
    DocumentReference docRef = FirebaseFirestore.instance
    .collection('Users')
    .doc(uid)
    .collection('Coins')
    .doc(id);
    FirebaseFirestore.instance.runTransaction((transaction) async {
      DocumentSnapshot snapshot = await transaction.get(docRef);
      if(!snapshot.exists){
        docRef.set({"Amount" : value});
        return true;
      }
      double newAmount = snapshot.get("Amount") + value;
      transaction.update(docRef, {'Amount' : newAmount});
      return true;
    });
  }catch (e){
    print(e.toString());
  }
  return false;
}

Future<bool> removeCoin(String id) async{
  try{
    String uid = FirebaseAuth.instance.currentUser!.uid;
    DocumentReference docRef = FirebaseFirestore.instance
        .collection('Users')
        .doc(uid)
        .collection('Coins')
        .doc(id)
        .delete() as DocumentReference<Object?>;
    return true;
  }catch (e){
    print(e.toString());
  }
  return false;
}