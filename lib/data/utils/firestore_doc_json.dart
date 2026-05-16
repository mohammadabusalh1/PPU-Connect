/// Merges Firestore document fields with the document id.
///
/// Stored JSON may include `id: ""` from [toJson]; [docId] must win.
Map<String, dynamic> mergeFirestoreDocId(
  String docId,
  Map<String, dynamic> data,
) =>
    {...data, 'id': docId};
