import 'package:flutter/material.dart';
import 'package:pay_bill/assets/classes/classes.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:intl/intl.dart'; // Importe o pacote intl

class AddBillDialog extends StatefulWidget {
  final void Function(Conta) onPressed;

  const AddBillDialog({super.key, required this.onPressed});

  @override
  State<AddBillDialog> createState() => _AddBillDialogState();
}

class _AddBillDialogState extends State<AddBillDialog> {
  bool isPaid = false;

  final nomeController = TextEditingController();
  final dataVencimentoFormatter = MaskTextInputFormatter(
      mask: '##/##/####', filter: {"#": RegExp(r'[0-9]')});
  final valorController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Adicionar Conta',
          style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold)),
      content: SingleChildScrollView(
        child: ListBody(
          children: <Widget>[
            TextField(
              controller: nomeController,
              decoration: const InputDecoration(
                labelText: "Nome",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              inputFormatters: [dataVencimentoFormatter],
              decoration: const InputDecoration(
                labelText: "Data de Vencimento",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: valorController,
              decoration: const InputDecoration(
                labelText: "Valor",
                prefixText: 'R\$ ',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 10),
            Row(
              children: <Widget>[
                const Text("Pago:"),
                Checkbox(
                  value: isPaid,
                  onChanged: (bool? value) {
                    setState(() {
                      isPaid = value ?? false;
                    });
                  },
                ),
              ],
            ),
          ],
        ),
      ),
      actions: <Widget>[
        TextButton(
          child: const Text('Adicionar', style: TextStyle(color: Colors.blue)),
          onPressed: () {
            print('Botão Salvar pressionado');

            // Divida a data de vencimento em dia, mês e ano
            List<String> dataVencimentoParts =
                dataVencimentoFormatter.getUnmaskedText().split('/');
            int dia = int.parse(dataVencimentoParts[0]);
            int mes = int.parse(dataVencimentoParts[1]);
            int ano = int.parse(dataVencimentoParts[2]);

            // Crie uma nova instância de DateTime
            DateTime dataVencimento = DateTime(ano, mes, dia);

            var novaConta = Conta(nomeController.text, dataVencimento,
                double.parse(valorController.text), isPaid);

            widget.onPressed(novaConta);

            nomeController.clear();
            dataVencimentoFormatter.clear();
            valorController.clear();

            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}
