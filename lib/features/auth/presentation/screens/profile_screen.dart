import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        decoration: BoxDecoration(
          // color: Colors.green,
          gradient: LinearGradient(
            colors: [
              // ORANGE + PURPLE
              // const Color.fromARGB(255, 73, 6, 85),
              // const Color.fromARGB(255, 252, 157, 14),

              // PINK + BLUE
              const Color.fromARGB(255, 254, 110, 158),
              const Color.fromARGB(255, 126, 214, 255),
            ],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Stack(
              // alignment: AlignmentDirectional.center,
              children: [
                Align(
                  alignment: AlignmentDirectional.centerEnd,
                  child: IconButton(
                    icon: Icon(Icons.settings, color: Colors.white),
                    onPressed: null,
                  ),
                ),
                ProfileCard(),
                ProfileBody(),
                // Text('hiii'),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ProfileCard extends StatelessWidget {
  const ProfileCard({super.key});

  @override
  Widget build(BuildContext context) {
    //PFP
    return Row(
      // crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
          child: const CircleAvatar(
            radius: 50,
            backgroundColor: Colors.grey,
            backgroundImage: NetworkImage(
              'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSSEriWalt3rgigUMC63Bhg4viP_gHy3dHBidlLGVY2ds5rcQO90qjHgXs&s',
            ),
          ),
        ),

        // username
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Glen Holland',
              style: TextStyle(
                fontWeight: FontWeight.w500,
                color: Colors.white,
                fontSize: 20,
              ),
            ),

            // Bio
            Text(
              'Chilling in life',
              style: TextStyle(
                // fontWeight: FontWeight.w500,
                color: Colors.white,
                fontSize: 15,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class ProfileBody extends StatelessWidget {
  const ProfileBody({super.key});

  @override
  Widget build(BuildContext context) {
    //white background card
    return Container(
      width: double.infinity,
      height: 1000,
      margin: const EdgeInsets.only(top: 170.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
        color: Colors.white,
        // color: Colors.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CommonSection(tile: ProfilePost(), headingText: "Top Picks"),
          CommonSection(tile: DiscoveryPost(), headingText: "Discover more"),
        ],
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
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSSEriWalt3rgigUMC63Bhg4viP_gHy3dHBidlLGVY2ds5rcQO90qjHgXs&s',
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
              'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQtlNyCy8k4Q4jaeBA1qIyUAo17HaWCzkGFRrmR_JtDBRO_kgZkQk0d7nJtd1716g6NqV0&usqp=CAU',
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
        color: Color(0xff280303),
        fontSize: 15,
        fontWeight: FontWeight.w500,
      ),
    );
  }
}
