class TimeUtils {
  static String readTimestamp(int timestamp) {
    var now = DateTime.now();
    var date = DateTime.fromMillisecondsSinceEpoch(timestamp);
    var diff = now.difference(date);
    var time = '';

    if (diff.inSeconds <= 0 ||
        diff.inSeconds > 0 && diff.inMinutes == 0 ||
        diff.inMinutes > 0 && diff.inHours == 0 ||
        diff.inHours > 0 && diff.inDays == 0) {
      if (diff.inHours > 0) {
        time = diff.inHours.toString() + ' ชั่วโมง';
      } else if (diff.inMinutes > 0) {
        time = diff.inMinutes.toString() + ' นาที';
      } else if (diff.inSeconds > 0) {
        time = 'เดียวนี้';
      } else if (diff.inMilliseconds > 0) {
        time = 'เดียวนี้';
      } else if (diff.inMicroseconds > 0) {
        time = 'เดียวนี้';
      } else {
        time = 'เดียวนี้';
      }
    } else if (diff.inDays > 0 && diff.inDays < 7) {
      time = diff.inDays.toString() + 'วัน';
    } else if (diff.inDays > 6) {
      time = (diff.inDays / 7).floor().toString() + ' สัปดาห์';
    } else if (diff.inDays > 29) {
      time = (diff.inDays / 30).floor().toString() + ' เดือน';
    } else if (diff.inDays > 365) {
      time = '${date.month} ${date.day}, ${date.year}';
    }
    return time;
  }
}
