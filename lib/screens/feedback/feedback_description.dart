import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:paladinsedge/providers/index.dart' as providers;

class FeedbackDescription extends ConsumerWidget {
  const FeedbackDescription({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Providers
    final feedbackProvider = ref.read(providers.feedback);

    return Card(
      elevation: 10,
      clipBehavior: Clip.hardEdge,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(10),
        ),
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 10),
            margin: const EdgeInsets.symmetric(horizontal: 15),
            alignment: Alignment.centerLeft,
            decoration: const BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  width: 1,
                  color: Colors.grey,
                ),
              ),
            ),
            child: const Text(
              'Description',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          TextField(
            minLines: 5,
            maxLines: 10,
            decoration: const InputDecoration(
              contentPadding:
                  EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              border: InputBorder.none,
              hintText: 'Write your feedback here...',
            ),
            style: const TextStyle(fontSize: 18),
            onChanged: feedbackProvider.changeDescription,
          ),
        ],
      ),
    );
  }
}
