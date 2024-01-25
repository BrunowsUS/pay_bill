import 'package:flutter/material.dart';
import 'package:pay_bill/assets/classes/classes.dart';
import 'package:pay_bill/assets/widgets/add_bill_dialog.dart';
import 'package:intl/intl.dart';
import 'package:google_fonts/google_fonts.dart';

class ContasApp extends StatefulWidget {
  const ContasApp({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _ContasAppState createState() => _ContasAppState();
}

class _ContasAppState extends State<ContasApp> {
  List<Conta> contas = [];

  void adicionarConta(Conta conta) {
    setState(() {
      contas.add(conta);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Gerenciador de Contas',
          style: GoogleFonts.robotoSlab(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.blue,
        centerTitle: true,
        elevation: 8.0,
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text('Total pago:',
                    style: GoogleFonts.roboto(fontWeight: FontWeight.bold)),
                Text('R\$ ${Conta.calculateTotalPaid(contas)}',
                    style: GoogleFonts.roboto()),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text('Total não pago:',
                    style: GoogleFonts.roboto(fontWeight: FontWeight.bold)),
                Text('R\$ ${Conta.calculateTotalUnpaid(contas)}',
                    style: GoogleFonts.roboto()),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: contas.length,
              itemBuilder: (context, index) {
                return Card(
                  color: contas[index].isPaid ? Colors.green.shade100 : null,
                  margin: const EdgeInsets.all(10),
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 10.0),
                    child: ListTile(
                      title: Row(
                        children: <Widget>[
                          Text(contas[index].nome),
                          if (DateTime.now()
                              .isAfter(contas[index].dataVencimento))
                            const Text(
                              " - VENCIDO",
                              style: TextStyle(
                                  color: Colors.red,
                                  fontWeight: FontWeight.bold),
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
                                    '${DateFormat('dd/MM/yyyy').format(contas[index].dataVencimento)}, '),
                            const TextSpan(
                                text: 'Valor: R\$ ',
                                style: TextStyle(fontWeight: FontWeight.bold)),
                            TextSpan(text: '${contas[index].valor}'),
                          ],
                        ),
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          const Text(
                            "Pago?",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Checkbox(
                            value: contas[index].isPaid,
                            onChanged: (bool? value) {
                              setState(() {
                                contas[index].isPaid = value ?? false;
                              });
                            },
                          ),
                          IconButton(
                            icon: const Icon(Icons.edit),
                            onPressed: () {
                              // Abra o diálogo de edição aqui
                            },
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
                                          setState(() {
                                            contas.removeAt(
                                                index); // Remove a conta da lista
                                          });
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
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
              context: context,
              builder: (context) {
                return AddBillDialog(onPressed: adicionarConta);
              });
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
