import 'package:quizzy_app/model/meta_links_model.dart';

class MetaModel {
  int? currentPage;
  int? from;
  int? lastPage;
  List<MetaLinksModel>? links;
  String? path;
  int? perPage;
  int? to;
  int? total;

  MetaModel(
      {this.currentPage,
      this.from,
      this.lastPage,
      this.links,
      this.path,
      this.perPage,
      this.to,
      this.total});

  factory MetaModel.fromJson(Map<String, dynamic> json) {
    List<MetaLinksModel> list = [];

    if (json['links'] != null) {
      ;
      json['links'].forEach((v) {
        list!.add(MetaLinksModel.fromJson(v));
      });
    }

    return MetaModel(
        path: json['path'],
        perPage: json['per_page'],
        to: json['to'],
        total: json['total'],
        currentPage: json['current_page'],
        from: json['from'],
        lastPage: json['last_page'],
        links: list);
  }

  Map<String, dynamic> toJson() {
    return {
      'total': total,
      'to': to,
      'per_page': perPage,
      'path': path,
      'last_page': lastPage,
      'from': from,
      'current_page': currentPage,
      'links': links != null ? links!.map((v) => v.toJson()).toList() : []
    };
  }
}
