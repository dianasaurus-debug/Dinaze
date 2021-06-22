import 'package:bloc/bloc.dart';
import 'package:learning_face_detection/learning_face_detection.dart';
import 'package:learning_input_image/learning_input_image.dart';

abstract class FaceDetectionState {}

class FaceDetectionInitialState extends FaceDetectionState {}

class FaceDetectionLoadingState extends FaceDetectionState {}

class FaceDetectionFailureState extends FaceDetectionState {
  final String message;

  FaceDetectionFailureState(this.message);
}

class FaceDetectionSuccessState extends FaceDetectionState {}

class FaceDetectionCubit extends Cubit<FaceDetectionState> {
  final FaceDetector _faceDetector = FaceDetector(
    mode: FaceDetectorMode.accurate,
    detectLandmark: true,
    detectContour: true,
    enableClassification: true,
    enableTracking: true,
  );

  FaceDetectionCubit() : super(FaceDetectionInitialState());

  detectFace(String path) async {
    emit(FaceDetectionLoadingState());

    final result = await _faceDetector.detect(InputImage.fromFilePath(path));

    if (result.length == 0) {
      emit(FaceDetectionFailureState("Tidak ada wajah terdeteksi"));
    } else if (result.length > 1) {
      emit(FaceDetectionFailureState("Wajah terdeteksi lebih dari satu"));
    } else {
      Face face = result[0];
      if (face.leftEyeOpenProbability! < 0.1 &&
          face.rightEyeOpenProbability! > 0.75) {
        emit(FaceDetectionSuccessState());
      } else {
        emit(FaceDetectionFailureState("Pose wajah belum sesuai"));
      }
    }

    _faceDetector.dispose();
  }
}
