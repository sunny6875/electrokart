class Subcategorymodel {
  List<Category> categories;

  Subcategorymodel({
    required this.categories,
  });

}

class Category {
  int id;
  String name;
  String slug;
  int count;
  dynamic image;
  List<Subcategory> subcategory;

  Category({
    required this.id,
    required this.name,
    required this.slug,
    required this.count,
    required this.image,
    required this.subcategory,
  });

}

class ImageClass {
  int id;
  DateTime dateCreated;
  DateTime dateCreatedGmt;
  DateTime dateModified;
  DateTime dateModifiedGmt;
  String src;
  String name;
  String alt;

  ImageClass({
    required this.id,
    required this.dateCreated,
    required this.dateCreatedGmt,
    required this.dateModified,
    required this.dateModifiedGmt,
    required this.src,
    required this.name,
    required this.alt,
  });

}

class Subcategory {
  int subcategoryId;
  String name;
  String slug;
  dynamic image;

  Subcategory({
    required this.subcategoryId,
    required this.name,
    required this.slug,
    required this.image,
  });

}
