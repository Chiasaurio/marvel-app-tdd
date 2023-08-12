import 'package:bia_flutter_test/features/characters/presentation/pages/character_detail.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import '../../../../core/util/create_route_animation.dart';
import '../../domain/entities/character.dart';

class CharactersSwiper extends StatefulWidget {
  final List<Character> characters;
  const CharactersSwiper({super.key, required this.characters});

  @override
  State<CharactersSwiper> createState() => _CharactersSwiperState();
}

class _CharactersSwiperState extends State<CharactersSwiper> {
  int _current = 0;
  final CarouselController _controller = CarouselController();
  List<Widget> imageSliders = [];

  @override
  void initState() {
    loadImagesClip();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      CarouselSlider(
        items: imageSliders,
        carouselController: _controller,
        options: CarouselOptions(
            autoPlay: true,
            enlargeCenterPage: true,
            aspectRatio: 1.0,
            viewportFraction: 0.8,
            onPageChanged: (index, reason) {
              setState(() {
                _current = index;
              });
            }),
      ),
    ]);
  }

  void loadImagesClip() {
    imageSliders = widget.characters
        .map((item) => Container(
              margin: const EdgeInsets.all(5.0),
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                      context, crearRuta(CharacterDetailPage(character: item)));
                },
                child: ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(5.0)),
                    child: Stack(
                      children: <Widget>[
                        Image.network('${item.thumbnail}/portrait_uncanny.jpg',
                            fit: BoxFit.cover, width: 1000.0),
                        Positioned(
                          bottom: 0.0,
                          left: 0.0,
                          right: 0.0,
                          child: Container(
                            decoration: const BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  Color.fromARGB(200, 0, 0, 0),
                                  Color.fromARGB(0, 0, 0, 0)
                                ],
                                begin: Alignment.bottomCenter,
                                end: Alignment.topCenter,
                              ),
                            ),
                            padding: const EdgeInsets.symmetric(
                                vertical: 10.0, horizontal: 20.0),
                            child: Text(
                              item.name,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],
                    )),
              ),
            ))
        .toList();

    setState(() {});
  }
}
