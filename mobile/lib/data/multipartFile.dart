import 'dart:io';
import 'dart:typed_data';

class MultipartFile {
  String filename;
  List<int> data;
  MultipartFile({this.filename, this.data});

  static Future<MultipartFile> fromPath(String path) async {
    return MultipartFile(
      filename: path.split('/').last,
      data: await _readPathBytes(path),
    );
  }

  static Future<MultipartFile> fromFile(File file) async {
    return MultipartFile(
      filename: file.path.split('/').last,
      data: await _readFileBytes(file),
    );
  }

  static Future<Uint8List> _readPathBytes(String filePath) async {
    return Uint8List.fromList(
        await File.fromUri(Uri.parse(filePath)).readAsBytes());
  }

  static Future<Uint8List> _readFileBytes(File file) async {
    return Uint8List.fromList(await file.readAsBytes());
  }
}
