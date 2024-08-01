import 'dart:convert';

import 'package:dart_bip353/src/response_model.dart';
import 'package:http/http.dart' as http;

class Bip353 {
  static final dnsResolver = "https://cloudflare-dns.com/dns-query";

  static Future<Bip353DnsResolveResponse> getAdressResolve(
    String address,
  ) async {
    try {
      final split = address.split("@");

      if (split.length != 2) {
        throw Exception("Invalid address");
      }

      final username = split[0];
      final domain = split[1];

      final headers = <String, String>{
        "Accept": "application/dns-json",
      };

      final query = buildDnsQuery(username, domain);

      final url = "$dnsResolver?name=$query&type=TXT";

      final uri = Uri.parse(url);

      final res = await http.get(
        uri,
        headers: headers,
      );

      final body = res.body;

      final decoded = jsonDecode(body) as Map<String, dynamic>;

      if (decoded["Status"] != 0) {
        throw Exception("Invalid response");
      }

      final authority = decoded["Answer"] as List<dynamic>;

      final firstOnly = authority.first as Map<String, dynamic>;

      final data = firstOnly["data"] as String;

      return Bip353DnsResolveResponse.fromRawQueryData(data);
    } catch (e) {
      print(e.toString());

      rethrow;
    }
  }

  static String buildDnsQueryFromRawAddress(String address) {
    final split = address.split("@");

    if (split.length != 2) {
      throw Exception("Invalid address");
    }

    final username = split[0];
    final domain = split[1];

    return buildDnsQuery(username, domain);
  }

  static String buildDnsQuery(String username, String domain) {
    return "$username.user._bitcoin-payment.$domain";
  }
}
