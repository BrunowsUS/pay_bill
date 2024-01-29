import 'package:flutter/material.dart';
import 'package:pay_bill/assets/Firebase/bill_repository.dart';
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
  final BillRepository billRepository = BillRepository();

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
              billRepository.updateConta(updatedConta);
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
          style: GoogleFonts.robotoSlab(
            fontWeight: FontWeight.bold,
            color: Colors.white, // Change the color to white
          ),
        ),
        backgroundColor: Colors.purple, // Change the color to purple
        centerTitle: true,
        elevation: 8.0,
      ),
      body: Stack(
        children: <Widget>[
          Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(16.0), // Increase padding
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text('Total pago:',
                        style: GoogleFonts.roboto(
                          fontWeight: FontWeight.bold,
                          fontSize: 18.0, // Increase font size
                          color: Colors.purple, // Change the color to purple
                        )),
                    Text('R\$ ${Conta.calculateTotalPaid(contas)}',
                        style: GoogleFonts.roboto(
                          fontSize: 18.0, // Increase font size
                          color: Colors.purple, // Change the color to purple
                        )),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0), // Increase padding
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text('Total não pago:',
                        style: GoogleFonts.roboto(
                          fontWeight: FontWeight.bold,
                          fontSize: 18.0, // Increase font size
                          color: Colors.purple, // Change the color to purple
                        )),
                    Text('R\$ ${Conta.calculateTotalUnpaid(contas)}',
                        style: GoogleFonts.roboto(
                          fontSize: 18.0, // Increase font size
                          color: Colors.purple, // Change the color to purple
                        )),
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
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: EdgeInsets.only(
                  bottom: 16.0), // Add some padding from the bottom
              child: FloatingActionButton(
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
                backgroundColor: Colors.purple, // Change the color to purple
                elevation: 12.0, // Increase shadow
                splashColor:
                    Colors.grey, // Add splash color for click animation
              ),
            ),
          ),
        ],
      ),
    );
  }
}
