class TimeZoneModel {
  final String timeZone;
  final String currentTime;

  TimeZoneModel({
    required this.timeZone,
    required this.currentTime,
  });

  factory TimeZoneModel.fromJson(Map<String, dynamic> json) {
    final data = json['data'];
    final timeZone = data != null ? data['timezone']['id'] as String : '';
    final currentTime =
        data != null ? data['datetime']['date_time'] as String : '';
    return TimeZoneModel(
      timeZone: timeZone,
      currentTime: currentTime,
    );
  }
}
