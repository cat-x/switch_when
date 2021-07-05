import 'package:flutter_test/flutter_test.dart';
import 'package:switch_when/switch_when.dart';
import 'package:tuple/tuple.dart';

extension Stringx on String {
  String more() {
    return "$this more";
  }
}

void main() {
  group('when_extensions', () {
    test('testWhenString', () {
      int howManyFruits = 2;
      int? index = whenString<int>("banana🍌", {
        "water" + "melon".more(): () {
          return 1;
        },
        "apple".more(): () {
          return 2;
        },
        howManyFruits <= 1 ? "orange" : "oranges": () {
          return 3;
        },
        "banana" + "🍌": () {
          return 4;
        },
        "grape": () {
          return 5;
        },
      });

      expect(index, 4);
    });

    test('testWhenInt', () {
      String? status = whenInt<String>(3, {
        1: () {
          return "good";
        },
        1 + 1: () {
          return "nice";
        },
        int.parse("3"): () {
          return "better";
        },
      });
      expect(status, "better");
    });

    test('testWhenDouble', () {
      String? status = whenDouble<String>(2.0, {
        0.1: () {
          return "good";
        },
        1.0 + 1: () {
          return "nice";
        },
        double.parse("3.2"): () {
          return "better";
        },
      });
      expect(status, "nice");
    });

    test('testWhenDouble', () {
      double? degree = whenBool<double>(false, [
        Tuple2(
          "is Long String".length > 10,
          () {
            return 0.0;
          },
        ),
        Tuple2(
          100 / 10 == 0,
          () {
            return 1.0;
          },
        ),
        Tuple2(
          "apple".contains("a"),
          () {
            return 2.0;
          },
        ),
      ]);
      expect(degree, 1.0);
    });

    test('testWhenValue', () {
      String? kind = whenValue<List, String>(
        ["apple", "orange"],
        {
          ["cat", "dog"]: () {
            return "pets";
          },
          ["apple", "orange"]: () {
            return "fruits";
          },
          ["red", "white", "black"]: () {
            return "colors";
          },
        },
      );
      expect(kind, "fruits");
    });

    test('testWhen', () {
      String? winner = when<String>({
        "Dart is Language".contains("UI"): () {
          return "Flutter";
        },
        "Flutter is UI Framework".contains("UI"): () {
          return "Flutter";
        },
      });
      expect(winner, "Flutter");
    });

    test('testWhenTrue', () {
      String? something = whenTrue<String>({
        () {
          if (1 + 100 * 1000 < 2000) {
            return false;
          } else if ("Who is my lovely baby?".length > 100) {
            return true;
          } else {
            return false;
          }
        }: () {
          return "Test OK";
        },
        () {
          return int.tryParse("3.14*") != null;
        }: () {
          return "PI get";
        }
      });
      expect(something, null);
    });
  });

  group('when_safe_extensions', () {
    test('testWhenStringSafe', () {
      int howManyFruits = 2;
      int index = whenStringSafe<int>(
        "🍌🍌🍌",
        {
          "water" + "melon".more(): () {
            return 1;
          },
          "apple".more(): () {
            return 2;
          },
          howManyFruits <= 1 ? "orange" : "oranges": () {
            return 3;
          },
          "banana" + "🍌": () {
            return 4;
          },
          "grape": () {
            return 5;
          },
        },
        defaultValue: () => 0,
      );

      expect(index, 0);
    });

    test('whenIntSafe', () {
      String status = whenIntSafe<String>(3, {
        1: () {
          return "good";
        },
        1 + 1: () {
          return "nice";
        },
        int.parse("3"): () {
          return "better";
        },
      });
      expect(status, "better");
    });

    test('whenDoubleSafe', () {
      String status = whenDoubleSafe<String>(
        2.1,
        {
          0.1: () {
            return "good";
          },
          1.0 + 1: () {
            return "nice";
          },
          double.parse("3.2"): () {
            return "better";
          },
        },
        defaultValue: () => "other",
      );
      expect(status, "other");
    });

    test('testWhenValue', () {
      String kind = whenValueSafe<List, String>(
        ["apple", "orange"],
        {
          ["cat", "dog"]: () {
            return "pets";
          },
          ["apple", "orange"]: () {
            return "fruits";
          },
          ["red", "white", "black"]: () {
            return "colors";
          },
        },
      );
      expect(kind, "fruits");
    });

    test('testWhen', () {
      String winner = whenSafe<String>({
        "Dart is Language".contains("UI"): () {
          return "Flutter";
        },
        "Flutter is UI Framework".contains("UI"): () {
          return "Flutter";
        },
      });
      expect(winner, "Flutter");
    });

    test('testWhenTrue', () {
      String something = whenTrueSafe<String>(
        {
          () {
            if (1 + 100 * 1000 < 2000) {
              return false;
            } else if ("Who is my lovely baby?".length > 100) {
              return true;
            } else {
              return false;
            }
          }: () {
            return "Test OK";
          },
          () {
            return int.tryParse("3.14*") != null;
          }: () {
            return "PI get";
          }
        },
        defaultValue: () => "defaultValue",
      );
      expect(something, "defaultValue");
    });
  });
}
