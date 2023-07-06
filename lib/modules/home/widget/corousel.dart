import 'dart:async';

import 'package:seller/modules/home/model/model_promos.dart';
import 'package:seller/modules/home/repo/repo_home.dart';
import 'package:flutter/material.dart';

import 'package:seller/modules/home/bloc/bloc_home.dart';
// import 'package:seller/modules/banner/model/promos.dart';

class HomeCorousel extends StatelessWidget {
  const HomeCorousel({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final blocHome = HomeBloc();
    return StreamBuilder<List<PromosModel>>(
        stream: blocHome.listBanner.stream,
        initialData: blocHome.listBanner.value,
        builder: (context, snapshot) {
          final data = snapshot.data;
          if (data == null || data.isEmpty) {
            return const AspectRatio(aspectRatio: 6 / 3, child: SizedBox());
            // return const SizedBox();
          }
          return Corosel(
            items: blocHome.listBanner.value,
          );
        });
  }
}

class Corosel extends StatefulWidget {
  const Corosel({
    Key? key,
    required this.items,
  })  : itemLenght = items.length,
        super(key: key);

  // final List<dynamic> items;
  final List<PromosModel> items;
  final int itemLenght;

  @override
  State<Corosel> createState() => _CoroselState();
}

class _CoroselState extends State<Corosel> {
  Timer? timer;
  List<String> images = [];
  final PageController _controller = PageController(
    viewportFraction: 0.8,
    initialPage: 1,
  );

  // int length = 300;
  int page = 1;

  @override
  void initState() {
    super.initState();

    for (var i = 0; i < 8; i++) {
      // widget.items.map((e) => images.add(e.imagesLink)).toList();
      widget.items.map((e) => images.add(e.imagesLink)).toList();
    }

    timer = Timer.periodic(
      const Duration(seconds: 4),
      (_) {
        if (_controller.hasClients) {
          page++;
          if (page == images.length) {
            page = 0;
            _controller.animateToPage(
              page,
              duration: const Duration(milliseconds: 80),
              curve: Curves.easeInOut,
            );
          } else {
            _controller.animateToPage(
              page,
              duration: const Duration(milliseconds: 800),
              curve: Curves.easeInOut,
            );
          }
        }
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 6 / 3,
      child: Stack(
        children: [
          PageView.builder(
            // pageSnapping: true,
            physics: const ScrollPhysics(),
            onPageChanged: (value) {
              setState(() {
                page = value;
              });
            },
            controller: _controller,
            itemBuilder: (context, index) {
              return Container(
                margin: const EdgeInsets.symmetric(horizontal: 12.0),
                decoration: BoxDecoration(
                  // color: Colors.red,
                  borderRadius: BorderRadius.circular(8.0),
                  image: DecorationImage(
                    // image: AssetImage('assets/images/banner.png'),
                    image: AssetImage(images[index]),
                    // image: NetworkImage(images[index]),
                    fit: BoxFit.cover,
                  ),
                ),
              );
            },
            itemCount: images.length,
          ),
          Indicator(index: page % images.length, length: images.length),
        ],
      ),
    );
  }
}

class Indicator extends StatelessWidget {
  const Indicator({
    Key? key,
    required this.index,
    required this.length,
  }) : super(key: key);

  final int index;
  final int length;

  @override
  Widget build(BuildContext context) {
    final long = length / 8;
    return Positioned.fill(
      bottom: 12.0,
      child: Align(
        alignment: Alignment.bottomCenter,
        child: SizedBox(
          // color: Colors.red,
          height: 4,
          child: ListView.separated(
            padding: const EdgeInsets.all(0),
            scrollDirection: Axis.horizontal,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, i) {
              return AnimatedContainer(
                width: 12.0,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(2.0),
                  color: i == (index % long) ? Colors.white : Colors.grey,
                ),
                duration: const Duration(milliseconds: 800),
              );
            },
            separatorBuilder: (context, index) {
              return const SizedBox(width: 6.0);
            },
            itemCount: long.toInt(),
          ),
        ),
      ),
    );
  }
}
