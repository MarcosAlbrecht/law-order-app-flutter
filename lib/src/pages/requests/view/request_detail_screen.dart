import 'package:app_law_order/src/config/custom_colors.dart';
import 'package:flutter/material.dart';

class RequestDetailScreen extends StatelessWidget {
  const RequestDetailScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: CustomColors.white,
      appBar: AppBar(
        centerTitle: true,
        toolbarHeight: 80,
        title: Text(
          'Solicitação',
          style: TextStyle(
            color: CustomColors.black,
          ),
        ),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(10),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Add the request details here
              _RequestDetails(),
              SizedBox(height: 16.0),
              // Add the actions here
              _Actions(),
            ],
          ),
        ),
      ),
    );
  }
}

class _RequestDetails extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: CustomColors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'Solicitação de Serviço',
            style: TextStyle(
                fontSize: CustomFontSizes.fontSize20,
                color: CustomColors.black),
          ),
          SizedBox(height: 8.0),
          _RowDetail('Data de Solicitação', '07/01/2024'),
          _RowDetail('Prazo', '04/02/2024'),
          _RowDetail('Status do Serviço', 'Em agendamento'),
          _RowDetail('Status do Pagamento', 'Pagamento não realizado'),
          // SizedBox(height: 8.0),
          // _RowDetail('Serviços solicitados', 'Teste'),
          // _RowDetail('Valor Total', 'R\$ 1,00'),
          // _RowDetail('Solicitante', 'Marcos Roberto Albrecht'),
          // _RowDetail('Marechal Cândido Rondon', ''),
          // SizedBox(height: 8.0),
          // _RowDetail('Prestadio', ''),
          // _RowDetail('Prestador', 'Leonardo Winter'),
          // _RowDetail('Marechal Cândido Rondon', ''),
        ],
      ),
    );
  }
}

class _RowDetail extends StatelessWidget {
  final String label;
  final String value;

  _RowDetail(this.label, this.value);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        label,
      ),
      trailing: Text(
        value,
        style: TextStyle(
            color: CustomColors.black, fontSize: CustomFontSizes.fontSize14),
      ),
    );
  }
}

class _Actions extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        // Add the chat button here
        _ChatButton(),
        // Add the service confirmation button here
        _ServiceConfirmationButton(),
        // Add the payment button here
        // _PaymentButton(),
        // // Add the evaluation button here
        // _EvaluationButton(),
        // // Add the dispute button here
        // _DisputeButton(),
        // // Add the cancellation button here
        // _CancelButton(),
      ],
    );
  }
}

class _ChatButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: CustomColors.blueDark2Color,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      onPressed: () {
        // Add chat functionality here
      },
      child: Text(
        'Chat',
        style: TextStyle(
          color: CustomColors.white,
        ),
      ),
    );
  }
}

class _ServiceConfirmationButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: CustomColors.green,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      onPressed: () {
        // Add service confirmation functionality here
      },
      child: Text(
        'Confirmar',
        style: TextStyle(
          color: CustomColors.white,
        ),
      ),
    );
  }
}

class _PaymentButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: CustomColors.blueColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      onPressed: () {
        // Add payment functionality here
      },
      child: Text(
        'Realizar pagamento',
        style: TextStyle(
          color: CustomColors.white,
        ),
      ),
    );
  }
}

class _EvaluationButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: CustomColors.blueColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      onPressed: () {
        // Add evaluation functionality here
      },
      child: Text(
        'Enviar avaliação',
        style: TextStyle(
          color: CustomColors.white,
        ),
      ),
    );
  }
}

class _DisputeButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: CustomColors.blueColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      onPressed: () {
        // Add dispute functionality here
      },
      child: Text(
        'Abrir disputa',
        style: TextStyle(
          color: CustomColors.white,
        ),
      ),
    );
  }
}

class _CancelButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: CustomColors.red,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      onPressed: () {
        // Add cancellation functionality here
      },
      child: Text(
        'Cancelar',
        style: TextStyle(
          color: CustomColors.white,
        ),
      ),
    );
  }
}
