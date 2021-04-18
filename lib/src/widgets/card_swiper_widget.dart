import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:peliculas/src/models/pelicula_model.dart';
class CardSwiper extends StatelessWidget {

  final List<Pelicula> peliculas;
  CardSwiper({@required this.peliculas});

  @override
  Widget build(BuildContext context) {
    final _screenSize= MediaQuery.of(context).size;

    return Container( 
      padding: EdgeInsets.only(top: 2.0),
      width: double.infinity,
      height: _screenSize.height*0.6,
      child: Swiper(
          layout: SwiperLayout.STACK,
          itemWidth: _screenSize.width*0.7,
          itemHeight: _screenSize.height*0.5,
          autoplay: false,
          //autoplayDelay: 2400,
          curve: Curves.bounceInOut,
          itemCount: peliculas.length,
         // scrollDirection: Axis.horizontal,
          pagination: new SwiperPagination(
            alignment: Alignment.bottomCenter,
            builder: SwiperPagination.dots
            ),
          control: new SwiperControl(),
          itemBuilder: (BuildContext context,int index){

            peliculas[index].uniqueId='${peliculas[index].id}-tarjeta';

            return Hero(
                tag: peliculas[index].uniqueId,
                child: ClipRRect(
                borderRadius: BorderRadius.circular(20.0),
                child: GestureDetector(
                  onTap: (){
                    timeDilation=2;  
                    Navigator.pushNamed(context, 'detalle', arguments: peliculas[index]);

                  },
                  //onTap:()=>Navigator.pushNamed(context, 'detalle', arguments: peliculas[index]),
                  child: FadeInImage(
                    placeholder: AssetImage('assets/img/no-image.jpg'),
                    image: NetworkImage( peliculas[index].getPosterImg()),
                    fit: BoxFit.cover,
                    ),
                )
              ),
            );            
          },
          
        ),
    );

  }
}