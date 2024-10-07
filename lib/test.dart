import 'package:http/http.dart' as http;

class Product{
  Future getProducts()async {
    var headers = {
      'Cookie': 'PHPSESSID=oktgrq0cnk6244k33b5ds8b8ko; search_suggestions_session_id=64e89692dd87f'
    };
    var request = http.MultipartRequest('GET', Uri.parse(
        'https://electrokart.in/wp-json/subcategories/v1/categories?consumer_key=ck_7c45c5f767cedf8a03771d898cd91519f0cca962&consumer_secret=cs_5094841147a50fc834d7fa843a40e87e772a9228'));
    request.fields.addAll({
      'consumer_key': 'ck_7c45c5f767cedf8a03771d898cd91519f0cca962',
      'consumer_secret': 'cs_5094841147a50fc834d7fa843a40e87e772a9228'
    });

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
    }
    else {
      print(response.reasonPhrase);
    }
  }}