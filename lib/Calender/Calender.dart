class Calendar{
  final DateTime date;
  final bool thisMonth;
  final bool prevMonth;
  final bool nextMonth;
  Calendar({
    required this.date,
    this.thisMonth = false,
    this.prevMonth = false,
    this.nextMonth = false
  });

}