import "package:flutter/material.dart";
import 'package:provider/provider.dart';
import '../../models/product.dart';
import '../product/products_manager.dart';

class UserProductListTile extends StatelessWidget {
  final Product product;
  const UserProductListTile(
    this.product, {
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(product.title ?? ''),
      leading: CircleAvatar(
        backgroundImage: NetworkImage(product.imageUrl ?? ''),
      ),
      trailing: SizedBox(
        width: 100,
        child: Row(
          children: <Widget>[
            EditUserProductButton(
              onPressed: () {
                ScaffoldMessenger.of(context)
                  ..hideCurrentSnackBar()
                  ..showSnackBar(
                    const SnackBar(
                      content: Text(
                        'Edit product',
                        textAlign: TextAlign.center,
                      ),
                    ),
                  );
              },
            ),
            DeleteUserProductButton(
              onPressed: () {
// Đọc ra ProductsManager để xóa product
                context.read<ProductsManager>().deleteProduct(product.id!);
                ScaffoldMessenger.of(context)
                  ..hideCurrentSnackBar()
                  ..showSnackBar(
                    const SnackBar(
                      content: Text(
                        'Product deleted',
                        textAlign: TextAlign.center,
                      ),
                    ),
                  );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class DeleteUserProductButton extends StatelessWidget {
  const DeleteUserProductButton({
    super.key,
    this.onPressed,
  });
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.delete),
      onPressed: onPressed,
      color: Theme.of(context).colorScheme.error,
    );
  }
}

class EditUserProductButton extends StatelessWidget {
  const EditUserProductButton({
    super.key,
    this.onPressed,
  });
  final void Function()? onPressed;
  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.edit),
      onPressed: onPressed,
      color: Theme.of(context).colorScheme.primary,
    );
  }
}
