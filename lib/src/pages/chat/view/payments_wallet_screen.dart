import 'package:flutter/material.dart';

class PaymentsWalletScreen extends StatefulWidget {
  const PaymentsWalletScreen({super.key});

  @override
  State<PaymentsWalletScreen> createState() => _PaymentsWalletScreenState();
}

class _PaymentsWalletScreenState extends State<PaymentsWalletScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Carteira de pagamentos'),
      ),
      body: Container(),
    );
  }
}
