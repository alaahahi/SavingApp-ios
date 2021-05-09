import 'package:cached_network_image/cached_network_image.dart';
import 'package:coupons/models/ProductModel.dart';
import 'package:coupons/services/likes.dart';
import 'package:coupons/services/cartService.dart';
import 'package:coupons/widgets/Cards/LikeButton.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:provider/provider.dart';
import 'package:photo_view/photo_view.dart';

class LikableCard extends StatelessWidget {
  final ProductModel product;
  final GestureTapCallback onTap;
  final bool vertical;
  final bool showEdit;

  LikableCard({
    @required this.product,
    this.onTap,
    this.vertical = true,
    this.showEdit = false,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<CartService>(
      builder: (_, cartService, __) => Container(
        width: vertical
            ? MediaQuery.of(context).size.width * 0.5
            : double.infinity,
        height: vertical ? 350 : 160,
        child: InkWell(
          onTap: onTap,
          child: Card(
            elevation: 2,
            clipBehavior: Clip.antiAlias,
            child: Stack(
              children: [
                renderContent(
                  context,
                  cartService.getQunatity(product.id),
                  cartService.change,
                ),
                Positioned(
                  bottom: vertical ? null : 0,
                  top: vertical ? 0 : null,
                  left: EasyLocalization.of(context).locale.languageCode == 'en'
                      ? 0
                      : null,
                  right:
                      EasyLocalization.of(context).locale.languageCode == 'en'
                          ? null
                          : 0,
                  child: LikeButton<ProductLikeService>(id: product.id),
                ),
                if (!cartService.isCarted(product.id))
                  Positioned(
                    bottom: 0,
                    left:
                        EasyLocalization.of(context).locale.languageCode == 'en'
                            ? null
                            : 0,
                    right:
                        EasyLocalization.of(context).locale.languageCode == 'en'
                            ? 0
                            : null,
                    child: Card(
                      margin: EdgeInsets.all(4),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      elevation: 4,
                      clipBehavior: Clip.hardEdge,
                      child: IconButton(
                        icon: Icon(
                          Icons.add_shopping_cart,
                          color: Colors.blue,
                          size: 30,
                        ),
                        onPressed: () => cartService.change(product.id, 1),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget renderContent(
    context,
    int quantity,
    void Function(int id, int quantity) changeQuantity,
  ) {
    if (vertical)
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Flexible(flex: 3, child: renderImage(context)),
          Flexible(
              flex: 2,
              fit: FlexFit.loose,
              child: renderTexts(quantity, changeQuantity)),
        ],
      );

    return Row(
      children: <Widget>[
        Flexible(flex: 2, child: renderImage(context)),
        Flexible(flex: 3, child: renderTexts(quantity, changeQuantity)),
      ],
    );
  }

  Widget renderTexts(
    int quantity,
    void Function(int id, int quantity) changeQuantity,
  ) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 4, horizontal: 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Text(
                product.title,
                overflow: TextOverflow.ellipsis,
                maxLines: vertical ? 1 : 2,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey.shade800,
                  fontWeight: FontWeight.bold,
                ),
              ),
              if (product.desc != null && product.desc.isNotEmpty)
                Text(
                  product.desc,
                  overflow: TextOverflow.ellipsis,
                  maxLines: vertical ? 1 : 2,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey.shade400,
                  ),
                ),
              SizedBox(height: 4),
              Row(
                children: [
                  if (product.discountPrice != null)
                    Text(
                      product.discountPrice == 0
                          ? 'Free'.tr()
                          : product.discountPrice.toString(),
                      overflow: TextOverflow.ellipsis,
                      maxLines: vertical ? 2 : 3,
                      style: TextStyle(
                        color: Colors.green.shade400,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  if (product.discountPrice != null) SizedBox(width: 10),
                  if (product.price != null)
                    Text(
                      product.price.toString(),
                      overflow: TextOverflow.ellipsis,
                      maxLines: vertical ? 2 : 3,
                      style: TextStyle(
                        color: product.discountPrice != null
                            ? Colors.blue.shade100
                            : Colors.blue.shade400,
                        fontSize: product.discountPrice != null ? 16 : 18,
                        fontWeight: FontWeight.bold,
                        fontStyle: product.discountPrice != null
                            ? FontStyle.italic
                            : FontStyle.normal,
                        decoration: product.discountPrice != null
                            ? TextDecoration.lineThrough
                            : TextDecoration.none,
                      ),
                    ),
                ],
              ),
            ],
          ),
          if (quantity > 0)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  child: Icon(Icons.remove),
                  onPressed: () => changeQuantity(product.id, quantity - 1),
                ),
                Text(quantity.toString()),
                TextButton(
                  child: Icon(Icons.add),
                  onPressed: () => changeQuantity(product.id, quantity + 1),
                ),
              ],
            )
        ],
      ),
    );
  }

  Widget renderImage(context) {
    if (product.photo == null || product.photo.isEmpty) {
      return renderErrorImage();
    }
    return GestureDetector(
      child: CachedNetworkImage(
        imageUrl: product.photo,
        width: double.infinity,
        height: double.infinity,
        fit: BoxFit.cover,
        errorWidget: (_, __, ____) => renderErrorImage(),
      ),
      onTap: () {
        pushNewScreen(
          context,
          pageTransitionAnimation: PageTransitionAnimation.scale,
          withNavBar: false,
          screen: PhotoView(
            imageProvider: CachedNetworkImageProvider(product.photo),
            errorBuilder: (context, error, stackTrace) => renderErrorImage(),
          ),
        );
      },
    );
  }

  CachedNetworkImage renderErrorImage() {
    return CachedNetworkImage(
      imageUrl: 'NoImagePlaceHolder'.tr(),
      fit: BoxFit.cover,
    );
  }
}
