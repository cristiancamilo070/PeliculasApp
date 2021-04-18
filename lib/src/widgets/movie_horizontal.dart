import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:peliculas/src/models/pelicula_model.dart';
class MovieHorizontal extends StatelessWidget {

  final List<Pelicula>peliculas;
  final Function siguientePagina;
  MovieHorizontal({@required this.peliculas,@required this.siguientePagina});
  
  final _pageControler =new PageController(
      initialPage: 1,
        viewportFraction: 0.3
  );

  @override
  Widget build(BuildContext context) {
   
  final _screenSize= MediaQuery.of(context).size;

  _pageControler.addListener(() {
    if (_pageControler.position.pixels>=_pageControler.position.maxScrollExtent-200) {
      siguientePagina();
    }
   });

   return Container(
    height: _screenSize.height*0.26,
    child: PageView.builder(
      pageSnapping: false,
      controller: _pageControler,
      itemCount: peliculas.length,
     // children: _tarjetas(context)
     itemBuilder: (context, i){
      return _tarjeta(context, peliculas[i]);
     },
    ),
   );
  }

  Widget _tarjeta(BuildContext context, Pelicula pelicula){
    pelicula.uniqueId='${pelicula.id}-poster';
  final tarjeta=  Container(
  margin: EdgeInsetsDirectional.only(),
  child:Column(
    children: [
      Hero(
        tag: pelicula.uniqueId,
        child: ClipRRect(
            borderRadius: BorderRadius.circular(20.0),
                child: FadeInImage(
            placeholder: AssetImage('assets/img/no-image.jpg'), 
            image: NetworkImage(pelicula.getPosterImg()),
            fit: BoxFit.cover,
            height: 160,
            ),
        ),
      ),
      Text(pelicula.title, 
      overflow: TextOverflow.ellipsis,
      style: Theme.of(context).textTheme.caption,)
    ],//x
  ) ,
);
return GestureDetector(
  onTap: (){
    timeDilation=1.5;
    Navigator.pushNamed(context, 'detalle',
    arguments: pelicula);
  },
  child: tarjeta);
  }


  List<Widget> _tarjetas(BuildContext context){
  return peliculas.map((pelicula) {
  
  return Container(
  margin: EdgeInsetsDirectional.only(),
  child:Column(
    children: [
      ClipRRect(
          borderRadius: BorderRadius.circular(20.0),
              child: FadeInImage(
          placeholder: AssetImage('assets/img/no-image.jpg'), 
          image: NetworkImage(pelicula.getPosterImg()),
          fit: BoxFit.cover,
          height: 160,
          ),
      ),
      Text(pelicula.title, 
      overflow: TextOverflow.ellipsis,
      style: Theme.of(context).textTheme.caption,)
    ],
  ) ,
);
    } ).toList();
  }
}