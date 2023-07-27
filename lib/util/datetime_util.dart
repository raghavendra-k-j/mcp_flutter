import 'package:intl/intl.dart';

class DateTimeUtil {
  static String formatDate(DateTime? d) {
    if(d == null) {
      return "";
    }
    else {
      return DateFormat("dd-MM-yyyy").format(d);
    }
  }
}