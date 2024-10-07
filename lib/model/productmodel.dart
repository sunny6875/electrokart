class Product {
  final int id;
  final String name;
  final String slug;
  final String price;
  final String regularPrice;
  final String salePrice;
  final bool reviewsAllowed;
  final String averageRating;
  final int ratingCount;
  final int parentId;
  final String description;
  final List<Category> categories;
  final List<Image> images;
  final List<Attribute> attributes;

  Product({
    required this.id,
    required this.name,
    required this.slug,
    required this.price,
    required this.regularPrice,
    required this.salePrice,
    required this.reviewsAllowed,
    required this.averageRating,
    required this.ratingCount,
    required this.parentId,
    required this.description,
    required this.categories,
    required this.images,
    required this.attributes,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      name: json['name'],
      slug: json['slug'],
      price: json['price'],
      regularPrice: json['regular_price'],
      salePrice: json['sale_price'],
      reviewsAllowed: json['reviews_allowed'],
      averageRating: json['average_rating'],
      ratingCount: json['rating_count'],
      parentId: json['parent_id'],
      description: json['description'],
      categories: (json['categories'] as List<dynamic>)
          .map((categoryJson) => Category.fromJson(categoryJson))
          .toList(),
      images: (json['images'] as List<dynamic>)
          .map((imageJson) => Image.fromJson(imageJson))
          .toList(),
      attributes: (json['attributes'] as List<dynamic>)
          .map((attributeJson) => Attribute.fromJson(attributeJson))
          .toList(),
    );
  }
}

class Category {
  final int id;
  final String name;
  final String slug;

  Category({
    required this.id,
    required this.name,
    required this.slug,
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['id'],
      name: json['name'],
      slug: json['slug'],
    );
  }
}

class Image {
  final int id;
  final String dateCreated;
  final String dateCreatedGmt;
  final String dateModified;
  final String dateModifiedGmt;
  final String src;
  final String name;
  final String alt;

  Image({
    required this.id,
    required this.dateCreated,
    required this.dateCreatedGmt,
    required this.dateModified,
    required this.dateModifiedGmt,
    required this.src,
    required this.name,
    required this.alt,
  });

  factory Image.fromJson(Map<String, dynamic> json) {
    return Image(
      id: json['id'],
      dateCreated: json['date_created'],
      dateCreatedGmt: json['date_created_gmt'],
      dateModified: json['date_modified'],
      dateModifiedGmt: json['date_modified_gmt'],
      src: json['src'],
      name: json['name'],
      alt: json['alt'],
    );
  }
}

class Attribute {
  final int id;
  final String name;
  final String slug;
  final int position;
  final bool visible;
  final bool variation;
  final List<String> options;

  Attribute({
    required this.id,
    required this.name,
    required this.slug,
    required this.position,
    required this.visible,
    required this.variation,
    required this.options,
  });

  factory Attribute.fromJson(Map<String, dynamic> json) {
    return Attribute(
      id: json['id'],
      name: json['name'],
      slug: json['slug'],
      position: json['position'],
      visible: json['visible'],
      variation: json['variation'],
      options: List<String>.from(json['options']),
    );
  }
}
