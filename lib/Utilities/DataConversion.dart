// utilities to convert data from one form to another

const ReplaceList = {
  '<CMD=GBA_Ability_2>': 'Q',
  '<CMD=GBA_Ability_3>': 'F',
  '<CMD=GBA_Ability_4>': 'E',
  '<CMD=GBA_Jump>': 'Spacebar',
  '<CMD=GBA_Fire>': 'LMB',
  '<br>': '\n',
};

String convertAbilityDescription(String description) {
  ReplaceList.map((key, value) {
    description = description.replaceAll(key, value);
    return MapEntry(key, value);
  });
  return description;
}
