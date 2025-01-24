import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

Future<String?> pickDateTime(
    {required BuildContext context, required currentTime}) async {
  // Show date picker
  DateTime? pickedDate = await showDatePicker(
    context: context,
    initialDate: DateTime.now(),
    firstDate: DateTime.now(),
    lastDate: DateTime(2100),
  );

  if (pickedDate != null) {
    TimeOfDay? pickedTime;

    if (currentTime) {
      pickedTime = TimeOfDay.now();
    } else {
      // Show time picker
      pickedTime = await showTimePicker(
        // ignore: use_build_context_synchronously
        context: context,
        initialTime: TimeOfDay.now(),
      );
    }

    if (pickedTime != null) {
      // Combine date and time
      DateTime pickedDateTime = DateTime(
        pickedDate.year,
        pickedDate.month,
        pickedDate.day,
        pickedTime.hour,
        pickedTime.minute,
      );

      // Format to ISO 8601 string
      String selectedDateTime =
          DateFormat('yyyy-MM-ddTHH:mm:ss').format(pickedDateTime);
      return selectedDateTime;
    }
  }
  // Handle cases where user cancels date or time picker
  return null;
}
