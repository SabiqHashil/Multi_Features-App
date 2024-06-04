class TimeZoneModel {
  final String timeZone;
  final String currentTime;

  TimeZoneModel({
    required this.timeZone,
    required this.currentTime,
  });

  factory TimeZoneModel.fromJson(Map<String, dynamic> json) {
    return TimeZoneModel(
      timeZone: json['data']['timezone']['id'],
      currentTime: json['data']['datetime']
          ['date_time'], // Adjust based on your actual JSON structure
    );
  }
}
