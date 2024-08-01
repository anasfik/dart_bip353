import 'package:equatable/equatable.dart';

class Bip353DnsResolveResponse extends Equatable {
  final String? onchain;
  final String? offer;
  final String? lnurl;

  Bip353DnsResolveResponse({
    required this.onchain,
    required this.offer,
    required this.lnurl,
  });

  @override
  List<Object?> get props => [
        onchain,
        offer,
        lnurl,
      ];

  factory Bip353DnsResolveResponse.fromRawQueryData(String data) {
    String cleanedString = Uri.decodeComponent(data
        .replaceAll(r'\"', '')
        .replaceAll(r'"', '')
        .replaceAll(r' ', '')
        .replaceAll(r'\\', ''));

    if (!cleanedString.startsWith("bitcoin")) {
      throw Exception(
        "DNS record found but doesn't start with 'bitcoin:', $cleanedString",
      );
    }

// bitcoin:?lno=lno1pqqq5xj5wajkcan9gdshx6pq23jhxarfdenjqstyv3ex2umnzcss80xkrjkyrjk43u5dgu8f6a450fg2cnjtg7lhg76c3gtk5gdhshns&lnurl=lnurl1dp68gurn8ghj7anvwshxwef09emk2mrv944kummhdchkcmn4wfk8qte3xf6x2um50n5cup

    final resolveSplit = cleanedString.split(":");

    if (resolveSplit.length < 2) {
      throw Exception("Invalid DNS record");
    }

    final bcAddress = resolveSplit.last;

    final addressSplit = bcAddress.split("?");

    if (addressSplit.length < 2) {
      throw Exception("Invalid DNS record");
    }

    String? addressOnly = addressSplit.first;

    if (addressOnly.isEmpty) {
      addressOnly = null;
    }

    final asUriQueries = Uri.splitQueryString(addressSplit.last);

    return Bip353DnsResolveResponse(
      onchain: addressOnly,
      offer: asUriQueries["lno"],
      lnurl: asUriQueries["lnurl"],
    );
  }
}
