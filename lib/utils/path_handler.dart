
class PathHandler {
  static List<int> extractIndexes(String pathId) {
    List<int> indexList = [];
    RegExp intRegex = RegExp(r"\d+");
    Iterable<RegExpMatch> matches = intRegex.allMatches(pathId);
    for (final match in matches) {
      indexList.add(int.parse(match.group(0)!));
    }
    return indexList;
  }
}