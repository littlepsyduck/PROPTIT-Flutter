import 'dart:async';
import '../model/product.dart';

enum Status { initial, loading, success, error, loadingMore }

class ProductController {
  final List<Product> _products = [
    Product(
        name: 'Product 1',
        image:
        'https://m.media-amazon.com/images/I/51qFSdheDPL._AC_UF1000,1000_QL80_.jpg',
        price: 10000.0),
    Product(
        name: 'Product 2',
        image:
        'https://m.media-amazon.com/images/I/51qFSdheDPL._AC_UF1000,1000_QL80_.jpg',
        price: 20000.0),
    Product(
        name: 'Product 3',
        image:
        'https://m.media-amazon.com/images/I/51qFSdheDPL._AC_UF1000,1000_QL80_.jpg',
        price: 30000.0),
    Product(
        name: 'Product 4',
        image:
        'https://m.media-amazon.com/images/I/51qFSdheDPL._AC_UF1000,1000_QL80_.jpg',
        price: 40000.0),
    Product(
        name: 'Product 5',
        image:
        'https://m.media-amazon.com/images/I/51qFSdheDPL._AC_UF1000,1000_QL80_.jpg',
        price: 50000.0),
    Product(
        name: 'Product 6',
        image:
        'https://m.media-amazon.com/images/I/51qFSdheDPL._AC_UF1000,1000_QL80_.jpg',
        price: 60000.0),
    Product(
        name: 'Product 7',
        image:
        'https://m.media-amazon.com/images/I/51qFSdheDPL._AC_UF1000,1000_QL80_.jpg',
        price: 70000.0),
  ];
  // list _products
  late final StreamController<ListProductState> _stateController =
  StreamController<ListProductState>.broadcast();
 // getter => stream, sink
  Stream<ListProductState> get stream => _stateController.stream; // => steawm builder
  StreamSink<ListProductState> get sink => _stateController.sink; // add ListProductState

  late ListProductState currentState = ListProductState(
    products: _products, // 5phan tu
    status: Status.initial,
  );

  int _currentPage = 1;
  final int _itemsPerPage = 5;

  Future<void> addProduct(Product product) async {
    sink.add(currentState.copyWith(
      status: Status.loading, // updatre current status => loading
    ));
    await Future.delayed(const Duration(seconds: 2)); // loading 2s
    currentState = currentState.copyWith(
      // update prud
      status: Status.success,
      products: [product, ...currentState.products], // tao 1 mang moi co phan
    );
    // current 6 phan tu
    sink.add(currentState);
  }

  Future<void> loadMoreProducts() async {
    if (currentState.status == Status.loadingMore) return;
    sink.add(currentState.copyWith(status: Status.loadingMore));
    await Future.delayed(const Duration(seconds: 2));

    _currentPage++;
    // call api => next page
    final nextProducts = List.generate(
        _itemsPerPage,
            (index) => Product(
            name: 'Product ${_currentPage * _itemsPerPage + index}',
            image:
            'https://m.media-amazon.com/images/I/51qFSdheDPL._AC_UF1000,1000_QL80_.jpg',
            price: (_currentPage * _itemsPerPage + index) * 10000.0));

    currentState = currentState.copyWith(
      status: Status.success,
      products: [...currentState.products, ...nextProducts],
    );
    sink.add(currentState);
  }
}

class ListProductState {
  final List<Product> products;
  final Status status;

  ListProductState({
    required this.products,
    required this.status,
  });

  ListProductState copyWith({
    List<Product>? products,
    Status? status,
  }) {
    return ListProductState(
      products: products ?? this.products,
      status: status ?? this.status,
    );
  }
}