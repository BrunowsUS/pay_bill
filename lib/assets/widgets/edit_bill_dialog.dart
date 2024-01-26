import 'package:flutter/material.dart';
import 'package:pay_bill/assets/classes/classes.dart';
import 'package:pay_bill/assets/widgets/add_bill_dialog.dart';

class EditBillButton extends StatelessWidget {
  final Conta conta;
  final Function(Conta) onEdited;

  const EditBillButton({Key? key, required this.conta, required this.onEdited})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.edit),
      onPressed: () {
        showDialog(
          context: context,
          builder: (context) {
            return AddBillDialog(
              conta: conta,
              onPressed: onEdited,
            );
          },
        );
      },
    );
  }
}
