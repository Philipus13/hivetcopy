import 'package:intl/intl.dart';

class Helper {
  static String convertToDay(DateTime selectedDay) {
    String? day;
    day = DateFormat('EEEE').format(selectedDay);
    if (day == 'Monday') {
      day = 'senin';
    }
    if (day == 'Tuesday') {
      day = 'selasa';
    }
    if (day == 'Wednesday') {
      day = 'rabu';
    }
    if (day == 'Thursday') {
      day = 'kamis';
    }
    if (day == 'Friday') {
      day = 'jumat';
    }
    if (day == 'Saturday') {
      day = 'sabtu';
    }
    if (day == 'Sunday') {
      day = 'minggu';
    }

    return day;
  }

  static String convertToRupiah(double money) {
    final formatCurrency = new NumberFormat.simpleCurrency(
        locale: 'id', name: 'Rp ', decimalDigits: 0);
    return formatCurrency.format(money);
  }

  static List<String> splitText(String text) {
    List<String> listText = text.split(':');
    return listText;
  }

  static String getTime(String dateTime, int subString) {
    List<String> listTime = dateTime.split('T');
    String time = listTime[1];
    String timereturn = time.substring(0, subString);
    return timereturn;
  }

  static String getDate(String dateTime) {
    List<String> listTime = dateTime.split('T');
    String time = listTime[0];
    String timereturn = time.substring(0, 10);
    return timereturn;
  }
}
