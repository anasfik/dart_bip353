import 'package:dart_bip353/dart_bip353.dart';

Future<void> main() async {
// get the DNS query for the given address.
  final dnsQuery = Bip353.buildDnsQueryFromRawAddress("test@twelve.cash");
  print(dnsQuery);

  // get payment details from the given address, inclusing bolt12 offerr, bitcoin onchain address and lnurl.
  final data = await Bip353.getAdressResolve("test@twelve.cash");
  print(data.onchain);
  print(data.offer);
  print(data.lnurl);
}
