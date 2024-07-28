import 'package:firebase_storage/firebase_storage.dart';


enum Types {
  audio,
  cover,
}

class StoreService {
  StoreService._privateConstructor();
  static final StoreService _instance = StoreService._privateConstructor();

  static StoreService get instance => _instance; // Static getter for the instance

  Future<String> accessFile(String id, Types type) async {
    // Create a reference to the file
    FirebaseStorage storage = FirebaseStorage.instance;
    String filePath = id + (type == Types.audio ? '/audio.wav' : '/image.png');
    Reference ref = storage.refFromURL('gs://podai-425012.appspot.com/podcasts/$filePath');

    // To get a URL to the file
    try {
      String fileURL = await ref.getDownloadURL();
      return fileURL;
      // Use the file URL to download, stream, or display the file
    } catch (e) {
      return '';
    }
  }
}