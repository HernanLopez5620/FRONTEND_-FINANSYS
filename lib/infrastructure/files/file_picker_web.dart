// infrastructure/files/file_picker_web.dart
// Abre el selector de archivos del navegador y devuelve el contenido.
// Solo Flutter Web: igual que file_saver.dart, usa dart:html.

import 'dart:async';
import 'dart:typed_data';
// ignore: avoid_web_libraries_in_flutter
import 'dart:html' as html;

class ArchivoElegido {
  final String nombre;
  final Uint8List bytes;
  const ArchivoElegido(this.nombre, this.bytes);
}

class FilePickerWeb {
  FilePickerWeb._();

  /// Devuelve el archivo elegido, o null si el usuario cancela.
  static Future<ArchivoElegido?> elegir({String accept = '.csv,.xlsx'}) {
    final completer = Completer<ArchivoElegido?>();
    final input = html.FileUploadInputElement()..accept = accept;

    input.onChange.listen((_) {
      final archivo =
          input.files?.isNotEmpty == true ? input.files!.first : null;
      if (archivo == null) {
        if (!completer.isCompleted) completer.complete(null);
        return;
      }
      final lector = html.FileReader();
      lector.onLoadEnd.listen((_) {
        final r = lector.result;
        Uint8List? bytes;
        if (r is Uint8List) {
          bytes = r;
        } else if (r is ByteBuffer) {
          bytes = Uint8List.view(r);
        }
        if (!completer.isCompleted) {
          completer.complete(
              bytes == null ? null : ArchivoElegido(archivo.name, bytes));
        }
      });
      lector.onError.listen((_) {
        if (!completer.isCompleted) completer.complete(null);
      });
      lector.readAsArrayBuffer(archivo);
    });

    // Cuando el navegador lo soporta, avisa si se cerró el selector sin elegir nada
    input.addEventListener('cancel', (_) {
      if (!completer.isCompleted) completer.complete(null);
    });

    input.click();
    return completer.future;
  }
}
