import 'package:intl/intl.dart';

mixin DateTimeUtils {
  static String getFormattedDate(
    DateTime dateTime, {
    String dateFormat = 'dd MMM yyyy',
  }) {
    final DateFormat formatter = DateFormat(dateFormat);
    return formatter.format(dateTime);
  }

  static String getFormatTime(int time, {String format = 'HH:mm:ss'}) {
    final dateTime = DateTime.fromMillisecondsSinceEpoch(time, isUtc: true);
    return DateFormat(format).format(dateTime);
  }
}
