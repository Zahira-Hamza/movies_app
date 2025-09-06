import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:movies_app/core/constants/styles/app_colors.dart';
import 'package:movies_app/core/constants/styles/app_styles.dart';
import 'package:movies_app/view/widgets/film_poster/custom_film_poster.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({super.key});
  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  int currentIndex=0;
 final List<CustomFilmPoster> posters= const [
    CustomFilmPoster(imagePath: 'assets/images/movie1.jpg', rating: '7.7'),
    CustomFilmPoster(imagePath: 'assets/images/movie2.jpg', rating: '7.7'),
    CustomFilmPoster(imagePath: 'assets/images/movie3.jpg', rating: '7.7'),
    CustomFilmPoster(imagePath: 'assets/images/movie1.jpg', rating: '7.7'),
    CustomFilmPoster(imagePath: 'assets/images/movie2.jpg', rating: '7.7'),
    CustomFilmPoster(imagePath: 'assets/images/movie3.jpg', rating: '7.7')
  ];

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.sizeOf(context);
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              posters[currentIndex].imagePath,
              fit: BoxFit.fill,
            ),
          ),

          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.black.withOpacity(0.6),
                    Colors.black,
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
            ),
          ),
          Positioned.fill(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: screenSize.height * 0.05),
                  Center(
                    child: Image.asset('assets/images/available_now.png'),
                  ),
                  const SizedBox(height: 20),

                  /// ✅ CarouselSlider هنا
                  CarouselSlider(
                    items: posters.map((poster) {
                      return CustomFilmPoster(
                        imagePath: poster.imagePath,
                        rating: poster.rating,
                        height: screenSize.height * 0.6,
                        width: screenSize.width * 0.6,
                      );
                    }).toList(),
                    options: CarouselOptions(
                      height: screenSize.height*0.35,
                      enlargeCenterPage: true,
                      viewportFraction: 0.5,
                      enableInfiniteScroll: true,
                      initialPage: 0,
                      enlargeStrategy: CenterPageEnlargeStrategy.scale,
                      scrollPhysics: BouncingScrollPhysics(),
                      enlargeFactor: 0.36,
                      onPageChanged: (index,reason){
                        setState(() {
                          currentIndex=index;
                        });
                      }
                    ),
                  ),
SizedBox(height:screenSize.height*0.03,),
Image.asset('assets/images/watch_now.png'),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween
    ,children: [
                      Text('Action',style:AppStyles.regular16white,),
                      TextButton(onPressed: (){}, child:
                      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('see more',style:AppStyles.regular16white.copyWith(color: AppColors.yellowPrimaryColor)),
                          SizedBox(width: screenSize.width*0.01,),
                          Icon(Icons.arrow_forward,color: AppColors.yellowPrimaryColor,)
                        ],
                      )
                      )
                    ],),
                  ),
                  SizedBox(
                    height: screenSize.height * 0.28,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      padding: EdgeInsets.symmetric(horizontal: 8),
                      itemCount: posters.length,
                      itemBuilder: (context, index) {
                        return CustomFilmPoster(
                          imagePath: posters[index].imagePath,
                          rating: posters[index].rating,
                        );
                      },
                      separatorBuilder: (context, index) => SizedBox(width: 10),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

