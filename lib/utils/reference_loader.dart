// Class to handle reference loading with the components data
class ReferenceLoader {

  // referenceKey will be dot notation ie: characters.index.name
  static dynamic retrieveReferencedState(String referenceKey, dynamic state, Map<String, dynamic> options) {
    List<String> keyParts = referenceKey.split(".");
    if (keyParts.length == 1) {
      if (state is Map) {
        return state[keyParts.first];
      }
      return state;
    }
    String key = keyParts.removeAt(0);
    if (key == "index" && state is List) {
      if (!options.containsKey('index')) {
        return null;
      }
      // Index data are stored as a list of ints
      Map<String, dynamic> clonedOptions = Map.from(options);
      List<int> indexList = clonedOptions['index'] as List<int>;
      int index = indexList.removeAt(0);
      if (index > (state).length || index < 0) {
        return null;
      }
      ReferenceLoader.retrieveReferencedState(keyParts.join('.'), state[index], clonedOptions);
    }
    return ReferenceLoader.retrieveReferencedState(keyParts.join('.'), state[key], options);
  }

    // referenceKey will be dot notation ie: characters.index.name
  static dynamic altRetrieveReferencedState(String referenceKey, dynamic state) {
    List<String> keyParts = referenceKey.split(".");
    if (keyParts.length == 1) {
      if (state is Map) {
        return state[keyParts.first];
      }
      return state;
    }
    String key = keyParts.removeAt(0);
    if (key == "index" && state is List) {
      return (state).map((element) {
        return ReferenceLoader.altRetrieveReferencedState(keyParts.join('.'), element);
      });
    }
    return ReferenceLoader.altRetrieveReferencedState(keyParts.join('.'), state[key]);
  }
}
