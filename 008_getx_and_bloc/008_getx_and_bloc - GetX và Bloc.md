:memo: <span style="color:orange">FLUTTER_008_GETX_AND_BLOC</span>

# GETX và BLOC

![Picture 1](01.png)

## Table of Content

- [GETX và BLOC](#getx-và-bloc)
  - [Table of Content](#table-of-content)
  - [GetX](#getx)
    - [1. GetX](#1-getx)
    - [2. State management](#2-state-management)
    - [3. Navigation](#3-navigation)
    - [4. Themes](#4-themes)
    - [5. Localozations](#5-localozations)
  - [Bloc](#bloc)
    - [1. Bloc](#1-bloc)
    - [2. Bloc pattern](#2-bloc-pattern)
    - [3. Cac widget of bloc](#3-cac-widget-of-bloc)
    - [4. Single state and multi state](#4-single-state-and-multi-state)

## GetX

### 1. GetX

> GetX là một thư viện Flutter mạnh mẽ, hỗ trợ state management, điều hướng (navigation), quản lý theme, và đa ngôn ngữ (localization). Nó giúp phát triển ứng dụng nhanh chóng, tối ưu hiệu suất và giảm boilerplate code.

- Đầu tiền để sử dụng get, add dependencies vào file pubspec.yaml trước:

```yaml
dependencies:
  flutter:
    sdk: flutter


  # The following adds the Cupertino Icons font to your application.
  # Use with the CupertinoIcons class for iOS style icons.
  cupertino_icons: ^1.0.2
  get: ^4.1.4
```

### 2. State management

- GetX cung cấp 3 cách quản lý trạng thái:
  - Simple State Manager (Obx) – dùng Rx variables để cập nhật UI tự động.
  - GetBuilder – dùng khi không cần reactivity liên tục.
  - GetX & GetBuilder với Controller – kết hợp quản lý logic và UI.

### 3. Navigation

- GetX cung cấp hệ thống điều hướng không cần context, giúp dễ dàng chuyển màn hình.

```dart
Get.to(NextScreen()); // Chuyển sang màn hình khác
Get.off(NextScreen()); // Xóa màn hình hiện tại khỏi stack
Get.offAll(NextScreen()); // Xóa toàn bộ stack và chuyển đến màn hình mới
```

- Chuyển màn hình với dữ liệu

```dart
Get.to(NextScreen(), arguments: {'name': 'Hoang'});
```

- Nhận dữ liệu ở NextScreen:

```dart
var data = Get.arguments;
```

- Chuyển màn hình với route:

```dart
GetMaterialApp(
  initialRoute: '/',
  getPages: [
    GetPage(name: '/', page: () => HomeScreen()),
    GetPage(name: '/detail', page: () => DetailScreen()),
  ],
);


Get.toNamed('/detail');
```

### 4. Themes

- GetX cho phép thay đổi theme dễ dàng bằng Get.changeTheme().

- Định nghĩa theme:

```dart
final lightTheme = ThemeData.light();
final darkTheme = ThemeData.dark();
```

- Thay đổi theme:

```dart
Get.changeTheme(lightTheme);
```

- Thay đổi theme theo mode:

```dart
Get.changeThemeMode(Get.isDarkMode ? ThemeMode.light : ThemeMode.dark);
```

### 5. Localozations

- GetX hỗ trợ đa ngôn ngữ thông qua Translations.

- Tạo file ngôn ngữ

```dart 
class MyTranslations extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
    'en_US': {'hello': 'Hello'},
    'vi_VN': {'hello': 'Xin chào'},
  };
}
```

- Cấu hình trong GetMaterialApp

```dart
GetMaterialApp(
  translations: MyTranslations(),
  locale: Locale('vi', 'VN'),
  fallbackLocale: Locale('en', 'US'),
);
```

- Sử dụng:

```dart
Text('hello'.tr), // Hiển thị theo ngôn ngữ hiện tại
```

- Thay đổi ngôn ngữ:

```dart
Get.updateLocale(Locale('en', 'US'));
```

## Bloc

### 1. Bloc

> Bloc (Business Logic Component) được xây dựng dựa trên Reactive Programming và State Management Pattern.

- Nó giúp tách biệt business logic khỏi UI bằng cách sử dụng Streams của Dart, giúp quản lý trạng thái hiệu quả và dễ dàng mở rộng. Bloc hoạt động dựa trên kiến trúc Event-Driven:
  - Event: Được gửi khi có hành động của người dùng (nhấn nút, nhập dữ liệu...).
  - State: Kết quả của việc xử lý event, thay đổi UI dựa trên state mới.
  - Bloc: Nhận event, xử lý logic, phát ra state mới.

### 2. Bloc pattern

- Bloc dựa trên Bloc Pattern, một biến thể của State Management Pattern kết hợp với Streams trong Dart. Bloc sử dụng event-driven architecture, nghĩa là UI chỉ gửi event, còn logic xử lý hoàn toàn nằm trong Bloc. Bloc sẽ xử lý event và cập nhật state mới cho UI.

- Cấu trúc Bloc thường gồm:

  - Event: Đại diện cho hành động của người dùng.
  - State: Đại diện cho trạng thái của UI.
  - Bloc: Nhận event → xử lý logic → phát ra state mới.

```dart
enum CounterEvent { increment, decrement }

class CounterBloc extends Bloc<CounterEvent, int> {
  CounterBloc() : super(0) {
    on<CounterEvent>((event, emit) {
      if (event == CounterEvent.increment) {
        emit(state + 1);
      } else if (event == CounterEvent.decrement) {
        emit(state - 1);
      }
    });
  }
}
```

- CounterBloc kế thừa từ Bloc<CounterEvent, int>, nghĩa là:
  - CounterEvent: Kiểu dữ liệu của sự kiện mà Bloc có thể xử lý.
  - int: Kiểu dữ liệu của state mà Bloc quản lý (trong trường hợp này là một số nguyên đại diện cho bộ đếm).
- Hàm khởi tạo CounterBloc() gọi super(0), tức là:
  - super(0) thiết lập giá trị mặc định ban đầu của state là 0 (bắt đầu với giá trị đếm là 0).
- on<CounterEvent>(): Lắng nghe và xử lý các sự kiện của CounterBloc.
(event, emit):
  - event: Nhận sự kiện (increment hoặc decrement).
  - emit: Phát ra state mới dựa trên sự kiện nhận được.
- Có thể sử dụng như sau:

```dart
BlocProvider(
  create: (context) => CounterBloc(),
  child: Column(
    children: [
      BlocBuilder<CounterBloc, int>(
        builder: (context, count) {
          return Text('Giá trị bộ đếm: $count');
        },
      ),
      ElevatedButton(
        onPressed: () {
          context.read<CounterBloc>().add(CounterEvent.increment);
        },
        child: Text('Tăng'),
      ),
      ElevatedButton(
        onPressed: () {
          context.read<CounterBloc>().add(CounterEvent.decrement);
        },
        child: Text('Giảm'),
      ),
    ],
  ),
)
```

### 3. Cac widget of bloc

- Bloc có một số widget hỗ trợ để kết nối với UI:

  - BlocProvider: Cung cấp instance của Bloc hoặc Cubit cho cây widget.
  - BlocBuilder: Lắng nghe state thay đổi và rebuild UI khi state mới được phát ra.
  - BlocListener: Lắng nghe state thay đổi nhưng không rebuild UI, dùng để thực hiện các tác vụ như hiển thị Snackbar, Dialog...
  - BlocConsumer: Kết hợp cả BlocBuilder và BlocListener.

```dart
BlocBuilder<CounterBloc, int>(
  builder: (context, state) {
    return Text('Count: $state');
  },
);
```

### 4. Single state and multi state

- Trong Cubit hoặc Bloc, nếu state chỉ có một giá trị đơn giản (ví dụ: int, String), thì đó là Single State.

```dart
class CounterCubit extends Cubit<int> {
  CounterCubit() : super(0);
  
  void increment() => emit(state + 1);
}
```

- Khi state có nhiều thuộc tính khác nhau (object chứa nhiều dữ liệu), thì đó là Multi State.
Ví dụ một AuthState có thể có nhiều trạng thái:

```dart
abstract class AuthState {}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthAuthenticated extends AuthState {
  final String user;
  AuthAuthenticated(this.user);
}

class AuthError extends AuthState {
  final String message;
  AuthError(this.message);
}
```

- Sử dụng trong Bloc:

```dart
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial()) {
    on<LoginEvent>((event, emit) async {
      emit(AuthLoading());
      try {
        // Xử lý đăng nhập
        emit(AuthAuthenticated(event.username));
      } catch (e) {
        emit(AuthError('Login failed'));
      }
    });
  }
}
```
