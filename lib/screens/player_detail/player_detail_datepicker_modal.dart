import "package:flutter/material.dart";
import "package:paladinsedge/data_classes/index.dart" as data_classes;
import "package:paladinsedge/utilities/index.dart" as utilities;
import "package:syncfusion_flutter_datepicker/datepicker.dart";

typedef OnSelectCallback = void Function(Object?);

void _onSelectDateRange(
  BuildContext context,
  Object? value,
  data_classes.MatchFilterValue filterValue,
  void Function(data_classes.MatchFilterValue) onDateSelect,
) {
  if (value is PickerDateRange) {
    final dateValue = {
      "startDate": value.startDate,
      "endDate": value.endDate,
    };
    onDateSelect(data_classes.MatchFilterValue(
      value: filterValue.value,
      valueName: filterValue.valueName,
      type: filterValue.type,
      dateValue: dateValue,
    ));
    utilities.Navigation.pop(context);
  }
}

void showPlayerDetailDatePickerModal(
  BuildContext context,
  data_classes.MatchFilterValue filterValue,
  void Function(data_classes.MatchFilterValue) onDateSelect,
) {
  showDialog(
    context: context,
    builder: (_) {
      return Dialog(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        clipBehavior: Clip.hardEdge,
        child: _PlayerDetailDatePickerModal(
          onSelect: (value) => _onSelectDateRange(
            context,
            value,
            filterValue,
            onDateSelect,
          ),
        ),
      );
    },
  );
}

class _PlayerDetailDatePickerModal extends StatelessWidget {
  final OnSelectCallback onSelect;

  const _PlayerDetailDatePickerModal({
    required this.onSelect,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Variables
    final theme = Theme.of(context);

    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.5,
      child: SfDateRangePicker(
        backgroundColor: theme.cardTheme.color,
        view: DateRangePickerView.month,
        selectionMode: DateRangePickerSelectionMode.range,
        maxDate: DateTime.now(),
        allowViewNavigation: false,
        endRangeSelectionColor: theme.primaryColor,
        startRangeSelectionColor: theme.primaryColor,
        selectionShape: DateRangePickerSelectionShape.rectangle,
        selectionTextStyle: theme.textTheme.headline1?.copyWith(fontSize: 18),
        rangeTextStyle: theme.textTheme.headline1?.copyWith(
          fontSize: 18,
          fontWeight: FontWeight.normal,
        ),
        rangeSelectionColor: theme.bottomSheetTheme.backgroundColor,
        todayHighlightColor: theme.textTheme.bodyText2?.color,
        headerStyle: DateRangePickerHeaderStyle(
          textStyle: theme.textTheme.headline1?.copyWith(fontSize: 14),
          backgroundColor: theme.appBarTheme.backgroundColor,
          textAlign: TextAlign.center,
        ),
        monthCellStyle: DateRangePickerMonthCellStyle(
          disabledDatesTextStyle: theme.textTheme.bodyText1?.copyWith(
            fontSize: 12,
          ),
          textStyle: theme.textTheme.bodyText2?.copyWith(fontSize: 14),
          todayTextStyle: theme.textTheme.bodyText2?.copyWith(fontSize: 14),
        ),
        viewSpacing: 10,
        headerHeight: 64,
        confirmText: "Select",
        cancelText: "Cancel",
        showActionButtons: true,
        toggleDaySelection: true,
        onCancel: () => utilities.Navigation.pop(context),
        onSubmit: onSelect,
      ),
    );
  }
}
