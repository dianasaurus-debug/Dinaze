import 'package:bloc/bloc.dart';
import 'package:learning_text_recognition/learning_text_recognition.dart';
import 'package:learning_input_image/learning_input_image.dart';
import 'package:validators/validators.dart';

abstract class KtpOcrState {}

class KtpOcrInitialState extends KtpOcrState {}

class KtpOcrFailureState extends KtpOcrState {
  final String message;

  KtpOcrFailureState(this.message);
}

class KtpOcrSuccessState extends KtpOcrState {
  final String nik;
  final String name;

  KtpOcrSuccessState(this.nik, this.name);
}

class KtpOcrCubit extends Cubit<KtpOcrState> {
  KtpOcrCubit() : super(KtpOcrInitialState());

  bool _isName(String text) {
    return RegExp(r"^[a-zA-Z_ ]*$").hasMatch(text) && isUppercase(text);
  }

  bool _isNik(String text) {
    return RegExp(
            r"^(1[1-9]|21|[37][1-6]|5[1-3]|6[1-5]|[89][12])\d{2}\d{2}([04][1-9]|[1256][0-9]|[37][01])(0[1-9]|1[0-2])\d{2}\d{4}$")
        .hasMatch(text);
  }

  startRecognize(String imagePath) async {
    print("START RECOGNIZE");
    final TextRecognition _textRecognition = TextRecognition();
    final InputImage _inputImage = InputImage.fromFilePath(imagePath);
    final _result = await _textRecognition.process(_inputImage);

    if (_result != null) {
      _findData(_result);
      _textRecognition.dispose();
    }
  }

  _findData(RecognizedText recognizedText) {
    print("FIND DATA");
    bool nikFound = false;
    bool afterName = false;
    bool nameFound = false;
    String? fullName;
    String? identityNumber;

    for (final textBlock in recognizedText.blocks) {
      final String textOfTextBlock = textBlock.text.trim();

      if (textOfTextBlock.contains("Nama")) afterName = true;

      for (final textLine in textBlock.lines) {
        final String textOfTextLine = textLine.text.trim();

        if (!nameFound && afterName && _isName(textOfTextLine)) {
          fullName = textOfTextLine;
          nameFound = true;
        }

        for (final textElement in textLine.elements) {
          final String textOfTextElement = textElement.text.trim();

          if (!nikFound && _isNik(textOfTextElement)) {
            identityNumber = textOfTextElement;
            nikFound = true;
          }
        }
      }
    }

    if (fullName != null && identityNumber != null) {
      emit(KtpOcrSuccessState(identityNumber, fullName));
    } else {
      emit(KtpOcrFailureState("Gagal membaca KTP Anda"));
    }
  }
}
