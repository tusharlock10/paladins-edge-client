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
