import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:loveria/utils/data/data.dart';
import 'package:loveria/utils/helpers/constants.dart';
import 'package:loveria/utils/helpers/styles.dart';

class SubscriptionWindow extends StatelessWidget {
  const SubscriptionWindow({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            decoration: const BoxDecoration(
              gradient: kGradientIconStyle,
              borderRadius: BorderRadius.all(Radius.circular(16.0)),
            ),
            child: Column(
              children: [
                const SizedBox(height: kDefaultPadding * 1.5),
                const Text(
                  "Get Ashiqui Pro",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: kDefaultPadding),
                const Image(
                  image: AssetImage('assets/images/premium.png'),
                  height: 76,
                  width: 76,
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(10)),
                    height: 120,
                    width: MediaQuery.of(context).size.width * .85,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Swiper(
                        key: UniqueKey(),
                        curve: Curves.linear,
                        autoplay: true,
                        physics: const ScrollPhysics(),
                        itemBuilder: (BuildContext context, int index2) {
                          return Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text(
                                  adds[index2]["title"],
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontFamily: 'Roboto',
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: kDefaultPadding / 2),
                                  child: Text(
                                    adds[index2]["subtitle"],
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 14,
                                      fontFamily: 'Roboto',
                                      fontWeight: FontWeight.w100,
                                    ),
                                  ),
                                ),
                              ]);
                        },
                        itemCount: adds.length,
                        // pagination: const SwiperPagination(
                        //   alignment: Alignment.bottomCenter,
                        //   builder: DotSwiperPaginationBuilder(
                        //       activeSize: 10,
                        //       color: Colors.black,
                        //       activeColor: Colors.white),
                        // ),
                        // control: SwiperControl(
                        //   size: 20,
                        //   color: Colors.transparent,
                        //   disableColor: Colors.transparent,
                        // ),
                        loop: false,
                      ),
                    ),
                  ),
                ),
                Container(
                  color: const Color(0xFFF4F4F4),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _buildSubsOption('1', 'Month', '450'),
                      _buildSubsOption('6', 'Month', '350'),
                      _buildSubsOption('1', 'Year', '250'),
                    ],
                  ),
                ),
                Container(
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(16.0),
                      bottomRight: Radius.circular(16.0),
                    ),
                  ),
                  child: Column(
                    children: [
                      const SizedBox(height: kDefaultPadding * 5),
                      _buildSubscriptionButton(context),
                      const SizedBox(height: kDefaultPadding),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSubsOption(String duration, String time, String price) {
    return Padding(
      padding: const EdgeInsets.all(kDefaultPadding / 2),
      child: Column(
        children: [
          Text(
            duration,
            style: const TextStyle(
              color: Color(0xFF474747),
              fontSize: 34,
              fontFamily: 'Roboto',
              fontWeight: FontWeight.w700,
            ),
          ),
          Text(
            time,
            style: const TextStyle(
              color: Color(0xFF474747),
              fontSize: 14,
              fontFamily: 'Roboto',
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 15),
          Text(
            'BDT $price/mo',
            style: const TextStyle(
              color: Color(0xFF474747),
              fontSize: 18,
              fontFamily: 'Roboto',
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSubscriptionButton(BuildContext context) {
    return RawMaterialButton(
      splashColor: const Color(0xFFEAEAEC),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30.0),
      ),
      child: Ink(
        decoration: const BoxDecoration(
          gradient: kGradientButtonStyle,
          borderRadius: BorderRadius.all(Radius.circular(30.0)),
        ),
        child: Container(
          constraints: const BoxConstraints(
            maxWidth: 300.0,
            minHeight: 36.0,
          ), // min sizes for Material buttons
          alignment: Alignment.center,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text(
              'Continue'.toUpperCase(),
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontFamily: 'Roboto',
                fontSize: 22.0,
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
      onPressed: () {
        Navigator.pop(context);
      },
    );
  }
}
