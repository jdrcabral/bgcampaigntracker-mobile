// Class to handle reference loading with the components data
import 'package:campaigntrackerflutter/utils/path_handler.dart';

class ReferenceLoader {
  static dynamic retrieveReference(dynamic state, List<String> reference) {
    if (reference.isEmpty) {
      return state;
    }
    String currentReference = reference.removeAt(0);
    int? parsedNumber = int.tryParse(currentReference);
    if (parsedNumber != null) {
      dynamic result = (state as List<dynamic>).elementAtOrNull(parsedNumber);
      if (result == null) {
        return state;
      }
      return ReferenceLoader.retrieveReference(state[parsedNumber], reference);
    }
    if (state.containsKey(currentReference)) {
      return ReferenceLoader.retrieveReference(state[currentReference], reference);
    }
    return state;
  }

  static String replaceRefIndex(String ref, String pathId) {
    List<int> indexes = PathHandler.extractIndexes(pathId);
    String result = ref;
    
    for (final index in indexes) {
      result = result.replaceFirst("index", index.toString());
    }
    return result;
  }
}
