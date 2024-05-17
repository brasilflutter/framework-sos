extension DateTimeExtension on DateTime {
  String toJson() {
    return toIso8601String();
  }
}
