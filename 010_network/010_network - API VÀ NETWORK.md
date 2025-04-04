:memo: <span style="color:orange">FLUTTER_010_NETWORK</span>

# API VÀ NETWORK

![Picture 1](01.png)

## Table of Content

- [API VÀ NETWORK](#api-và-network)
  - [Table of Content](#table-of-content)
  - [Key Points](#key-points)
  - [API, Rest, các thành phần cơ bản của RestAPI, Json](#api-rest-các-thành-phần-cơ-bản-của-restapi-json)
    - [API và REST: Khái niệm cơ bản](#api-và-rest-khái-niệm-cơ-bản)
    - [Nguyên tắc cơ bản của REST API](#nguyên-tắc-cơ-bản-của-rest-api)
    - [Thành phần cơ bản của RESR API](#thành-phần-cơ-bản-của-resr-api)
    - [Json](#json)
  - [HTTP, cURL, URI, URN, URL, sử dụng Postman](#http-curl-uri-urn-url-sử-dụng-postman)
    - [Khái niệm](#khái-niệm)
  - [lib HTTP](#lib-http)

## Key Points

- API là giao diện lập trình ứng dụng, cho phép các phần mềm giao tiếp, thường qua internet, với REST là một kiểu kiến trúc phổ biến sử dụng HTTP.
- Các thành phần cơ bản của REST API bao gồm tài nguyên, phương thức HTTP (GET, POST, v.v.), URL, mã trạng thái, và headers, với JSON là định dạng dữ liệu phổ biến.
- HTTP là giao thức truyền dữ liệu web, cURL là công cụ dòng lệnh kiểm tra API, URI/URL/URN là cách xác định tài nguyên, và Postman là công cụ kiểm tra API với giao diện thân thiện.
- Trong Flutter, package http giúp thực hiện yêu cầu HTTP và xử lý JSON, rất hữu ích cho phát triển ứng dụng.

## API, Rest, các thành phần cơ bản của RestAPI, Json

### API và REST: Khái niệm cơ bản

- API, viết tắt của Application Programming Interface, là tập hợp các quy tắc và giao thức cho phép các ứng dụng phần mềm giao tiếp với nhau. Trong phát triển web, API thường là các dịch vụ web cung cấp dữ liệu hoặc chức năng qua internet, như lấy thông tin người dùng từ server.
- REST, hay Representational State Transfer, là một kiểu kiến trúc để thiết kế các ứng dụng mạng, sử dụng các yêu cầu HTTP để thực hiện các thao tác CRUD (Create, Read, Update, Delete) trên tài nguyên, được xác định bởi URL.
- Theo [REST API Introduction | GeeksforGeeks](https://www.geeksforgeeks.org/rest-api-introduction/), RESTful API là tiêu chuẩn phổ biến cho các ứng dụng web và mobile giao tiếp với nhau.

### Nguyên tắc cơ bản của REST API

| Thành phần | Mô tả  |
|---|---|
| HTTP Methods  | Sử dụng các phương thức HTTP cho CRUD: GET (đọc), POST (tạo), PUT (cập nhật), DELETE (xóa), và PATCH (cập nhật một phần).  |
| Request và Response  | Client gửi yêu cầu qua URL bằng phương thức HTTP; server trả về tài nguyên (JSON, XML, HTML, hình ảnh), với JSON phổ biến nhất.  |
| Statelessness  | Mỗi yêu cầu phải chứa đầy đủ thông tin, không lưu trạng thái trên server.  |
| Client-Server Architecture  | Dựa trên mô hình client-server, độc lập, tăng khả năng mở rộng.  |
| Cacheable  | Phản hồi có thể được đánh dấu cacheable hoặc non-cacheable để cải thiện hiệu suất.  |
| Uniform Interface  | Tuân theo quy ước như URL nhất quán, phương thức HTTP chuẩn, mã trạng thái.  |
| Layered System  | Có thể triển khai trên nhiều tầng, hỗ trợ mở rộng và bảo mật.  |

### Thành phần cơ bản của RESR API

- Tài nguyên (Resource): Mọi thứ có thể được truy cập và thao tác thông qua URL duy nhất (ví dụ: /users, /products)
- HTTP Methods: Các thao tác CRUD trên tài nguyên
  - GET: Lấy dữ liệu
  - POST: Tạo dữ liệu mới
  - PUT/PATCH: Cập nhật dữ liệu hiện có
  - DELETE: Xóa dữ liệu
- Endpoints: Các URL mà API tiếp nhận yêu cầu (ví dụ: api.example.com/users)
- Status Codes: Mã trạng thái HTTP để chỉ ra kết quả của yêu cầu
  - 200: OK
  - 201: Created
  - 400: Bad Request
  - 401: Unauthorized
  - 404: Not Found
  - 500: Internal Server Error
- Định dạng dữ liệu: Thường là JSON hoặc XML, với JSON phổ biến hơn

### Json

- JSON, viết tắt của JavaScript Object Notation, là định dạng trao đổi dữ liệu nhẹ, dễ đọc và viết cho con người, dễ phân tích cho máy tính.
- Nó dựa trên một tập con của JavaScript nhưng độc lập với ngôn ngữ, có thể sử dụng với nhiều ngôn ngữ lập trình.
- JSON biểu diễn dữ liệu dưới dạng cặp key-value, ví dụ:

```json
{
  "id": 1,
  "name": "Nguyen Van A",
  "email": "nguyenvana@example.com",
  "is_active": true,
  "scores": [85, 90, 78],
  "address": {
    "street": "123 Nguyen Hue",
    "city": "Ho Chi Minh",
    "country": "Vietnam"
  }
}
```

- JSON cũng hỗ trợ mảng, số, chuỗi, boolean, và null.
- Trong REST API, server thường trả về dữ liệu JSON, và client gửi dữ liệu JSON trong body yêu cầu, đặc biệt với POST hoặc PUT.
- Trong Flutter, có thể sử dụng package dart:convert để phân tích JSON.

## HTTP, cURL, URI, URN, URL, sử dụng Postman

### Khái niệm

- HTTP (Hypertext Transfer Protocol): Là giao thức cơ bản cho truyền dữ liệu trên web, định nghĩa cách các thông điệp được định dạng và truyền tải, cũng như cách máy chủ và trình duyệt phản hồi.

- Chi tiết các phương thức HTTP:

| Phương thức  | Trường hợp sử dụng  | Ví dụ  | Ghi chú  |
|---|---|---|---|
| GET  | Lấy tài nguyên  | GET /users/123 – Lấy thông tin người dùng ID 123  | Trả về 200 (OK) khi thành công, 404 (NOT FOUND) hoặc 400 (BAD REQUEST) khi lỗi.  |
| POST  | Tạo tài nguyên mới  | mới	POST /users với { "name": "Anjali", "email": "gfg@example.com" } – Tạo người dùng mới  | Trả về 201 khi thành công, không an toàn hoặc idempotent.  |
| PUT  | Cập nhật hoặc tạo tài nguyên (thay thế toàn bộ)  | PUT /users/123 với { "name": "Anjali", "email": "gfg@example.com" } – Cập nhật người dùng  | Thay thế toàn bộ tài nguyên, có thể tạo nếu tài nguyên không tồn tại.  |
| PATCH  | Cập nhật một phần tài nguyên  | PATCH /users/123 với { "email": "new.email@example.com" } – Chỉ cập nhật email  | Hiệu quả hơn PUT cho cập nhật một phần.  |
| DELETE  | Xóa tài nguyên  | DELETE /users/123 – Xóa người dùng ID 123  | Trả về 200 (OK) khi thành công với body phản hồi.  |

- cURL: Là công cụ dòng lệnh để truyền dữ liệu với URL, hữu ích để kiểm tra API từ terminal mà không cần giao diện. Ví dụ: curl https://api.example.com/data để gửi yêu cầu GET. cURL là lựa chọn phổ biến cho kiểm tra nhanh.
- URI, URN, URL:
  - URI (Uniform Resource Identifier) là chuỗi xác định tài nguyên, có thể là URL hoặc URN.
  - URL (Uniform Resource Locator) là loại URI xác định vị trí tài nguyên và cách truy cập, ví dụ [invalid url, do not cite]
  - URN (Uniform Resource Name) là loại URI xác định tài nguyên bằng tên, ví dụ urn:isbn:0451450523, không chỉ định vị trí.
- Postman: Là công cụ kiểm tra API với giao diện thân thiện, cho phép gửi các yêu cầu HTTP (GET, POST, v.v.), thiết lập headers, parameters, và body, lưu trữ trong collections, và tự động hóa kiểm tra. Đối với Flutter, Postman hữu ích để kiểm tra API trước khi tích hợp vào ứng dụng.

## lib HTTP

- Trong Flutter, package http là cách tiêu chuẩn để thực hiện yêu cầu HTTP và xử lý JSON. Theo Fetch data from the internet | Flutter, quy trình bao gồm:
  - Thêm package: Chạy flutter pub add http, import import 'package:http/http.dart' as http;.
  - Thực hiện yêu cầu: Sử dụng http.get(Uri.parse('https://api.example.com/data')), trả về Future<Response>.
  - Chuyển đổi phản hồi: Tạo class như Album với factory constructor từ JSON, sử dụng jsonDecode từ dart:convert.
  - Hiển thị dữ liệu: Sử dụng FutureBuilder để xử lý trạng thái tải, thành công, hoặc lỗi, ví dụ hiển thị Text(snapshot.data!.title) khi có dữ liệu.

```dart
import 'package:http/http.dart' as http;
import 'dart:convert';

Future<void> fetchData() async {
  final response = await http.get(Uri.parse('https://api.example.com/data'));
  if (response.statusCode == 200) {
    final data = jsonDecode(response.body);
    print(data);
  } else {
    throw Exception('Failed to load data');
  }
}
```
