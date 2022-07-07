import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:scroll_indicator/scroll_indicator.dart';
import 'package:shop_app/models/shop_App/Categoriesmodel.dart';
import 'package:shop_app/models/shop_App/homemodel.dart';
import 'package:shop_app/modules/product_details/product_screen.dart';
import 'package:shop_app/shooCupit/shopcupit.dart';
import 'package:shop_app/shooCupit/shopstates.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';


class Products extends StatelessWidget {
  var scrollController=ScrollController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<yoracubit,ShopStates>(
      listener: (context,state){
        if(state is ShopSuccessFavoritesStates){
          if(!state.model.status){
            Fluttertoast.showToast(
              msg: state.model.message,
              toastLength: Toast.LENGTH_LONG,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16.0,
            );
          }
        }
      },
      builder: (context,state){
        return  ConditionalBuilder(
            condition: yoracubit.get(context).homeModel!=null && yoracubit.get(context).categoriesModel!=null,
            builder: (context)=>productsBuilder(yoracubit.get(context).homeModel,yoracubit.get(context).categoriesModel,context),
          fallback: (context)=>Center(child: CircularProgressIndicator()),
        );
      },
    );
  }
  Widget productsBuilder( HomeModel model,CategoriesModel categories,context)=>SingleChildScrollView(
    physics: BouncingScrollPhysics(),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children:
      [
        Container(
          alignment: AlignmentDirectional.center,
          width: double.infinity,
          height: 50,
          color: Colors.blue[100],
          child: Text(
            'Free delivery all over the country'
          ),
        ),
        SizedBox(
          height: 10,
        ),
        CarouselSlider(
            items:model.data.banners.map((e) => CachedNetworkImage(
              width: double.infinity,
              height: 200,
              imageUrl:e.image,
              fit: BoxFit.cover,
              progressIndicatorBuilder:
                  (context, url, downloadProgress) =>
                  Center(
                    child: CircularProgressIndicator(
                      value: downloadProgress.progress,
                      strokeWidth: 3,
                    ),
                  ),
              errorWidget: (context, url, error) =>
                  Icon(Icons.error,color: Colors.indigoAccent[400],),
            ),).toList(),
            options: CarouselOptions(
              height: 250,
              initialPage: 0,
              enableInfiniteScroll: true,
              viewportFraction: 1.0,
              reverse: false,
              autoPlay: true,
              autoPlayInterval: Duration(seconds: 3),
              autoPlayAnimationDuration: Duration(
                seconds: 1
              ),
              autoPlayCurve: Curves.fastOutSlowIn,
              scrollDirection: Axis.horizontal,
              onPageChanged: (index, reason) {
                yoracubit.get(context).onPageChange(index: index);
              },
            )
        ),
        SizedBox(
          height: 10,
        ),
        Center(
          child: AnimatedSmoothIndicator(
            count: yoracubit.get(context).homeModel.data.banners.length,
            activeIndex: yoracubit.get(context).activeIndex,
            effect: ExpandingDotsEffect(
              dotColor: Colors.grey[400],
              dotHeight: 10,
              dotWidth: 10,
              expansionFactor: 4,
              spacing: 5,
              activeDotColor: Colors.indigoAccent[400],
            ),
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Text(
          'Categories',
          style: TextStyle(
            color: Colors.black87,
            fontSize: 20,
            fontWeight: FontWeight.bold
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 10
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 5,
              ),
              Container(
                decoration: BoxDecoration(
                  //borderRadius: BorderRadius.circular(20),
                  color: Colors.grey[200],
                ),
                height: 80,
                width: double.infinity,
                child:Padding(
                  padding: const EdgeInsets.all(8.0),
                  child:Container(
                    height: 80,
                    child: ListView.separated(
                      controller:scrollController ,
                      physics: BouncingScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                        itemBuilder: (context,index)=>CategoriesItem(categories.data.data[index]),
                        separatorBuilder:(context,index)=>SizedBox(
                          width: 20,
                        ),
                        itemCount: categories.data.data.length,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                'New Products',
                style: TextStyle(
                    color: Colors.black87,
                    fontSize: 20,
                    fontWeight: FontWeight.bold
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 5,
        ),
        Container(
          color: Colors.grey[200],
          child: GridView.count(
            shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              mainAxisSpacing: 4,
              crossAxisSpacing: 4,
              crossAxisCount:2,
            childAspectRatio: 1/1.99,
            children:List.generate(model.data.products.length, (index) =>GridViewProducts(model.data.products[index],context))
          ),
        )
      ],
    ),
  );
  Widget CategoriesItem(DataModel model)=> Row(
    children: [
      Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: Colors.white,
        ),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(5),
              child: CachedNetworkImage(
                width: 20,
                height: 20,
                imageUrl:model.image,
                fit: BoxFit.cover,
                progressIndicatorBuilder:
                    (context, url, downloadProgress) =>
                    Center(
                      child: CircularProgressIndicator(
                        value: downloadProgress.progress,
                        strokeWidth: 3,
                      ),
                    ),
                errorWidget: (context, url, error) =>
                    Icon(Icons.error,color: Colors.indigoAccent[400],),
              ),
            ),
            SizedBox(
              width: 3,
            ),
            Text(
              model.name,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ],
        ),
        width: 160,
        height: 100,
      ),
    ],
  );

  Widget GridViewProducts(ProductsModel model,context)=>Padding(
    padding: const EdgeInsets.all(6),
    child: InkWell(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context){
          return ProductScreen(model.id);
        }));
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: Colors.white,
        ),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.white,
                ),
                height: 200,
                child: Padding(
                  padding: const EdgeInsets.all(17),
                  child: Stack(
                    alignment: AlignmentDirectional.bottomStart,
                    children: [
                      CachedNetworkImage(
                        width: 200,
                        height: 200,
                        imageUrl:model.image,
                        fit: BoxFit.cover,
                        progressIndicatorBuilder:
                            (context, url, downloadProgress) =>
                            Center(
                              child: CircularProgressIndicator(
                                value: downloadProgress.progress,
                                strokeWidth: 3,
                              ),
                            ),
                        errorWidget: (context, url, error) =>
                            Icon(Icons.error,color: Colors.indigoAccent[400],),
                      ),
                      if(model.discount!=0)
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 5),
                        color: Colors.lightBlueAccent,
                        child: Text(
                          'DISCOUNT',
                          style: TextStyle(
                            fontSize: 10,
                            color: Colors.white
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Text(
                model.name,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  height: 1.3,
                ),
              ),
              Row(
                children: [
                  IconButton(
                      iconSize: 10,
                      onPressed: (){
                        yoracubit.get(context).addAndRemoveFromCart(model.id);
                      },
                      icon: CircleAvatar(
                        backgroundColor: yoracubit.get(context).cart[model.id]? Colors.lightBlueAccent:Colors.grey,
                        radius: 15,
                        child: Icon(
                          Icons.shopping_cart,
                          color: Colors.white,
                          size: 14,
                        ),
                      )
                  ),
                  IconButton(
                      onPressed: (){
                        yoracubit.get(context).changeFavorites(model.id);
                      },
                      icon: CircleAvatar(
                        backgroundColor: yoracubit.get(context).favorites[model.id]? Colors.pink:Colors.grey,
                        radius: 15,
                        child: Icon(
                          Icons.favorite_border,
                          color: Colors.white,
                          size: 14,
                        ),
                      )
                  ),
                ],
              ),
              Container(
                height: 10,
                child: RatingBar.builder(
                  itemSize: 10,
                  initialRating: 1,
                  minRating: 1,
                  direction: Axis.horizontal,
                  allowHalfRating: true,
                  itemCount: 5,
                  itemPadding: EdgeInsets.symmetric(horizontal: 3.0),
                  itemBuilder: (context, _) => Icon(
                    Icons.star,
                    color: Colors.lightBlueAccent,
                    size: 5,
                  ),
                  onRatingUpdate: (rating) {
                    print(rating);
                  },
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                '${model.price}',
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 10,
                  color: Colors.indigoAccent[400],
                  fontWeight: FontWeight.bold
                ),
              ),
              SizedBox(
                width: 5,
              ),
              if(model.discount !=0)
                Text(
                  '${model.old_price}',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      fontSize: 9,
                      color: Colors.black,
                      decoration: TextDecoration.lineThrough
                  ),
                ),
            ],
          ),
        ),
      ),
    ),
  );
}
