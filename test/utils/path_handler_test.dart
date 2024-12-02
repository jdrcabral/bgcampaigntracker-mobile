import 'package:campaigntrackerflutter/utils/path_handler.dart';
import 'package:test/test.dart';

void main() {
  test('Should not return index if path does not contain it', () {
    String pathId = 'root.card.name';
    List<int> result = PathHandler.extractIndexes(pathId);
    expect(result.length, 0);
  });

  test('Should return only one index if path contains only one', () {
    String pathId = 'root.cardList.10.name';
    List<int> result = PathHandler.extractIndexes(pathId);
    expect(result.length, 1);
    expect(result.first, 10);
  });


  test('Should return multiple index if path contains it', () {
    String pathId = 'root.cardList.10.horizontalContainer.5';
    List<int> result = PathHandler.extractIndexes(pathId);
    expect(result.length, 2);
    expect(result.first, 10);
    expect(result.last, 5);
  });
}