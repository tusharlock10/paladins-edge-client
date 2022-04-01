import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:paladinsedge/api/index.dart' as api;
import 'package:paladinsedge/models/index.dart' as models;
import 'package:paladinsedge/utilities/index.dart' as utilities;

class _FeedbackNotifier extends ChangeNotifier {
  bool isSubmitting = false;
  String description = '';
  String selectedFeedbackType = models.FeedbackTypes.featureRequest;
  FilePickerResult? selectedImage;

  /// Opens the file picker to select images
  void pickFeedbackImage() async {
    final result = await FilePicker.platform.pickFiles(
      allowMultiple: false,
      type: FileType.image,
    );

    if (result != null) {
      selectedImage = result;
    }

    utilities.postFrameCallback(notifyListeners);
  }

  /// Changes feedbackType
  void changeDescription(String text) {
    description = text;
    utilities.postFrameCallback(notifyListeners);
  }

  /// Changes feedbackType
  void changeFeedbackType(String feedbackType) {
    selectedFeedbackType = feedbackType;
    utilities.postFrameCallback(notifyListeners);
  }

  /// Submit the feedback
  Future<void> submitFeedback() async {
    isSubmitting = true;
    utilities.postFrameCallback(notifyListeners);

    final imageUrl = await _uploadImage();

    final feedback = models.Feedback(
      description: description,
      type: selectedFeedbackType,
      imageUrl: imageUrl,
    );

    await api.FeedbackRequests.submitFeedback(feedback: feedback);

    isSubmitting = false;
    utilities.postFrameCallback(notifyListeners);
  }

  /// Clears all data
  void clearData() {
    isSubmitting = false;
    selectedImage = null;
  }

  /// Upload image to aws s3 bucket
  Future<String?> _uploadImage() async {
    final fileName = selectedImage?.names.first;

    if (fileName == null) return null;
    final response =
        await api.FeedbackRequests.uploadImageUrl(fileName: fileName);

    final filePath = selectedImage?.files.first.path;
    if (response != null && filePath != null) {
      await utilities.uploadFile(url: response.uploadUrl, filePath: filePath);

      return response.imageUrl;
    }

    return null;
  }
}

/// Provider to handle feedback
final feedback = ChangeNotifierProvider((_) => _FeedbackNotifier());
