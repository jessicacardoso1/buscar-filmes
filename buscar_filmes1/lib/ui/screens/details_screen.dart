import 'package:flutter/material.dart';
import 'package:buscar_filmes1/global.dart';
import 'package:buscar_filmes1/models/moviemodel.dart';
import 'package:buscar_filmes1/ui/widgets/widgets.dart';


import '../../api.dart';

class DetailsScreen extends StatefulWidget {
  final int id;

  const DetailsScreen({Key key, this.id}) : super(key: key);

  @override
  _DetailsScreenState createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  Api _api;
  Future<MovieModel> movieModel;
  @override
  void initState() {
    _api = Api();
    movieModel = _api.getMovieInfo(widget.id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: FutureBuilder<MovieModel>(
          future: movieModel,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return SingleChildScrollView(
                child: Column(
                  children: <Widget>[

                    SizedBox(
                      height: 11,
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 15.0),
                      child: Column(
                        children: <Widget>[
                          Text(
                            "${snapshot.data.original_title}",
                          ),
                          SizedBox(
                            height: 7.0,
                          ),
                          //Genero
                          SizedBox(height: 9.0),
                          /*RatingBar(
                            initialRating: snapshot.data.rating,
                            // initialRating: 3,
                            direction: Axis.horizontal,
                            allowHalfRating: true,
                            itemCount: 10,
                            itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                            itemBuilder: (context, _) => Icon(
                              Icons.star,
                              color: Colors.amber,
                            ),
                            itemSize: 25,
                            onRatingUpdate: (rating) {
                              print(rating);
                            },
                          ),*/
                          SizedBox(height: 13.0),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Column(
                                children: <Widget>[
                                  Text(
                                    "Ano",
                                    style: Theme.of(context).textTheme.caption,
                                  ),
                                  Text(
                                    "${DateTime.parse(snapshot.data.release_date).year}",
                                    style: Theme.of(context).textTheme.subhead,
                                  ),
                                ],
                              ),
                              Column(
                                children: <Widget>[
                                  Text(
                                    "Duração",
                                    style: Theme.of(context).textTheme.caption,
                                  ),
                                  Text(
                                    "${snapshot.data.run_time} min",
                                    style: Theme.of(context).textTheme.subhead,
                                  ),
                                ],
                              ),
                            ],
                          ),
                          SizedBox(height: 13.0),
                          RichText(
                            text: TextSpan(
                              children: List.generate(
                                snapshot.data.genre.length,
                                    (i) {
                                  return TextSpan(
                                      text:
                                      "${snapshot.data.genre[i]['name']} ");
                                },
                              ),
                              style: Theme.of(context).textTheme.caption,
                            ),
                          ),
                          Row(
                             children: <Widget>[
                               Text("Descrição",
                                 textAlign: TextAlign.left,),
                               Text(
                                 "${snapshot.data.overview}",
                                 textAlign: TextAlign.left,
                                 style: Theme.of(context)
                                     .textTheme
                                     .body1
                                     .apply(fontSizeFactor: 1.2),
                               ),
                             ],
                          ),
                          SizedBox(height: 13.0),
                        ],
                      ),
                    ),
                    // MyScreenshots(),
                    SizedBox(height: 13.0),
                  ],
                ),
              );
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      ),
    );
  }
}
