import 'dart:ui';

import 'package:auth_app1/features/auth/presentation/controllers/theme_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileView extends StatelessWidget {
   ProfileView({super.key});

  // const ProfileView({super.key});

  final ThemeController themeController = Get.find();

  final List<String> themeNames = [
    'Light Theme',
    'Dark Theme',
    'Grey Theme',
    'Green Theme',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: themeController.themes[themeController.themeIndex].cardColor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 400,
              child: Stack(
                // alignment: AlignmentDirectional.center,
                children: [
                  Image.network(
                    height: 400,
                    'https://images.pexels.com/photos/1169754/pexels-photo-1169754.jpeg?auto=compress&cs=tinysrgb&w=600',
                  fit: BoxFit.cover,
                  ),
                  //          Container(
                  //   width: double.infinity,
                  //   height: 300,
                  //   color: Colors.black.withValues(alpha: 0.4),
                  // ),
                  // BackdropFilter(
                  //   filter: ImageFilter.blur(sigmaX: 1.0, sigmaY: 1.0),
                  //   child: Container(
                  //     width: double.infinity,
                  //     height: 300,
                  //     color: Colors.black.withValues(alpha: 0.4),
                  //   ),
                  // ),
                  Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            IconButton(
                      icon: Icon(Icons.arrow_back_ios, color: Colors.white),
                      onPressed: () => Get.back(),
                    ),
                            Obx(
                              () => DropdownButton<int>(
                                icon: Icon(Icons.switch_access_shortcut, color: Colors.white),
                                underline: SizedBox(),
                                value: themeController.themeIndex,
                                onChanged: (int? value) {
                                  if (value != null) {
                                    themeController.switchTheme(value);
                                  }
                                },
                                items: List.generate(
                                  themeNames.length,
                                  (index) => DropdownMenuItem(
                                    value: index,
                                    child: Text(themeNames[index]),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),

                        CircleAvatar(
                          radius: 55,
                          backgroundColor: const Color.fromARGB(167, 255, 255, 255),
                          child: CircleAvatar(
                            radius: 50,
                            backgroundColor: Colors.grey,
                            backgroundImage: NetworkImage(
                              // 'https://images.pexels.com/photos/9895332/pexels-photo-9895332.jpeg?auto=compress&cs=tinysrgb&w=600'
                              // 'https://images.pexels.com/photos/8721204/pexels-photo-8721204.jpeg?auto=compress&cs=tinysrgb&w=600'
                              'https://images.pexels.com/photos/1130792/pexels-photo-1130792.jpeg?auto=compress&cs=tinysrgb&w=600',
                              // 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSSEriWalt3rgigUMC63Bhg4viP_gHy3dHBidlLGVY2ds5rcQO90qjHgXs&s',
                            ),
                          ),
                        ),
                        SizedBox(height: 20),

                        Text(
                          'Rushi Creates',
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            color: Colors.white,
                            fontSize: 20,
                          ),
                        ),

                        // Bio
                        Text(
                          'Chilling much!!',
                          style: TextStyle(
                            // fontWeight: FontWeight.w500,
                            color: Colors.white,
                            fontSize: 15,
                          ),
                        ),

                        //
                        SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Column(
                              children: [
                                Text(
                                  '45k',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w800,
                                    color: Colors.white,
                                    fontSize: 15,
                                  ),
                                ),
                                Text(
                                  'Followers',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white,
                                    fontSize: 15,
                                  ),
                                ),
                              ],
                            ),

                            // Bio
                            Column(
                              children: [
                                Text(
                                  '900',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w800,
                                    color: Colors.white,
                                    fontSize: 15,
                                  ),
                                ),
                                Text(
                                  'Following',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white,
                                    fontSize: 15,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),

                        SizedBox(height: 20),

                        GestureDetector(
                          onTap: null,
                          child: Container(
                            width: 120,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                                  Colors.deepPurpleAccent.shade400,
                                  Colors.deepPurple.shade700,
                                ],
                              ),
                              borderRadius: BorderRadius.circular(30),
                            ),
                            padding: EdgeInsets.symmetric(
                              horizontal: 24,
                              vertical: 12,
                            ),
                            child: Center(
                              child: Text(
                                'Follow',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),

                        // ElevatedButton(
                        //   onPressed: null,

                        //   style: ButtonStyle(
                        //     backgroundColor: WidgetStateProperty.all<Color>(
                        //       Colors.deepPurpleAccent,
                        //     ),
                        //     padding: WidgetStateProperty.all<EdgeInsets>(
                        //       EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                        //     ),
                        //     shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                        //       RoundedRectangleBorder(
                        //         borderRadius: BorderRadius.circular(30),
                        //       ),
                        //     ),
                        //     elevation: WidgetStateProperty.all(5),
                        //   ),
                        //   child: Text(
                        //     'Follow',
                        //     style: TextStyle(
                        //       fontSize: 16,
                        //       fontWeight: FontWeight.bold,
                        //       color: Colors.white,
                        //     ),
                        //   ),
                        // ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CommonSection(tile: ProfilePost(), headingText: "Top Picks"),
                CommonSection(
                  tile: DiscoveryPost(),
                  headingText: "Discover more",
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class CommonSection extends StatelessWidget {
  final Widget tile;
  final String headingText;
  const CommonSection({
    super.key,
    required this.tile,
    required this.headingText,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 10),
        Padding(
          padding: const EdgeInsets.only(left: 15.0, top: 20, bottom: 0),
          child: HeadingText(headingText),
        ),

        //
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: SizedBox(
              height: 130,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                physics: ClampingScrollPhysics(),
                shrinkWrap: true,
                itemCount: 6,
                itemBuilder: (context, index) {
                  return tile;
                },
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class ProfilePost extends StatelessWidget {
  const ProfilePost({super.key});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: Card(
        color: Colors.transparent,
        child: Image.network(
          'https://images.pexels.com/photos/29045057/pexels-photo-29045057/free-photo-of-captivating-waterfall-in-watkins-glen-gorge.jpeg?auto=compress&cs=tinysrgb&w=600&lazy=load',

          // 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSSEriWalt3rgigUMC63Bhg4viP_gHy3dHBidlLGVY2ds5rcQO90qjHgXs&s',
          fit: BoxFit.cover,
          height: 120,
          width: 120,
        ),
      ),
    );
  }
}

class DiscoveryPost extends StatelessWidget {
  const DiscoveryPost({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Card(
            // color: Colors.black,
            child: Image.network(
              'https://images.pexels.com/photos/29352449/pexels-photo-29352449/free-photo-of-tokyo-tower-illuminated-night-skyline-view.jpeg?auto=compress&cs=tinysrgb&w=600&lazy=load',
              // 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQtlNyCy8k4Q4jaeBA1qIyUAo17HaWCzkGFRrmR_JtDBRO_kgZkQk0d7nJtd1716g6NqV0&usqp=CAU',
              fit: BoxFit.cover,
              height: 120,
              width: 200,
              // filterQuality: ,
              colorBlendMode: BlendMode.overlay,
            ),
          ),
        ),
        // Container(color: Colors.black, height: 120, width: 200),
      ],
    );
  }
}

class HeadingText extends StatelessWidget {
  final String text;
  const HeadingText(this.text, {super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        // color: Color(0xff280303),
        fontSize: 15,
        fontWeight: FontWeight.w500,
      ),
    );
  }
}
