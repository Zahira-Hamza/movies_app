import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app_colors.dart';

class AppStyles {
  //google fonts

  static final TextStyle medium28white = GoogleFonts.inter(
    fontSize: 28,
    fontWeight: FontWeight.w500,
    color: Colors.white,
  );
  static final TextStyle regular16gray = GoogleFonts.inter(
    fontSize: 16,
    fontWeight: FontWeight.normal,
    color: Colors.white.withOpacity(0.6),
  );
  static final TextStyle regular16white = GoogleFonts.inter(
    fontSize: 16,
    fontWeight: FontWeight.normal,
    color: Colors.white,
  );
  static final TextStyle semiBold20black = GoogleFonts.inter(
    fontSize: 20,
    fontWeight: FontWeight.w500,
    color: AppColors.blackPrimaryColor,
  );
  static final TextStyle Bold20white = GoogleFonts.inter(
    fontSize: 20,
    fontWeight: FontWeight.bold,
    color: Colors.white,
  );
}
