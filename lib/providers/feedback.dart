import 'dart:typed_data';

import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:paladinsedge/api/index.dart' as api;
import 'package:paladinsedge/models/index.dart' as models;
import 'package:paladinsedge/utilities/index.dart' as utilities;

class _FeedbackNotifier extends ChangeNotifier {
  bool isSubmitting = false;
  String description = '';
  String selectedFeedbackType = models.FeedbackTypes.featureRequest;
  XFile? selectedImage;
  Uint8List? selectedImageBytes;

  /// Opens the file picker to select images
  void pickFeedbackImage() async {
    final result = await ImagePicker().pickImage(source: ImageSource.gallery);

    if (result != null) {
      selectedImage = result;
      selectedImageBytes = await selectedImage!.readAsBytes();
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
  Future<bool> submitFeedback() async {
    isSubmitting = true;
    utilities.postFrameCallback(notifyListeners);

    String? imageUrl;
    if (selectedImage != null) {
      imageUrl = await _uploadImage();
      if (imageUrl == null) {
        isSubmitting = false;
        utilities.postFrameCallback(notifyListeners);
      }
    }

    final feedback = models.Feedback(
      description: description,
      type: selectedFeedbackType,
      imageUrl: imageUrl,
    );

    final response =
        await api.FeedbackRequests.submitFeedback(feedback: feedback);

    isSubmitting = false;
    utilities.postFrameCallback(notifyListeners);

    return response != null;
  }

  /// Clears all data
  void clearData() {
    isSubmitting = false;
    description = '';
    selectedFeedbackType = models.FeedbackTypes.featureRequest;
    selectedImage = null;
    selectedImageBytes = null;
  }

  /// Upload image to aws s3 bucket
  Future<String?> _uploadImage() async {
    if (selectedImage == null) return null;

    final response = await api.FeedbackRequests.uploadImageUrl(
      fileName: selectedImage!.name,
    );

    if (response == null) return null;

    final result = await utilities.uploadImage(
      url: response.uploadUrl,
      image: selectedImage!,
    );

    return result ? response.imageUrl : null;
  }
}

/// Provider to handle feedback
final feedback = ChangeNotifierProvider((_) => _FeedbackNotifier());
