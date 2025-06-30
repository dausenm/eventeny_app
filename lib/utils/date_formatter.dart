String formatDateTime(DateTime dateTime) {
  final year = dateTime.year;
  final month = _monthName(dateTime.month);
  final day = dateTime.day.toString().padLeft(2, '0');
  final hour = (dateTime.hour % 12 == 0 ? 12 : dateTime.hour % 12);
  final minute = dateTime.minute.toString().padLeft(2, '0');
  final ampm = dateTime.hour >= 12 ? 'PM' : 'AM';

  return "$month $day, $year – $hour:$minute $ampm";
}

String _monthName(int month) {
  const months = [
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December',
  ];
  return months[month - 1];
}
