import 'package:client/services/api_service/product/product_model.dart';
import 'package:json_annotation/json_annotation.dart';
part 'cart_models.g.dart';

@JsonSerializable()
class Cart {
    int? id;
    int? userId;
    int? productId;
    int? qty;
    int? total_price;
    String? color;
    DateTime? createdAt;
    DateTime? updatedAt;
    Product? product;

    Cart({
        this.id,
        this.userId,
        this.productId,
        this.qty,
        this.total_price,
        this.color,
        this.createdAt,
        this.updatedAt,
        this.product,
    });

    factory Cart.fromJson(Map<String, dynamic> json) => _$CartFromJson(json);

    Map<String, dynamic> toJson() => _$CartToJson(this);

}