import 'package:flutter_riverpod/flutter_riverpod.dart';

final componentsProvider = StateProvider<ComponentsData>((ref) => ComponentsData());

class ComponentsData {
  Map<String, dynamic> components = {};

  loadComponents(Map<String, dynamic> components) {
    this.components = components;
  }

  ComponentsData({ Map<String, dynamic>? components }) {
    this.components = components ?? {};
  }

  ComponentsData clone() {
    return ComponentsData(components: {...components});
  }
}
