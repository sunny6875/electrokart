class URL {
  static String baseUrl = 'https://electrokart.in/wp-json/wc/v3/';
  static String secretKey = 'cs_1149e2a8fd3d217f302e32e678116878c9734568';
  static String consumerKey = 'ck_4152b69928939ccd96136fa2174e50b05163fc5e';

  String endpoint;
  String? perPage;
  String? page;

  URL(this.endpoint, {this.perPage, this.page});

  String getCompleteUrl() {
    String completeUrl = '$baseUrl$endpoint';

    // Append query parameters if provided
    if (perPage != null) {
      completeUrl += '?per_page=$perPage';
    }
    if (page != null) {
      completeUrl += (perPage != null ? '&' : '?') + 'page=$page';
    }

    // Append secret key and consumer key
    completeUrl += '&consumer_key=$consumerKey&consumer_secret=$secretKey';

    return completeUrl;
  }
}