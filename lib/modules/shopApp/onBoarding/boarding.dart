import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shop_app/modules/shopApp/login/log_in.dart';
import 'package:shop_app/shared/local/sharedpref.dart';
import 'package:shop_app/shared/shear.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class BoardingModel{
  final String image;
  final String title;
  final String body;
  BoardingModel(
      //يتم استخدامه لحظه انشاء اوبجيكت
  {
    @required this.image,
    @required this.title,
    @required this.body,

});
}
class OnBoarding extends StatefulWidget {
  @override
  _OnBoardingState createState() => _OnBoardingState();
}

class _OnBoardingState extends State<OnBoarding> {

  var boardController=PageController();

  List<BoardingModel>boarding =
  [
    BoardingModel(
      image: 'imag/sho.png',
      title: 'delivery speed',
      body: 'In just 48 hours',
    ),
    BoardingModel(
      image: 'imag/shoo.png',
      title: 'the quality',
      body: 'super excellent',
    ),
    BoardingModel(
      image: 'imag/shooo.png',
      title: 'Application speed',
      body: 'Different from all programs',
    ),
  ];
  bool isLast=false;//علشان هعرف منين اني وصلت لاخر عنصر علشان خلاص اروح لشاشه اللي بعد كده علي سبيل المثال شاشه تسجيل الدخول
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        backwardsCompatibility: false,
        systemOverlayStyle:SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.dark,
        ),
        actions:
        [
          TextButton(
            onPressed:(){
              Clic(context);
            },
            child: Text(
              'SKIP',
              style: TextStyle(
                color: Colors.indigoAccent[400],
                fontWeight: FontWeight.bold,
                fontSize: 16
              ),
            ),
          ),
        ],
      ),
      body:Padding(
        padding: const EdgeInsets.all(30),
        child: Column(
          children:
          [
            Expanded(
              child: PageView.builder(
                onPageChanged: (int index)
                {
                  if(index==boarding.length-1)
                  {
                    setState(()
                    {
                      isLast=true;

                    });
                  }else
                    {
                    setState(()
                    {
                      isLast=false;

                    });
                  }
                },
                physics: BouncingScrollPhysics(),
                controller: boardController,
                itemBuilder: (context,index)=>buildBoardingItem(boarding[index]),
                itemCount: boarding.length,
              ),
            ),
            SizedBox(
              height: 40.0,
            ),
            Row(
              children: [
               SmoothPageIndicator(
                 effect:ExpandingDotsEffect(
                   dotHeight: 10,
                   dotColor: Colors.grey,
                   activeDotColor: Colors.indigoAccent[400],
                   spacing: 5.0,
                   expansionFactor: 4,
                 ),
                   controller: boardController,
                   count: boarding.length,
               ),
                Spacer(),
                FloatingActionButton(
                  backgroundColor: Colors.indigoAccent[400],
                    onPressed: ()
                    {
                    if(isLast)
                    {
                      Clic(context);
                    }else
                      {
                      boardController.nextPage
                        (
                        duration: Duration(
                          milliseconds: 750,
                        ),
                        curve:Curves.fastLinearToSlowEaseIn,
                      );
                    }
                    },
                     child:  Icon(
                       Icons.arrow_forward_ios,
                       color: Colors.white,
                     ),
                )
              ],
            )
          ],
        ),
      ),
    );

  }
  Widget buildBoardingItem(BoardingModel model)=>Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children:
    [
      Expanded(
        child: Image(
          height: 200,
          image:AssetImage(
            '${model.image}'
          ),
        ),
      ),
      SizedBox(
        height: 30.0,
      ),
      Text(
        '${model.title}',
        style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold
        ),
      ),
      SizedBox(
        height: 15.0,
      ),
      Text(
        '${model.body}',
        style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold
        ),
      ),
    ],
  );
}
