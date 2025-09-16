import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:movies_app/core/constants/styles/app_colors.dart';
import 'package:movies_app/view/widgets/movies/custom_film_poster.dart';

class SearchTab extends StatelessWidget {
  const SearchTab({super.key});

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: AppColors.blackPrimaryColor,
      body: Column(
        children: [
          Padding(padding: EdgeInsets.symmetric(horizontal:12,vertical: 12)),
          Container(
            width: screenSize.width*0.95,
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 12),
            child: TextField(
              style:TextStyle(color: AppColors.white),
              decoration: InputDecoration(
                prefixIcon: Padding(
                  padding:EdgeInsets.all(16.0),
                child: Image.asset('assets/images/icons/search_tab.png',
                    width: 20,
                    height: 20,),
                ),
                hintText: 'Search',
                hintStyle: const TextStyle(
                  color:AppColors.white ,
                  fontWeight: FontWeight.w400,
                  fontSize: 16,
                ),
                filled: true,
                fillColor: AppColors.grey,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          ),
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.all(8),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
                childAspectRatio: 0.7,
              ),
              itemCount: 20,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: (){},
                  child: CustomFilmPoster(
                    imagePath: "assets/images/movie1.png",
                    rating: "8.5",
                    height: screenSize.height * 0.3,
                    width: screenSize.width * 0.4,
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
