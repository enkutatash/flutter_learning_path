part of 'add_product_bloc.dart';

@immutable
sealed class AddProductEvent {}

class OnImageChanged extends AddProductEvent {
  final String imageUrl;

  OnImageChanged({required this.imageUrl});
}

class OnNamedChanged extends AddProductEvent {
  final String name;

  OnNamedChanged({required this.name});
}

class OnDescriptionChanged extends AddProductEvent {
  final String description;

  OnDescriptionChanged({required this.description});
}

class OnPriceChanged extends AddProductEvent {
  final double price;

  OnPriceChanged({required this.price});
}

class OnSubmit extends AddProductEvent {
  final String imageUrl;
  final String name;
  final String description;
  final double price;

  OnSubmit({
    required this.imageUrl,
    required this.name,
    required this.description,
    required this.price,
  });
}
