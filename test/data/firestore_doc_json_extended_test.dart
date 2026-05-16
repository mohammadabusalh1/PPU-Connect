import 'package:flutter_test/flutter_test.dart';
import 'package:ppu_connect/data/utils/firestore_doc_json.dart';

void main() {
  group('mergeFirestoreDocId', () {
    test('overwrites empty stored id with docId', () {
      final result = mergeFirestoreDocId('abc123', {'id': '', 'subject': 'Math'});
      expect(result['id'], 'abc123');
    });

    test('overwrites non-empty stored id with docId', () {
      final result = mergeFirestoreDocId('newId', {'id': 'oldId', 'name': 'Test'});
      expect(result['id'], 'newId');
    });

    test('preserves all other fields', () {
      final data = {'id': '', 'subject': 'Math', 'rate': 50.0, 'active': true};
      final result = mergeFirestoreDocId('doc1', data);
      expect(result['subject'], 'Math');
      expect(result['rate'], 50.0);
      expect(result['active'], isTrue);
    });

    test('adds id when not present in original data', () {
      final result = mergeFirestoreDocId('doc42', {'name': 'Tutor'});
      expect(result['id'], 'doc42');
      expect(result['name'], 'Tutor');
    });

    test('does not mutate the original map', () {
      final original = {'id': 'old', 'field': 'value'};
      mergeFirestoreDocId('new', original);
      expect(original['id'], 'old');
    });

    test('handles empty data map', () {
      final result = mergeFirestoreDocId('onlyId', {});
      expect(result, {'id': 'onlyId'});
    });
  });
}
