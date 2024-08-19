class FiveDayData {
  final String dateTime; 
  final double temp;

  FiveDayData({required this.dateTime, required this.temp});

  factory FiveDayData.fromJson(Map<String, dynamic> json) {
    var f = json['dt_txt'].split(' ')[0].split('-')[2];
    var l = json['dt_txt'].split(' ')[1].split(':')[0];
    var fandl = '$f-$l';
    return FiveDayData(
      dateTime: '$fandl',
      temp: (double.parse(json['main']['temp'].toString()) - 273.15),
    );
  }
}
