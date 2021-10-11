import 'package:flutter/material.dart';

class GmUIVM {
  PageController pageController = PageController(initialPage: 1);

  int selectedPage = 1;

  changePage(int index) {
    this.selectedPage = index;
    this.pageController.animateToPage(index,
        duration: Duration(milliseconds: 500), curve: Curves.ease);
  }
}
