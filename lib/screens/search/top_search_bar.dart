import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:paladinsedge/providers/index.dart' as providers;

class TopSearchBar extends ConsumerWidget {
  final textController = TextEditingController();
  final bool isLoading;
  final void Function(String) onSearch;

  TopSearchBar({
    required this.isLoading,
    required this.onSearch,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final searchProvider = ref.read(providers.players);
    final textStyle = theme.textTheme.headline6?.copyWith(
      color: Colors.white,
      fontSize: 16,
    );
    return SliverAppBar(
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarBrightness: theme.primaryColorBrightness,
      ),
      title: TextField(
        controller: textController,
        maxLength: 30,
        style: textStyle,
        cursorColor: theme.primaryColor,
        decoration: InputDecoration(
          hintText: 'Search player',
          counterText: "",
          hintStyle: textStyle,
          border: InputBorder.none,
          suffixIcon: IconButton(
            color: Colors.white,
            iconSize: 18,
            icon: const Icon(Icons.clear),
            onPressed: () {
              searchProvider.clearSearchList();
              textController.clear();
            },
          ),
        ),
      ),
      actions: [
        IconButton(
          icon: isLoading
              ? const SpinKitRing(
                  lineWidth: 2,
                  color: Colors.white,
                  size: 20,
                )
              : const Icon(Icons.search),
          onPressed: isLoading ? null : () => onSearch(textController.text),
        ),
      ],
      floating: true,
      elevation: 4,
      forceElevated: true,
      iconTheme: const IconThemeData(color: Colors.white),
      toolbarTextStyle: const TextStyle(color: Colors.white),
    );
  }
}
