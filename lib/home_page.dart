import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:freshcut/app_constants.dart';
import 'package:freshcut/video_model.dart';
import 'package:freshcut/widgets/play_list_widget.dart';
import 'package:freshcut/widgets/space.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);

  final list = [
    VideoModel(
        image: 'smash',
        name: 'Smash Stockpile',
        totalVideos: 20,
        seenVideos: 15,
        newVideos: 10,
        hasNewVideos: true,
        hasSeenAllVideos: true),
    VideoModel(
        image: 'fgc_rumble',
        name: 'FGC Rumble',
        totalVideos: 18,
        seenVideos: 0,
        newVideos: 18,
        hasNewVideos: true,
        hasSeenAllVideos: false),
    VideoModel(
        image: 'valorant',
        name: 'Valorant Volume',
        totalVideos: 21,
        seenVideos: 21,
        newVideos: 21,
        hasNewVideos: false,
        hasSeenAllVideos: true),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black54,
      body: SafeArea(
        bottom: false,
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 15.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Space(40),
                    const _Header(),
                    ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: list.length,
                      itemBuilder: (ctx, index) => PlaylistWidget(
                        videoModel: list[index],
                      ),
                    ),
                    const _NewClipsWidget(),
                    const Space(100),
                  ],
                ),
              ),
            ),
            const _BottomNavBar()
          ],
        ),
      ),
    );
  }
}

class _Header extends StatelessWidget {
  const _Header({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          child: Image.asset(
            "assets/icons/fire_blur.png",
            width: 34.w,
            height: 41.h,
            fit: BoxFit.cover,
          ),
          right: 12,
          bottom: -5,
        ),
        Text(
          "Trending Today 🔥",
          style: TextStyle(
              fontSize: 34.sp,
              fontWeight: FontWeight.w700,
              height: 1.2,
              foreground: Paint()
                ..shader = const LinearGradient(
                  colors: <Color>[AppColors.sunGold, AppColors.red],
                ).createShader(Rect.fromLTWH(0.0, 0.0, 320.0.h, 40.0.h))),
        ),
      ],
    );
  }
}

class _NewClipsWidget extends StatelessWidget {
  const _NewClipsWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 437.h,
      width: 345.w,
      child: Column(
        children: [
          Image.asset(
            "assets/gif/verification.gif",
            height: 245.h,
            width: 270.w,
            fit: BoxFit.cover,
          ),
          Text(
            "Check back soon for new clips and creator content.",
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 22.sp,
                height: 1.27,
                fontWeight: FontWeight.w700,
                color: Colors.white),
          ),
          const Space(8),
          Text(
            "In the meantime join our discord.",
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 13.sp, height: 1.38, color: AppColors.lightGray),
          ),
          const Space(40),
          const _ButtonWidget(),
        ],
      ),
    );
  }
}

class _ButtonWidget extends StatelessWidget {
  const _ButtonWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        print("hello");
      },
      child: ShaderMask(
        shaderCallback: (bounds) {
          return const LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                AppColors.sunGold,
                AppColors.brown,
              ]).createShader(bounds);
        },
        blendMode: BlendMode.dst,
        child: Container(
          width: 345.w,
          height: 56.h,
          alignment: Alignment.center,
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    AppColors.sunGold.withOpacity(0.7),
                    AppColors.sunGold.withOpacity(0)
                  ]),
              borderRadius: BorderRadius.circular(56),
              border: Border.all(color: AppColors.sunGold.withOpacity(0.2))),
          child: TextButton.icon(
            onPressed: null,
            icon: SvgPicture.asset(
              "assets/icons/discord.svg",
              color: Colors.white,
              height: 24.sm,
              width: 24.sm,
            ),
            label: Text(
              'Join Metaview Discord',
              style: TextStyle(fontSize: 17.sp, color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }
}

class _BottomNavBar extends StatelessWidget {
  const _BottomNavBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: ClipRRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(
            sigmaX: 10,
            sigmaY: 10,
          ),
          child: Container(
            height: 88.h,
            width: MediaQuery.of(context).size.width,
            color: Colors.black.withOpacity(0.7),
            child: BottomNavigationBar(
              backgroundColor: Colors.transparent,
              type: BottomNavigationBarType.fixed,
              showUnselectedLabels: false,
              selectedLabelStyle: const TextStyle(fontSize: 10),
              fixedColor: AppColors.sunGold,
              items: [
                BottomNavigationBarItem(
                  label: "Hot",
                  icon: SvgPicture.asset(
                    "assets/icons/hot.svg",
                    height: 24.sm,
                    width: 24.sm,
                    color: AppColors.sunGold,
                  ),
                ),
                BottomNavigationBarItem(
                  label: "Discover",
                  icon: SvgPicture.asset(
                    "assets/icons/discover.svg",
                    height: 24.sm,
                    width: 24.sm,
                    color: AppColors.darkerGray,
                  ),
                ),
                BottomNavigationBarItem(
                  label: "Watch",
                  icon: SvgPicture.asset(
                    "assets/icons/watch.svg",
                    height: 24.sm,
                    width: 24.sm,
                    color: AppColors.darkerGray,
                  ),
                ),
                BottomNavigationBarItem(
                  label: "Inbox",
                  icon: SvgPicture.asset(
                    "assets/icons/inbox.svg",
                    height: 24.sm,
                    width: 24.sm,
                    color: AppColors.darkerGray,
                  ),
                ),
                BottomNavigationBarItem(
                  label: "Profile",
                  icon: SvgPicture.asset(
                    "assets/icons/profile.svg",
                    height: 24.sm,
                    width: 24.sm,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
