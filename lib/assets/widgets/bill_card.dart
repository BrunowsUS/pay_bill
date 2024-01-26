import 'package:flutter/material.dart';
import 'package:pay_bill/assets/classes/classes.dart';
import 'package:pay_bill/assets/widgets/edit_bill_dialog.dart';
import 'package:intl/intl.dart';

class BillCard extends StatelessWidget {
  final Conta conta;
  final Function(Conta) onEdited;
  final Function(Conta) onDeleted;
  final Function(bool?, Conta) onPaidStatusChanged;

  const BillCard({
    Key? key,
    required this.conta,
    required this.onEdited,
    required this.onDeleted,
    required this.onPaidStatusChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: conta.isPaid ? Colors.green.shade100 : null,
      margin: const EdgeInsets.all(10),
      child: Padding(
        padding: const EdgeInsets.only(bottom: 10.0),
        child: ListTile(
          title: Row(
            children: <Widget>[
              Text(conta.nome),
              if (DateTime.now().isAfter(conta.dataVencimento))
                const Text(
                  " - VENCIDO",
                  style:
                      TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
                ),
            ],
          ),
          subtitle: RichText(
            text: TextSpan(
              style: DefaultTextStyle.of(context).style,
              children: <TextSpan>[
                const TextSpan(
                    text: 'Vencimento: ',
                    style: TextStyle(fontWeight: FontWeight.bold)),
                TextSpan(
                    text:
                        '${DateFormat('dd/MM/yyyy').format(conta.dataVencimento)}, '),
                const TextSpan(
                    text: 'Valor: R\$ ',
                    style: TextStyle(fontWeight: FontWeight.bold)),
                TextSpan(text: '${conta.valor}'),
              ],
            ),
          ),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              const Text("Pago?",
                  style: TextStyle(fontWeight: FontWeight.bold)),
              Checkbox(
                value: conta.isPaid,
                onChanged: (bool? value) {
                  onPaidStatusChanged(value, conta);
                },
              ),
              EditBillButton(
                conta: conta,
                onEdited: onEdited,
              ),
              IconButton(
                icon: const Icon(Icons.delete),
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text('Confirmação'),
                        content: const Text(
                            'Você tem certeza que deseja deletar esta conta?'),
                        actions: <Widget>[
                          TextButton(
                            child: const Text('Cancelar'),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                          TextButton(
                            child: const Text('Deletar'),
                            onPressed: () {
                              onDeleted(conta);
                              Navigator.of(context).pop();
                            },
                          ),
                        ],
                      );
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
