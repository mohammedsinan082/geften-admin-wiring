import 'package:flutter/material.dart';
import 'package:gefmartwiringadmin/feature/home/deleted_users/deleted_users.dart';
import 'package:gefmartwiringadmin/feature/home/gold_members/gold_members.dart';
import 'package:gefmartwiringadmin/feature/home/qr_generating/screen/qr_GenerateData.dart';
import 'package:gefmartwiringadmin/feature/home/qr_view/screen/batch_data.dart';
import 'package:gefmartwiringadmin/feature/home/side_menu.dart';
import 'package:gefmartwiringadmin/feature/home/silver_members/silver_members.dart';
import 'package:responsive_builder/responsive_builder.dart';

import 'Users.dart';
import 'dashboard.dart';

late TabController tabController;
var mainColor = Color(0xFF084586);

class HomePage extends StatefulWidget {
  // final QuestionModel questionModel;
  const HomePage({Key? key}) : super(key: key);
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
    tabController = TabController(length:7, initialIndex: 0, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ResponsiveBuilder(
        builder: (BuildContext context, SizingInformation sizingInformation) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SideMenu(tabController: tabController),
              Expanded(
                  child: TabBarView(
                    controller: tabController,
                    physics: const NeverScrollableScrollPhysics(),
                    children: [
                      Dashboard(tabController: tabController,),
                      UserPage(),
                      SilverMembers(),
                      GoldMembers(),
                      DeletedUsersPage(),
                      QrGenerateDataTable(),
                      BatchListPage(),

                      // QuestionPage(questionModel: widget.questionModel),
                      // ViewDataCategory(),
                      // DashBoard(), //0
                      // ProductCategoryMain(),//1,
                      // DeletedProduct(),//2
                      // WarrantyCategoryMain() //3
                    ],
                  ))
            ],
          );
        },
      ),
    );
  }
}