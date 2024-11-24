class PathHandler {
  static int extractLastIndex(String pathId) {
    RegExp intRegex = RegExp(r"\d+");
    Iterable<RegExpMatch> match = intRegex.allMatches(pathId);
    String? matchGroup = match.last.group(0);
    if (matchGroup != null) {
      return int.parse(matchGroup);
    }
    return 0;
  }
}