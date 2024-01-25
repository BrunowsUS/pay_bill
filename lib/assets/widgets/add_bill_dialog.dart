import 'package:flutter/material.dart';
import 'package:pay_bill/assets/classes/classes.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class AddBillDialog extends StatefulWidget {
  final void Function(Conta) onPressed;

  const AddBillDialog({super.key, required this.onPressed});

  @override
  State<AddBillDialog> createState() => _AddBillDialogState();
}

class _AddBillDialogState extends State<AddBillDialog> {
  bool isPaid = false; // Atualizado para isPaid

  final nomeController = TextEditingController();
  final dataVencimentoFormatter = MaskTextInputFormatter(
      mask: '##/##/####',
      filter: {"#": RegExp(r'[0-9]')}); // Use um MaskTextInputFormatter aqui
  final valorController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Adicionar Conta',
          style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold)),
      content: SingleChildScrollView(
        // Adicionado para evitar overflow se a tela for pequena
        child: ListBody(
          children: <Widget>[
            TextField(
              controller: nomeController,
              decoration: const InputDecoration(
                labelText: "Nome",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10), // Espaço entre os campos
            TextField(
              inputFormatters: [
                dataVencimentoFormatter
              ], // Use o formatador aqui
              decoration: const InputDecoration(
                labelText: "Data de Vencimento",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10), // Espaço entre os campos
            TextField(
              controller: valorController,
              decoration: const InputDecoration(
                labelText: "Valor",
                prefixText: 'R\$ ',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 10), // Espaço entre os campos
            Row(
              children: <Widget>[
                const Text("Pago:"),
                Checkbox(
                  value: isPaid, // Atualizado para isPaid
                  onChanged: (bool? value) {
                    setState(() {
                      isPaid = value ?? false; // Atualizado para isPaid
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
            var novaConta = Conta(
                nomeController.text,
                DateTime.parse(dataVencimentoFormatter
                    .getUnmaskedText()), // Use getUnmaskedText() aqui
                double.parse(valorController.text),
                isPaid); // Atualizado para isPaid

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
