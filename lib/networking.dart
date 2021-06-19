import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class Networker {
  var url;
  var data;
  var decodedData;
  Networker(this.url);

  Future<dynamic> getData() async {
    http.Response response = await http.get(url);
    if (response.statusCode == 200) {
      // print(response.body);
      data = response.body;
      decodedData = convert.jsonDecode(data);
    } else {
      print(response.statusCode);
    }
    return decodedData;
  }
}
