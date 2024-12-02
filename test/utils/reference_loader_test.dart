import 'package:campaigntrackerflutter/utils/reference_loader.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('replaceRefIndex method', () {
    test('Should replace all indexes from a ref', () {
      String pathId = "root.card.5.list.10";
      String ref = "characters.index.inventory.index.name";
      String result = ReferenceLoader.replaceRefIndex(ref, pathId);
      expect(result, "characters.5.inventory.10.name");
    });
    test('Should replace only the first if there is not more index to replace', () {
      String pathId = "root.card.5.list";
      String ref = "characters.index.inventory.index.name";
      String result = ReferenceLoader.replaceRefIndex(ref, pathId);
      expect(result, "characters.5.inventory.index.name");
    });

    test('Should not replace the index if there is not a value to replace it', () {
      String pathId = "root.card.container.list.text";
      String ref = "characters.index.inventory.index.name";
      String result = ReferenceLoader.replaceRefIndex(ref, pathId);
      expect(result, ref);
    });
  });

  group('retrieveReference method', () {
    test('Return value from a list', () {
      String ref = 'characters.1.name';
      Map<String, dynamic> state = {
        'characters': [
          {
            'name': 'Test',
            'health': '5',
          },
          {
            'name': 'Test2',
            'health': '4',
          },
          {
            'name': 'Test3',
            'health': '3',
          },
        ],
      };

      dynamic result = ReferenceLoader.retrieveReference(state, ref.split('.'));
      expect(result, 'Test2');
    });
    test('Return value from map', () {
      String ref = 'name';
      Map<String, dynamic> state = {
        'name': 'Test',
        'health': '5',
      };

      dynamic result = ReferenceLoader.retrieveReference(state, ref.split('.'));
      expect(result, 'Test');
    });

    test('Return top most state if value does not exist', () {
      String ref = 'first.undefined';
      Map<String, dynamic> state = {
        'first': {
          'name': 'Test',
          'health': '5',
        } 
      };

      dynamic result = ReferenceLoader.retrieveReference(state, ref.split('.'));
      expect(result, state['first']);
    });

    test('Return null if index value does not exist', () {
      String ref = 'characters.10.name';
      Map<String, dynamic> state = {
        'characters': [
          {
            'name': 'Test',
            'health': '5',
          },
        ],
      };

      dynamic result = ReferenceLoader.retrieveReference(state, ref.split('.'));
      expect(result, state['characters']);
    });
  });
}