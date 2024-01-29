import 'package:cloud_firestore/cloud_firestore.dart';

class Conta {
  String? id;
  String nome;
  DateTime dataVencimento;
  double valor;
  bool isPaid;

  Conta(this.nome, this.dataVencimento, this.valor, this.isPaid, {this.id});

  // Converte um Conta para um Map
  Map<String, dynamic> toMap() {
    return {
      'nome': nome,
      'dataVencimento': dataVencimento,
      'valor': valor,
      'isPaid': isPaid,
    };
  }

  // Cria um Conta a partir de um documento do Firestore
  Conta.fromSnapshot(DocumentSnapshot snapshot)
      : id = snapshot.id,
        nome = snapshot['nome'],
        dataVencimento = (snapshot['dataVencimento'] as Timestamp).toDate(),
        valor = snapshot['valor'],
        isPaid = snapshot['isPaid'];

  static double calculateTotalPaid(List<Conta> contas) {
    return contas
        .where((conta) => conta.isPaid)
        .fold(0.0, (prev, element) => prev + element.valor);
  }

  static double calculateTotalUnpaid(List<Conta> contas) {
    return contas
        .where((conta) => !conta.isPaid)
        .fold(0.0, (prev, element) => prev + element.valor);
  }
}
