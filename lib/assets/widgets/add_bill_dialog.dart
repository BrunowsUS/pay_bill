import 'package:flutter/material.dart';
import 'package:pay_bill/assets/classes/classes.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:intl/intl.dart';

class AddBillDialog extends StatefulWidget {
  final void Function(Conta) onPressed;
  final Conta? conta;

  const AddBillDialog({Key? key, required this.onPressed, this.conta})
      : super(key: key);

  @override
  State<AddBillDialog> createState() => _AddBillDialogState();
}

class _AddBillDialogState extends State<AddBillDialog> {
  late bool isPaid;
  late TextEditingController nomeController;
  late MaskTextInputFormatter dataVencimentoFormatter;
  late TextEditingController valorController;

  @override
  void initState() {
    super.initState();
    isPaid = widget.conta?.isPaid ?? false;
    nomeController = TextEditingController(text: widget.conta?.nome);
    dataVencimentoFormatter = MaskTextInputFormatter(
      mask: '##/##/####',
      filter: {"#": RegExp(r'[0-9]')},
      initialText: widget.conta != null
          ? DateFormat('dd/MM/yyyy').format(widget.conta!.dataVencimento)
          : '',
    );
    valorController =
        TextEditingController(text: widget.conta?.valor.toString());
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Adicionar Conta',
          style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold)),
      content: SingleChildScrollView(
        child: ListBody(
          children: <Widget>[
            TextField(
              controller: nomeController,
              decoration: InputDecoration(
                labelText: "Nome",
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 10),
            TextField(
              inputFormatters: [dataVencimentoFormatter],
              decoration: InputDecoration(
                labelText: "Data de Vencimento",
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 10),
            TextField(
              controller: valorController,
              decoration: InputDecoration(
                labelText: "Valor",
                prefixText: 'R\$ ',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 10),
            Row(
              children: <Widget>[
                Text("Pago:"),
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
          child: Text('Salvar', style: TextStyle(color: Colors.blue)),
          onPressed: () {
            var novaConta = Conta(
                nomeController.text,
                DateTime.parse(dataVencimentoFormatter.getUnmaskedText()),
                double.parse(valorController.text),
                isPaid);

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
