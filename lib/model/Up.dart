class Up {
  Up({
      this.href,});

  Up.fromJson(dynamic json) {
    href = json['href'];
  }
  String? href;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['href'] = href;
    return map;
  }

}