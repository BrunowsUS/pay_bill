import 'package:flutter/material.dart';
import 'package:pay_bill/assets/classes/classes.dart';
import 'package:intl/intl.dart';

class AddBillDialog extends StatefulWidget {
  final Conta? conta;
  final void Function(Conta) onPressed;

  const AddBillDialog({Key? key, this.conta, required this.onPressed})
      : super(key: key);

  @override
  State<AddBillDialog> createState() => _AddBillDialogState();
}

class _AddBillDialogState extends State<AddBillDialog> {
  bool isPaid = false;

  final nomeController = TextEditingController();
  final dataVencimentoController = TextEditingController();
  final valorController = TextEditingController();

  @override
  void initState() {
    super.initState();

    if (widget.conta != null) {
      nomeController.text = widget.conta!.nome;
      dataVencimentoController.text =
          DateFormat('dd/MM/yyyy').format(widget.conta!.dataVencimento);
      valorController.text = widget.conta!.valor.toString();
      isPaid = widget.conta!.isPaid;
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        widget.conta == null ? 'Adicionar Conta' : 'Editar Conta',
        style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
      ),
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
              controller: dataVencimentoController,
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
          child: Text(
            widget.conta == null ? 'Adicionar' : 'Salvar',
            style: TextStyle(color: Colors.blue),
          ),
          onPressed: () {
            print('Botão Salvar pressionado');

            List<String> dataVencimentoParts =
                dataVencimentoController.text.split('/');
            int dia = int.parse(dataVencimentoParts[0]);
            int mes = int.parse(dataVencimentoParts[1]);
            int ano = int.parse(dataVencimentoParts[2]);

            DateTime dataVencimento = DateTime(ano, mes, dia);

            var novaConta = Conta(nomeController.text, dataVencimento,
                double.parse(valorController.text), isPaid);

            widget.onPressed(novaConta);

            nomeController.clear();
            dataVencimentoController.clear();
            valorController.clear();

            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}
