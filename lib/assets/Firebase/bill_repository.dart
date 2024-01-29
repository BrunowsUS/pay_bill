import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pay_bill/assets/classes/classes.dart';

class BillRepository {
  final CollectionReference collection = FirebaseFirestore.instance.collection('contas');

  Future<void> addConta(Conta conta) {
    return collection.add(conta.toMap());
  }

  Future<void> updateConta(Conta conta) {
    return collection.doc(conta.id).update(conta.toMap());
  }

  Future<void> deleteConta(Conta conta) {
    return collection.doc(conta.id).delete();
  }

  Stream<List<Conta>> getContas() {
    return collection.snapshots().map((snapshot) {
      return snapshot.docs.map((doc) => Conta.fromSnapshot(doc)).toList();
    });
  }
}
