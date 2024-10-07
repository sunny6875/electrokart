import 'Self.dart';
import 'Collection.dart';
import 'Up.dart';

class Links {
  Links({
      this.self, 
      this.collection, 
      this.up,});

  Links.fromJson(dynamic json) {
    if (json['self'] != null) {
      self = [];
      json['self'].forEach((v) {
        self?.add(Self.fromJson(v));
      });
    }
    if (json['collection'] != null) {
      collection = [];
      json['collection'].forEach((v) {
        collection?.add(Collection.fromJson(v));
      });
    }
    if (json['up'] != null) {
      up = [];
      json['up'].forEach((v) {
        up?.add(Up.fromJson(v));
      });
    }
  }
  List<Self>? self;
  List<Collection>? collection;
  List<Up>? up;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (self != null) {
      map['self'] = self?.map((v) => v.toJson()).toList();
    }
    if (collection != null) {
      map['collection'] = collection?.map((v) => v.toJson()).toList();
    }
    if (up != null) {
      map['up'] = up?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}