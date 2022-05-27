import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'widget_test.mocks.dart';

@GenerateMocks([Cat])
void main() {
  test("Dumb test", () {
    var mockCat = MockCat();
    var cat2 = Cat2();
    when(mockCat.sayHello(cat2)).thenReturn("Hello");

    expect(mockCat.sayHello(cat2), "Hello");
  });
}

class Cat {
  String sayHello(Cat2 cat2) {
    return "Hello";
  }
}

class Cat2 {}
