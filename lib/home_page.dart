import 'package:flutter/material.dart';
import 'package:pay_bill/assets/classes/classes.dart';
import 'package:pay_bill/assets/widgets/add_bill_dialog.dart';
import 'package:pay_bill/assets/widgets/bill_card.dart';
import 'package:intl/intl.dart';
import 'package:google_fonts/google_fonts.dart';

class ContasApp extends StatefulWidget {
  const ContasApp({Key? key}) : super(key: key);

  @override
  _ContasAppState createState() => _ContasAppState();
}

class _ContasAppState extends State<ContasApp> {
  List<Conta> contas = [];

  void adicionarConta(Conta conta) {
    setState(() {
      contas.add(conta);
    });
  }

  void editarConta(Conta conta) {
    showDialog(
      context: context,
      builder: (context) {
        return AddBillDialog(
          conta: conta,
          onPressed: (Conta updatedConta) {
            setState(() {
              int index = contas.indexOf(conta);
              contas[index] = updatedConta;
            });
          },
        );
      },
    );
  }
  void deletarConta(Conta conta) {
    setState(() {
      contas.remove(conta);
    });
  }
  void alterarStatusPago(bool? value, Conta conta) {
    setState(() {
      conta.isPaid = value ?? false;
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
                return BillCard(
                  conta: contas[index],
                  onEdited: editarConta,
                  onDeleted: deletarConta,
                  onPaidStatusChanged: alterarStatusPago,
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
                return AddBillDialog(
                  onPressed: adicionarConta,
                );
              });
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
