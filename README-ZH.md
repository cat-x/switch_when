Language: [English](README.md) | [中文简体](README-ZH.md)
# switch_when

一个提供更高级的switch的函数库，不限制Case表达式需要是常量，接近于kotlin的when方法

## Getting Started

### 添加依赖

```yaml
dependencies:
  switch_when: ^0.0.1 #please use the latest version on pub
```
 
### 使用 Library
1. 导包
 在需要使用该Library库的地方，导入package
```dart
import 'package:switch_when/index.dart';
```

2. 使用函数
根据不同的情况使用不同的方法，通用的情况可以使用when方法或者whenValue方法。如果希望返回结果的类型是空安全的话，可以使用whenSafe方法或者whenValueSafe方法。
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


**函数:**
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
<p>用于取代switch方法，因为有些场景使用[switch]会出现Case expressions must be constant.的错误警告；
如果[conditionMap]的[Map.keys]中有[value]的话，执行其对应的[ValueGetter]方法
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
<p>用于取代switch方法，因为有些场景使用[switch]会出现Case expressions must be constant.的错误警告；如果[conditionMap]的[Map.keys]中有[value]的话，执行其对应的[ValueGetter]方法
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
<p>用于取代switch方法，因为有些场景使用[switch]会出现Case expressions must be constant.的错误警告；<br>
如果[conditionMap]的[Map.keys]中有[value]的话，执行其对应的[ValueGetter]方法
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
<p>方法[switch]的超级进化版本💖💖💖，所有基本类型的value都可以比较，包括[List],[Map]，[Set]，以及[Iterable]。<br>
只要[conditionMap]的[Map.keys]中有[value]的话，就会执行其对应的[ValueGetter]方法
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
<p>方法[switch]的kotlin版本的when函数.<br>
只要在[conditionMap]的[Map.keys]中发现第一个true,就会立刻执行其对应的[ValueGetter]方法，并返回相对的值.<br>
如果没有找到的话，会返回null;如果需要默认值，可以在Map中最后加入一个key等于true的MapEntry
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
<p>方法[switch]的kotlin版本的when函数.<br>，其条件表达式会进行计算。
只要在[conditionMap]的[Map.keys]中第一个出现执行结果为true,就会立刻执行其对应的[ValueGetter]方法，并返回相对的值.<br>
如果没有找到的话，会返回null;如果需要默认值，可以在Map中最后加入一个key等于true的MapEntry
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


### 例子Demo:

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

#### Demo 截图
<!-- ![demo](demo.gif) -->




