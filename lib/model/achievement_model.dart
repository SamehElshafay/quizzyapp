class AchievementModel {
  bool? success;
  Data? data;
  String? message;

  AchievementModel({this.success, this.data, this.message});

  factory AchievementModel.fromJson(Map<String, dynamic> json) {
    return AchievementModel(
      message: json['message'],
      success: json['success'],
      data: json['data'] != null ? Data.fromJson(json['data']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'message': message,
      'success': success,
      'data': data != null ? data!.toJson() : {}
    };
  }
}

class Data {
  String? totalEarnedMarks;
  String? totalQuestions;
  String? yourRanking;
  String? numberCorrectAnswer;
  Chart? chart;

  Data(
      {this.totalEarnedMarks,
      this.totalQuestions,
      this.yourRanking,
      this.numberCorrectAnswer,
      this.chart});

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
        totalEarnedMarks: json['totalEarnedMarks'],
        totalQuestions: json['totalQuestions'],
        yourRanking: json['yourRanking'],
        numberCorrectAnswer: json['numberCorrectAnswer'],
        chart: json['chart'] != null ? Chart.fromJson(json['chart']) : null);
  }

  Map<String, dynamic> toJson() {
    return {
      'yourRanking': yourRanking,
      'numberCorrectAnswer': numberCorrectAnswer,
      'totalQuestions': totalQuestions,
      'totalEarnedMarks': totalEarnedMarks,
      'chart': chart != null ? chart!.toJson() : {},
    };
  }
}

class Chart {
  List<String>? labels;
  List<int>? data;
  int? totalEarnedMarks;

  Chart({this.labels, this.data, this.totalEarnedMarks});

  factory Chart.fromJson(Map<String, dynamic> json) {
    return Chart(
        data: json['data'].cast<int>(),
        labels: json['labels'].cast<String>(),
        totalEarnedMarks: json['totalEarnedMarks']);
  }

  Map<String, dynamic> toJson() {
    return {
      'totalEarnedMarks': totalEarnedMarks,
      'labels': labels,
      'data': data
    };
  }
}
