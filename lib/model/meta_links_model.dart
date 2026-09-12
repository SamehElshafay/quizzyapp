class MetaLinksModel {
  String? url;
  String? label;
  bool? active;

  MetaLinksModel({this.url, this.label, this.active});

  factory MetaLinksModel.fromJson(Map<String, dynamic> json) {
    return MetaLinksModel(
        url: json['url'], label: json['label'], active: json['active']);
  }

  Map<String, dynamic> toJson() {
    return {'url': url, 'label': label, 'active': active};
  }
}
