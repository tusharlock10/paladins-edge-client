import "dart:math";

List<T> insertBetween<T>(List<T> list, T obj) {
  List<T> newList = [];
  for (int index = 0; index < list.length; index++) {
    if (index != 0) {
      newList.add(obj);
    }
    newList.add(list[index]);
  }

  return newList;
}

T? selectRandom<T>(List<T> list, {T? skipElement}) {
  final newList = List.from(list);
  if (skipElement != null) newList.remove(skipElement);
  if (newList.isEmpty) return null;

  Random random = Random();
  int randomIndex = random.nextInt(newList.length);

  return newList[randomIndex];
}
