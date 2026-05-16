import 'package:flutter_test/flutter_test.dart';
import 'package:ppu_connect/data/utils/firestore_doc_json.dart';

void main() {
  test('mergeFirestoreDocId uses document id over stored empty id', () {
    final json = mergeFirestoreDocId('abc123', {'id': '', 'subject': 'Math'});
    expect(json['id'], 'abc123');
    expect(json['subject'], 'Math');
  });
}
