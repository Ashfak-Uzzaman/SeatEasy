import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

Future<String?> pickDateTime(BuildContext context) async {
  // Show date picker
  DateTime? pickedDate = await showDatePicker(
    context: context,
    initialDate: DateTime.now(),
    firstDate: DateTime.now(),
    lastDate: DateTime(2100),
  );

  if (pickedDate != null) {
    // Show time picker
    TimeOfDay? pickedTime = await showTimePicker(
      // ignore: use_build_context_synchronously
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (pickedTime != null) {
      // Combine date and time
      DateTime pickedDateTime = DateTime(
        pickedDate.year,
        pickedDate.month,
        pickedDate.day,
        pickedTime.hour,
        pickedTime.minute,
      );

      String selectedDateTime =
          DateFormat('yyyy-MM-dd \n HH:mm').format(pickedDateTime);
      return selectedDateTime;
    }
  }
  // Handle cases where user cancels date or time picker
  return null;
}
