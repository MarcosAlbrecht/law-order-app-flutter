import 'package:app_law_order/src/config/custom_colors.dart';
import 'package:app_law_order/src/pages/requests/controller/request_controller.dart';
import 'package:app_law_order/src/pages/requests/controller/request_manager_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarDialog extends StatefulWidget {
  @override
  _CalendarDialogState createState() => _CalendarDialogState();
}

class _CalendarDialogState extends State<CalendarDialog> {
  final CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return AlertDialog(
      title: Text(
        'Selecione uma Data de Prazo, ela serve para você informar ao solicitante, quantos dias você precisa para realizar o trabalho!',
        style: TextStyle(fontSize: CustomFontSizes.fontSize12),
      ),
      content: GetBuilder<RequestController>(
        builder: (controller) {
          return Visibility(
            visible: !controller.isSaving,
            replacement: Center(
              child: LoadingAnimationWidget.discreteCircle(
                color: CustomColors.blueDark2Color,
                secondRingColor: CustomColors.blueDarkColor,
                thirdRingColor: CustomColors.blueColor,
                size: 50,
              ),
            ),
            child: SizedBox(
              height: size.height,
              width: size.width,
              child: TableCalendar(
                locale: 'pt_BR',
                firstDay: DateTime.now(),
                lastDay: DateTime.now().add(Duration(days: 365)),
                focusedDay: _focusedDay,
                calendarFormat: _calendarFormat,
                selectedDayPredicate: (day) {
                  return isSameDay(_selectedDay, day);
                },
                onDaySelected: (selectedDay, focusedDay) {
                  setState(() {
                    _selectedDay = selectedDay;
                    _focusedDay = focusedDay; // Update focused day to selected day
                  });
                },
                onPageChanged: (focusedDay) {
                  setState(() {
                    _focusedDay = focusedDay;
                  });
                },
                headerStyle: const HeaderStyle(
                  titleCentered: true,
                  formatButtonVisible: false, // Remove o botão de mudança de formato
                ),
              ),
            ),
          );
        },
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(); // Fechar o diálogo
          },
          child: Text('Cancelar'),
        ),
        GetBuilder<RequestManagerController>(
          builder: (controller) {
            return TextButton(
              onPressed: () {
                // Implemente a lógica para usar _selectedDay como a data escolhida
                if (_selectedDay != null) {
                  print('Data selecionada: ');
                  controller.handleProviderConfirmRequest(date: _selectedDay!);
                  Navigator.of(context).pop();
                }
              },
              child: const Text('Selecionar'),
            );
          },
        ),
      ],
    );
  }
}
