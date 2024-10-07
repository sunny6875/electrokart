class   Customer {
  final int id;
  final String dateCreated;
  final String dateCreatedGmt;
  final String dateModified;
  final String dateModifiedGmt;
  final String email;
  final String firstName;
  final String lastName;
  final String role;
  final String username;
  final Map<String, dynamic> billing;
  final Map<String, dynamic> shipping;
  final bool isPayingCustomer;
  final String avatarUrl;
  final List<dynamic> metaData;
  final Map<String, dynamic> links;

  Customer({
    required this.id,
    required this.dateCreated,
    required this.dateCreatedGmt,
    required this.dateModified,
    required this.dateModifiedGmt,
    required this.email,

    required this.firstName,
    required this.lastName,
    required this.role,
    required this.username,
    required this.billing,
    required this.shipping,
    required this.isPayingCustomer,
    required this.avatarUrl,
    required this.metaData,
    required this.links,
  });

  factory Customer.fromJson(Map<String, dynamic> json) {
    return Customer(
      id: json['id'],
      dateCreated: json['date_created'],
      dateCreatedGmt: json['date_created_gmt'],
      dateModified: json['date_modified'],
      dateModifiedGmt: json['date_modified_gmt'],
      email: json['email'],

      firstName: json['first_name'],
      lastName: json['last_name'],
      role: json['role'],
      username: json['username'],
      billing: json['billing'],
      shipping: json['shipping'],
      isPayingCustomer: json['is_paying_customer'],
      avatarUrl: json['avatar_url'],
      metaData: json['meta_data'],
      links: json['_links'],
    );
  }
}
