import 'package:quikhyr_worker/common/quik_secure_constants.dart';
import 'package:http/http.dart' as http;

class ServiceAndSubservicesDataProvider {
  Future<String> getServicesData() async {
    try {
      final url = Uri.parse('$baseUrl/services');
      final response = await http.get(url);

      if (response.statusCode == 200) {
        return response.body;
      } else {
        return 'Failed to get services ${response.body}';
      }
    } catch (e) {
      return 'Failed to get services: $e';
    }
  }

  Future<String> getSubservicesByServiceIdData(String serviceId) async {
    try {
      final url = Uri.https(baseUrl, '/services/subservices', {'serviceId': serviceId});
      final response = await http.get(url);

      if (response.statusCode == 200) {
        return response.body;
      } else {
        return 'Failed to get subservices ${response.body}';
      }
    } catch (e) {
      return 'Failed to get subservices: $e';
    }
  }
}
