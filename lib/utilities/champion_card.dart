String _getScaledAmount(String scale, int amount) {
  final temp = scale.split('|');

  final base = double.tryParse(temp.first) ?? 0;
  final adder = double.tryParse(temp[1]) ?? 0;

  final sum = base + (adder * amount);

  if (sum == sum.toInt()) {
    return sum.toInt().toString();
  }

  return sum.toStringAsFixed(2);
}

List<String> getDescriptionParts(String desc) {
  const splitter = "%*%";
  desc = desc.replaceAll("}", splitter);
  desc = desc.replaceAll("{scale=", splitter);
  final parts = desc.split(splitter);

  return parts;
}

String getParsedDescription(List<String> descriptionParts, int amount) {
  String desc = '';

  for (int index = 0; index < descriptionParts.length; index++) {
    final descriptionPart = descriptionParts[index];
    index % 2 == 0
        ? desc = desc + descriptionPart
        : desc = desc + _getScaledAmount(descriptionPart, amount);
  }

  return desc;
}

void main() {
  String desc =
      "Heal for {scale=100|-7.5} every 0.5s for {scale=0.5|0.5}s after activating Dash. This effect stacks.";

  final descriptionParts = getDescriptionParts(desc);
  final parsedDescription = getParsedDescription(descriptionParts, 1);
}
