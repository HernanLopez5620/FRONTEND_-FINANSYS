// infrastructure/files/file_saver.dart
// Guarda un archivo en el equipo del usuario (descarga del navegador).
// Solo Flutter Web: igual que local_storage_adapter.dart, usa dart:html.

import 'dart:typed_data';
// ignore: avoid_web_libraries_in_flutter
import 'dart:html' as html;

class FileSaver {
  FileSaver._();

  static void guardar(Uint8List bytes, String nombre, String mime) {
    final blob = html.Blob([bytes], mime);
    final url = html.Url.createObjectUrlFromBlob(blob);
    final enlace = html.AnchorElement(href: url)
      ..download = nombre
      ..style.display = 'none';
    html.document.body?.append(enlace);
    enlace.click();
    enlace.remove();
    // Se libera la URL un poco después para no cortar la descarga
    Future.delayed(const Duration(seconds: 2), () {
      html.Url.revokeObjectUrl(url);
    });
  }
}
