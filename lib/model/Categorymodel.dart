class Categorymodel {
  final int id;
  final String name;
  final String slug;
  final String image;
  final List<Subcategory> subcategories;

  Categorymodel({
    required this.id,
    required this.name,
    required this.slug,required this.image,
    required this.subcategories,
  });

  factory Categorymodel.fromJson(Map<String, dynamic> json) {
    var subcategoriesJson = json['subcategory'] as List;
    List<Subcategory> subcategoriesList =
    subcategoriesJson.map((subcategoryJson) => Subcategory.fromJson(subcategoryJson)).toList();

    return Categorymodel(
      id: json['id'],
      name: json['name'],
      slug: json['slug'],image: json['image'],
      subcategories: subcategoriesList,
    );
  }
}

class Subcategory {
  final int subcategoryId;
  final String name;
  final String slug;
  final String image;

  Subcategory({
    required this.subcategoryId,
    required this.name,
    required this.slug,required this.image
  });

  factory Subcategory.fromJson(Map<String, dynamic> json) {
    return Subcategory(
        subcategoryId: json['subcategoryID'],
        name: json['name'],
        slug: json['slug'],image: json['image']
    );
  }
}
