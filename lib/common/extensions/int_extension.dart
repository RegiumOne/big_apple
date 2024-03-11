extension IntExtension on int {
  String toTimeText() {
    if (this < 60) {
      return "$this s";
    } else if (this < 3600) {
      int minutes = this ~/ 60;
      int seconds = this % 60;
      return "$minutes min $seconds s";
    } else if (this < 86400) {
      int hours = this ~/ 3600;
      int minutes = (this % 3600) ~/ 60;
      return "$hours hr $minutes min";
    } else {
      int days = this ~/ 86400;
      int hours = (this % 86400) ~/ 3600;
      return "$days days $hours hr";
    }
  }
}
