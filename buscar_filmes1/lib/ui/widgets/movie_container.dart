import 'package:flutter/material.dart';
import 'package:buscar_filmes1/global.dart';
import 'package:buscar_filmes1/models/moviemodel.dart';
import '../screens/screens.dart';

class MovieContainer extends StatelessWidget {
  final MovieModel snapshot;

  const MovieContainer({
    Key key,
    this.snapshot,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {

    return GestureDetector(
      //Página com os detalhes do filme.
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (ctx) => DetailsScreen(id: snapshot.id),
          ),
        );
      },
      child: Container(
        child: Stack(
          children: <Widget>[
            Container(
                child: Image.network(
                  // movieList[id]['img'],
                  getPosterImage(snapshot.poster_path),
                ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                padding: EdgeInsets.all(15.0),
                decoration: BoxDecoration(
                  color: Colors.black45,
                ),
                child: Column(
                  children: <Widget>[
                    Text(
                      // "${movieList[id]['title']}",
                      snapshot.original_title,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                      ),
                    ),
                    RichText(
                      text: TextSpan(
                        children: List.generate(
                          snapshot.genre.length,
                              (i) {
                            return TextSpan(
                                text:
                                "${snapshot.genre[i]['name']} ");
                          },
                        ),
                      ),
                    ),


                  ],
                )
              ),
            )
          ],
        ),
      ),
    );
  }
}
