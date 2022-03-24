import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:freshcut/app_constants.dart';
import 'package:freshcut/video_model.dart';
import 'package:freshcut/widgets/linear_progress_bar.dart';
import 'package:freshcut/widgets/space.dart';
import 'package:palette_generator/palette_generator.dart';

class PlaylistWidget extends StatelessWidget {
  const PlaylistWidget({Key? key, required this.videoModel}) : super(key: key);

  final VideoModel videoModel;

  Future<PaletteGenerator> _updatePaletteGenerator(String image) async {
    final paletteGenerator = await PaletteGenerator.fromImageProvider(
      Image.asset("assets/images/$image.png").image,
    );
    return paletteGenerator;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 32.h),
      decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.07),
          borderRadius: BorderRadius.circular(32.r),
          border: Border.all(color: Colors.white.withOpacity(0.05))),
      child: FutureBuilder(
          future: _updatePaletteGenerator(videoModel.image),
          builder: (context, AsyncSnapshot<PaletteGenerator> snapshot) {
            final color =
                snapshot.data?.dominantColor?.color ?? Colors.transparent;

            return Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(32.r),
                gradient: RadialGradient(
                  radius: 1.1,
                  focal: Alignment.topLeft,
                  colors: [color.withOpacity(0.2), color.withOpacity(0.0)],
                  center: const Alignment(-1.0, -1.0),
                ),
              ),
              child: Container(
                height: 403.h,
                width: 345.w,
                decoration: BoxDecoration(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(32.r),
                    gradient: const LinearGradient(
                        colors: [Colors.white, Colors.black],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight)),
                child: Column(
                  children: [
                    Padding(
                      padding:
                          EdgeInsets.only(left: 12.w, right: 12.w, top: 12.w),
                      child: Stack(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Image.asset(
                                "assets/images/${videoModel.image}.png",
                                height: 288.h,
                                width: 321.w,
                              ),
                              const Space(16),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 12.w),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      videoModel.name,
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w700,
                                          fontSize: 20.sp,
                                          height: 1.25),
                                    ),
                                    const Space(10),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "+${videoModel.newVideos} New Videos",
                                          style: TextStyle(
                                              color: videoModel.hasNewVideos
                                                  ? AppColors.sunGold
                                                  : AppColors.gray,
                                              fontSize: 12.sp,
                                              height: 1.33),
                                        ),
                                        Row(
                                          children: [
                                            SvgPicture.asset(
                                              "assets/icons/eyes.svg",
                                              height: 12,
                                              width: 12,
                                              color: videoModel.hasSeenAllVideos
                                                  ? AppColors.gray
                                                  : AppColors.sunGold,
                                            ),
                                            const Space(2),
                                            Text(
                                              "${videoModel.seenVideos}/${videoModel.totalVideos}",
                                              style: TextStyle(
                                                  color: videoModel
                                                          .hasSeenAllVideos
                                                      ? AppColors.gray
                                                      : AppColors.sunGold,
                                                  fontSize: 12.sp,
                                                  height: 1.25),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          Positioned(
                            right: 20.w,
                            bottom: 37.h,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(200),
                              child: BackdropFilter(
                                filter: ImageFilter.blur(
                                  sigmaX: 8.0,
                                  sigmaY: 8.0,
                                ),
                                child: Container(
                                  height: 64.sm,
                                  width: 64.sm,
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.white.withOpacity(0.15),
                                      border:
                                          Border.all(color: Colors.white24)),
                                  child: const Icon(
                                    Icons.play_arrow,
                                    size: 24,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    const Space(16),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 24.sm),
                      child: LinearBar(
                          progress:
                              videoModel.seenVideos / videoModel.totalVideos),
                    )
                  ],
                ),
              ),
            );
          }),
    );
  }
}
