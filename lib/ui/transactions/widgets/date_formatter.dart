/// Utility class for formatting dates in transaction screens
class TransactionDateFormatter {
  /// Formats a DateTime object to a user-friendly string
  /// Returns 'Today', 'Yesterday', or a date in format '12 Mar 2023'
  static String formatDate(DateTime date) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final yesterday = today.subtract(const Duration(days: 1));
    final dateToCheck = DateTime(date.year, date.month, date.day);

    if (dateToCheck == today) {
      return 'Today';
    } else if (dateToCheck == yesterday) {
      return 'Yesterday';
    } else {
      return '${date.day} ${_getMonthName(date.month)} ${date.year}';
    }
  }

  /// Formats a DateTime object to a detailed string
  /// Returns format 'Wednesday, April 12, 2023'
  static String formatDateDetailed(DateTime date) {
    final months = [
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
    final days = [
      'Monday',
      'Tuesday',
      'Wednesday',
      'Thursday',
      'Friday',
      'Saturday',
      'Sunday',
    ];

    final dayName = days[date.weekday - 1]; // weekday is 1-7 where 1 is Monday
    final monthName = months[date.month - 1];

    return '$dayName, $monthName ${date.day}, ${date.year}';
  }

  /// Parses a formatted date string back to a DateTime object
  static DateTime parseDate(String formattedDate) {
    if (formattedDate == 'Today') {
      return DateTime.now();
    } else if (formattedDate == 'Yesterday') {
      return DateTime.now().subtract(const Duration(days: 1));
    } else {
      // Parse the date string (this is simplified and may need improvement)
      final parts = formattedDate.split(' ');
      return DateTime(
        int.parse(parts[2]), // year
        _getMonthNumber(parts[1]), // month
        int.parse(parts[0]), // day
      );
    }
  }

  /// Formats a DateTime to a compact date string
  /// Returns format 'Apr 12, 2023'
  static String formatDateCompact(DateTime date) {
    final months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ];

    return '${months[date.month - 1]} ${date.day}, ${date.year}';
  }

  /// Gets the abbreviation for a month number
  static String _getMonthName(int month) {
    const months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ];
    return months[month - 1];
  }

  /// Gets month number from abbreviated month name
  static int _getMonthNumber(String monthName) {
    const months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ];
    return months.indexOf(monthName) + 1;
  }
}
