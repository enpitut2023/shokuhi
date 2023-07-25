import 'package:intl/intl.dart';
int checkDayOfWeek() {
  final now = DateTime.now();
  final dayOfWeek = now.weekday;
  switch (dayOfWeek) {
    case 1:
      return 1;
    case 2:
      return 2;
    case 3:
      return 3;
    case 4:
      return 4;
    case 5:
      return 5;
    case 6:
      return 6;
    case 7:
      return 0;
    default:
      return 7;
  }
}

String checkRunning(String openTime,String closeTime) {
  final timeFormat = DateFormat('H:mm');
  final currentTime = DateTime.now();
  final parsedOpenTime = timeFormat.parse(openTime);
  final parsedCloseTime = timeFormat.parse(closeTime);

  // 現在の時刻をopenTimeとcloseTimeの日付に変更
  final currentTimeWithOpenTime =
  DateTime(
      currentTime.year, currentTime.month, currentTime.day, parsedOpenTime.hour,
      parsedOpenTime.minute);

  var currentTimeWithCloseTime =
  DateTime(currentTime.year, currentTime.month, currentTime.day,
      parsedCloseTime.hour, parsedCloseTime.minute);
  if(currentTimeWithCloseTime.hour == currentTimeWithCloseTime.minute){
    currentTimeWithCloseTime = currentTimeWithCloseTime.add(Duration(days: 1));
  }

  if(openTime==closeTime){
    return "24時間営業";
  }else if (currentTime.isAfter(currentTimeWithOpenTime)&&currentTime.isBefore(currentTimeWithCloseTime)) {
    return "営業中";
  } else {
    return "営業時間外";
  }
}
