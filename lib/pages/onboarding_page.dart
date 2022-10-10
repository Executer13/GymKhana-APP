
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:testing/colors.dart';
import 'package:testing/smart/login_page.dart';
import 'package:testing/widget/card_planet.dart';
import 'package:concentric_transition/concentric_transition.dart';



class OnboardingPage extends StatelessWidget {
  final List<CameraDescription> cameras;
  OnboardingPage({Key? key, required this.cameras}) : super(key: key);

  final data = [
    CardPlanetData(
      title: "Welcome",
      subtitle:
          "Welcome to Gym Khana Gujrat.",
      image: 'animation/gym.json',
      backgroundColor: Colors.white,
      titleColor: tone,
      subtitleColor: const Color.fromRGBO(0, 10, 56, 1),

      
      background: LottieBuilder.asset("animation/bg-1.json"),
    ),
    CardPlanetData(
      title: "MEMBERSHIP",
      subtitle: "Get your membership at your Phone.",
      image:  'animation/member.json',
      backgroundColor: tone,
      titleColor: secondary,
      subtitleColor: Colors.white,
      background: LottieBuilder.asset("animation/bg-2.json"),
    ),
    CardPlanetData(
      title: "ORDER ANYTHING",
      subtitle: "Restaurant Access at the Palm of Your Hand",
      image: 'animation/burger.json',
      backgroundColor: Colors.white,
      titleColor: tone,
      subtitleColor:  Colors.black,
      background: LottieBuilder.asset("animation/bg-3.json"),
    ),
    CardPlanetData(
       title: "VOTING",
      subtitle: "Voting made Easy via Mobile Phone Live Polling Feature.",
      image:  'animation/voting.json',
      backgroundColor: tone,
      titleColor: secondary,
      subtitleColor: Colors.white,
      background: LottieBuilder.asset("animation/bg-1.json"),
    ),
   
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ConcentricPageView(
        colors: data.map((e) => e.backgroundColor).toList(),
        itemCount: 4,
        itemBuilder: (int currentIndex) {
         
          return   CardPlanet(data: data[currentIndex]);
         
        },
        onFinish: () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) =>  LoginPage(cameras: this.cameras,)),
          );
        },
      ),
    );
  }
}



