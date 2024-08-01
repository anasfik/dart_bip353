# dart_bip353

A Dart package to work with the [BIP353](https://bips.dev/353/), resolving payment details from a given address like `test@twelve.cash` and get the bol 12 offer, onchain address and lnurl...

## Usage

A simple usage example:

```dart
// get the DNS query for the given address.
final dnsQuery = Bip353.buildDnsQueryFromRawAddress("test@twelve.cash");
print(dnsQuery); // test.user._bitcoin-payment.twelve.cash

// get payment details from the given address, inclusing bolt12 offerr, bitcoin onchain address and lnurl.
final data = await Bip353.getAdressResolve("test@twelve.cash");
print(data.onchain); // bc1p73p4sc52mdamccfrth4gn8wull0h7ywkzzn6d8e2mxqr4m7evdqqwusn64

print(data.offer); // lno1pqqq5xj5wajkcan9gdshx6pq23jhxarfdenjqstyv3ex2umnzcss80xkrjkyrjk43u5dgu8f6a450fg2cnjtg7lhg76c3gtk5gdhshns

print(data.lnurl); // lnurl1dp68gurn8ghj7anvwshxwef09emk2mrv944kummhdchkcmn4wfk8qte3xf6x2um50n5cup

// do something with the bolt 12 offer.
// ...
```

## Features and bugs

Please file feature requests and bugs at the [issue tracker][issues].

## License

MIT License, see [LICENSE](LICENSE).
