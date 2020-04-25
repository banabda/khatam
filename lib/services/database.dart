import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:khatam_counter/dataUser.dart';

class DatabaseService {

  final String uid;
  
  
  
  DatabaseService({this.uid});
  
  Future updateData(int ayat, int surat, int juz, int hari) async {
    final CollectionReference ngaji = Firestore.instance.collection(uid);
    final QuerySnapshot result = await ngaji.getDocuments();
    final List<DocumentSnapshot> documents = result.documents;
    print("error $documents asdddddddddddddddddddddd ${documents.length} dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd");
    documents.forEach((data) => print(data.documentID));
    if (documents.length == 0) {
      return await ngaji.document("1").setData({
        'ayat': ayat,
        'surat': surat,
        'juz': juz,
        'hari': hari
      });
    }
    
  }

  Future addData(int ayat, int surat, int juz, int hari) async {
    final CollectionReference ngaji = Firestore.instance.collection(uid);
    final QuerySnapshot result = await ngaji.getDocuments();
    final List<DocumentSnapshot> documents = result.documents;
    print("error $documents asdddddddddddddddddddddd ${documents.length} dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd");
    documents.forEach((data) => print(data.documentID));
    if (documents.length > 0) {
      var num = int.parse((documents[(documents.length)-1].documentID).toString())+1;
      return await ngaji.document("$num").setData({
        'ayat': ayat,
        'surat': surat,
        'juz': juz,
        'hari': hari
      });
    }
  }

  List<DataUser> _listDataUser(QuerySnapshot snapshot){
    return snapshot.documents.map((doc){
      return DataUser(
        ayat: doc.data['ayat'] ?? 0,
        surat: doc.data['surat'] ?? 0,
        juz: doc.data['juz'] ?? 0,
        hari: doc.data['hari'] ?? 0
      );
    }).toList();
  }

  Stream<List<DataUser>> get progress {
    final CollectionReference ngaji = Firestore.instance.collection(uid);
    return ngaji.snapshots().map(_listDataUser);
  }
}