import 'package:intl/intl.dart';

String formatDateForUI(DateTime dateTime) {
  try {
    return DateFormat("d MMM yyyy, h:mm a")
        .format(dateTime.toLocal());
  } catch (e) {
    return "-";
  }
}
