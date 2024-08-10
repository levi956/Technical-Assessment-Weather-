import 'package:intl/intl.dart';

String formatDateTime(DateTime dateTime) {
  String day = _getDayWithSuffix(dateTime.day);

  String month = DateFormat('MMMM').format(dateTime);

  String time = DateFormat('h:mma').format(dateTime).toLowerCase();

  return '$day, $month, $time';
}

String _getDayWithSuffix(int day) {
  if (day >= 11 && day <= 13) {
    return '${day}th';
  }
  switch (day % 10) {
    case 1:
      return '${day}st';
    case 2:
      return '${day}nd';
    case 3:
      return '${day}rd';
    default:
      return '${day}th';
  }
}

String convertUnixTimestampToReadableTime(int timestamp) {
  DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
  return DateFormat('h:mm a').format(dateTime);
}
