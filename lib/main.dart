
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/modules/help/help_screen.dart';
import 'package:shop_app/modules/product_details/product_screen.dart';
import 'package:shop_app/modules/searchscreen/search.dart';
import 'package:shop_app/modules/settingsscreen/settings.dart';
import 'package:shop_app/modules/shopApp/register/registerscreen.dart';
import 'package:shop_app/shared/end_pointes.dart';
import 'package:shop_app/shared/local/sharedpref.dart';
import 'package:shop_app/shared/shear.dart';
import 'package:shop_app/shooCupit/shopcupit.dart';
import 'package:shop_app/shooCupit/shopstates.dart';
import 'dio/Dio.dart';
import 'modules/shopApp/login/log_in.dart';
import 'modules/shopApp/onBoarding/boarding.dart';
import 'modules/shopApp/splash/splashscreen.dart';
import 'modules/shoplayaout/shoplayout.dart';

void main()async
{
  WidgetsFlutterBinding.ensureInitialized();
  //علشاان اضمن اني الحاجات دي تحصل بعد كده يرووح يشغل البرنامج بقي
  Bloc.observer=MyBlocObserver();
  DioHelper.init();
  await Shared.init();
  Widget widget;

  bool onBoarding=Shared.getDate(key: 'OnBoarding');
    token=Shared.getDate(key: 'token');
    print(token);
  if(onBoarding!=null){
    if(token!=null) {
      widget=Splash();
    } else widget=LogIn();
  }else{
    widget=OnBoarding();
  }
  runApp(MyApp(
    startWidget:widget,
  ));
}
class MyApp extends StatelessWidget {

  final Widget startWidget;

  MyApp({
    this.startWidget,
});
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) =>yoracubit()..getDataHome()..getDataCategories()..getFavorites()..getProfile()..getCart(),
      child: BlocConsumer<yoracubit,ShopStates>(
        listener: (context,state){},
        builder: (context,state){
          return MaterialApp(
            routes:
            {
              'rout1':(context)=>LogIn(),
              'rout2':(context)=>Register(),
              'rout3':(context)=>ShopLayout(),
              'rout4':(context)=>Search(),
              'rout5':(context)=>Settings(),
              'rout6':(context)=>Help(),
            },
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              appBarTheme:AppBarTheme(
                  backwardsCompatibility: false,
                  systemOverlayStyle:SystemUiOverlayStyle(
                    statusBarColor: Colors.transparent,
                    statusBarIconBrightness: Brightness.light,
                  ),
                  backgroundColor: Colors.indigoAccent[400],
                  elevation: 0,
                  titleTextStyle: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 20
                  ),
                  iconTheme:IconThemeData(
                      color: Colors.white
                  )
              ),
            ),
            home:startWidget,
          );
        },
      ),
    );
  }
}


