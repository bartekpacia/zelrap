import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:zelrap/data/models/person.dart';

class DataRepository {
  final _firestore = FirebaseFirestore.instance;
  static final DataRepository instance = DataRepository._internal();

  DataRepository._internal();

  Stream<List<Celebrity>> listenFreshCelebrities() {
    Stream<QuerySnapshot> stream = _firestore
        .collection('celebrities')
        .where('joinedDate',
            isGreaterThanOrEqualTo: DateTime(DateTime.now().year, DateTime.now().month - 1))
        .snapshots();

    return _mapQuerySnapshotToCelebrities(stream);
  }

  Stream<List<Celebrity>> listenLiveCelebrities() {
    Stream<QuerySnapshot> stream =
        _firestore.collection('celebrities').where('isLive', isEqualTo: true).snapshots();

    return _mapQuerySnapshotToCelebrities(stream);
  }

  Stream<List<Celebrity>> _mapQuerySnapshotToCelebrities(Stream<QuerySnapshot> stream) {
    return stream.map(
      (querySnapshot) => querySnapshot.docs
          .map(
            (doc) => Celebrity(
              name: doc.data()?['name'],
              photoUrl: doc.data()?['photo'],
              joinedDate: doc.data()?['joinedDate'].toDate(),
              isLive: doc.data()?['isLive'],
            ),
          )
          .toList(),
    );
  }
}
