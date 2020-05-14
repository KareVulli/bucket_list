import 'package:bucketlist/models/challenge.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Database {

  final String _uid;
  final CollectionReference _challengeCollection;

  Database(this._uid, {Firestore firestore})
      : this._challengeCollection = firestore == null ? Firestore.instance.collection('challenges') : firestore.collection('challenges');

  Future<void> addChallenge(Challenge challenge) async {
    Map<String, dynamic> json = challenge.toJson();
    json['userId'] = _uid;
    return await _challengeCollection.add(json);
  }

  Future<void> updateChallenge(Challenge challenge) async {
    Map<String, dynamic> json = challenge.toJson();
    json['userId'] = _uid;
    return await _challengeCollection.document(challenge.uid).setData(json);
  }

  Stream<List<Challenge>> challenges() {
    return _challengeCollection.where('userId', isEqualTo: _uid).snapshots()
      .map((snapshot) {
        return snapshot.documents
            .map((document) => Challenge.fromSnapshot(document))
            .toList();
      });
  }

  Future<void> deleteChallenge(String challengeId) async {
    return await _challengeCollection.document(challengeId).delete();
  }

}