Language: [English](README.md) | [中文简体](README-ZH.md)
# switch_when

A function library that provides a more advanced switch method, does not limit the case expression to be constant, which is close to the when method of kotlin.

## Getting Started

### Add dependency

```yaml
dependencies:
  switch_when: ^0.0.1 #please use the latest version on pub
```
 
### Use Library
1. import package
 Where you need to use the Library library, import the package
```dart
import 'package:switch_when/index.dart';
```

2. Use functions
Different methods are used according to different situations. For general situations, you can use the when method or whenValue method. If you want the type of the returned result to be null safe, you can use the whenSafe method or whenValueSafe method.
```dart
  @override
  void initState() {
    _curtainAnimationImage = TweenImageWidget(
      ImagesEntry(1, 20, "equipmentcontrol_pic_curtain%s".toAssetImg()),
      durationMilliseconds: 5000,
      repeat: false,
    );
    super.initState();
  }
```


**Functions:**
```dart
//Not Safe
T? whenString<T>(String value, Map<String, ValueGetter<T>> conditionMap)
T? whenInt<T>(int value, Map<int, ValueGetter<T>> conditionMap)
T? whenDouble<T>(double value, Map<double, ValueGetter<T>> conditionMap) 
T? whenValue<V, T>(V value, Map<V, ValueGetter<T>> conditionMap)
T? when<T>(Map<bool, ValueGetter<T>> conditionMap)
T? whenTrue<T>(Map<ValueGetter<bool>, ValueGetter<T>> conditionMap)

//Safe
T whenStringSafe<T>(String value, Map<String, ValueGetter<T>> conditionMap, {ValueGetter<T>? defaultValue}) 
T whenIntSafe<T>(int value, Map<int, ValueGetter<T>> conditionMap, {ValueGetter<T>? defaultValue})
T whenDoubleSafe<T>(double value, Map<double, ValueGetter<T>> conditionMap, {ValueGetter<T>? defaultValue}) 
T whenValueSafe<V, T>(V value, Map<V, ValueGetter<T>> conditionMap, {ValueGetter<T>? defaultValue}) 
T whenSafe<T>(Map<bool, ValueGetter<T>> conditionMap, {ValueGetter<T>? defaultValue})
T whenTrueSafe<T>(Map<ValueGetter<bool>, ValueGetter<T>> conditionMap, {ValueGetter<T>? defaultValue}) 
```


<details>
  <summary>T? whenString<T>(String value, Map<String, ValueGetter<T>> conditionMap)</summary>
<p>Used to replace the [switch] method, because in some scenarios, an error warning of Case expressions must be constant;<br>
If there is [value] in [Map.keys] of [conditionMap], execute its corresponding [ValueGetter] method
</p>

example:
```dart
 int? index = whenString<int>("banana🍌", {
   "water" + "melon": () {
     return 1;
   },
   "apple": () {
     return 2;
   },
   "orange": () {
     return 3 ;
   },
   "banana" + "🍌": () {
     return 4;
   },
   "grape": () {
     return 5;
   },
 });
```
</details>


<details>
  <summary>T? whenInt<T>(int value, Map<int, ValueGetter<T>> conditionMap)</summary>
<p>Used to replace the [switch] method, because in some scenarios, an error warning of Case expressions must be constant;<br>
If there is [value] in [Map.keys] of [conditionMap], execute its corresponding [ValueGetter] method
</p>

example:
```dart
 String? status = whenInt<String>(1, {
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
```
</details>

<details>
  <summary>T? whenDouble<T>(double value, Map<double, ValueGetter<T>> conditionMap)</summary>
<p>Used to replace the [switch] method, because in some scenarios, an error warning of Case expressions must be constant;<br>
If there is [value] in [Map.keys] of [conditionMap], execute its corresponding [ValueGetter] method
</p>

example:
```dart
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
```
</details>



<details>
  <summary>T? whenValue<V, T>(V value, Map<V, ValueGetter<T>> conditionMap)</summary>
<p>The super evolution version💖💖💖 of [switch] method, all basic types of values can be compared, including [List], [Map], [Set], and [Iterable].<br>
All need do is [value] in [Map.keys] of [conditionMap], its corresponding [ValueGetter] method will be executed
</p>

example:
```dart
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
```
</details>


<details>
  <summary>T? when<T>(Map<bool, ValueGetter<T>> conditionMap)</summary>
<p>The when function of the Kotlin version of the method [switch].<br>
 As long as the first true is found in [Map.keys] of [conditionMap], its corresponding [ValueGetter] method will be executed immediately and the relative value will be returned.<br>
 If it is not found, it will return null; if you need a default value, you can add a MapEntry with a key equal to true at the end of the Map
</p>

example:
```dart
 String? winner = when<String>({
   "Dart is Language".contains("UI"): () {
     return "Flutter";
   },
   "Flutter is UI Framework".contains("UI"): () {
     return "Flutter";
   },
 });
```
</details>


<details>
  <summary>T? whenTrue<T>(Map<ValueGetter<bool>, ValueGetter<T>> conditionMap)</summary>
<p>The when function of the Kotlin version of the method [switch]，its conditional expression will be calculated。.<br>
 As long as [conditionMap] to [Map.keys] appears first execution result is true, it will immediately perform corresponding [ValueGetter] method, and an opposite return value.<br>
 If it is not found, it will return null; if you need a default value, you can add a MapEntry with a key equal to true at the end of the Map
</p>

example:
```dart
String? something = whenTrue<String>({
      () {
    if (1 + 100 * 1000 < 2000) {
      return false;
    } else if ("Who is my lovely baby?".length > 10) {
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
```
</details>

### Example Demo:

```dart
  testWhenString() {
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
    return index;
  }

  testWhen() {
    String? winner = when<String>({
      "Dart is Language".contains("UI"): () {
        return "Flutter";
      },
      "Flutter is UI Framework".contains("UI"): () {
        return "Flutter";
      },
    });
    return winner;
  }

  testWhenDoubleSafe() {
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
  };
```

#### Demo Pictrue
<!-- ![demo](demo.gif) -->




