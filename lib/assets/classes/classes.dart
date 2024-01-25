class Conta {
  String nome;
  DateTime dataVencimento;
  double valor;
  bool isPaid;

  Conta(this.nome, this.dataVencimento, this.valor, this.isPaid);

  bool stringToBool(String str) {
    return str.toLowerCase() == 'true';
  }

  bool isValueGreaterThan(double comparisonValue) {
    return this.valor > comparisonValue;
  }

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
