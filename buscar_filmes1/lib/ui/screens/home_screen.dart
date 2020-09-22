import 'package:flutter/material.dart';
import 'package:buscar_filmes1/api.dart';
import 'package:buscar_filmes1/models/genremodel.dart';
import 'package:buscar_filmes1/models/moviemodel.dart';
import 'package:buscar_filmes1/ui/widgets/widgets.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Future<List<GenreModel>> genreList;
  Future<List<MovieModel>> MovieList;
  Api _api;
  @override
  void initState() {
    super.initState();
    _api = Api();
    genreList = _api.getGenreList();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          title: Text(
            "Filmes",
            style: TextStyle(color: Colors.black, fontSize: 25),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 7,
              ),
              Padding(
                padding: EdgeInsets.all(10.0),
                child: TextField(
                  cursorColor: Colors.black,
                  decoration: InputDecoration(
                      prefixIcon: Icon(Icons.search,), fillColor: Colors.black,
                      labelText: "Pesquise filmes",
                      labelStyle: TextStyle(color: Colors.black26),
                      focusedBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      errorBorder: InputBorder.none,
                      disabledBorder: InputBorder.none,
                    contentPadding: EdgeInsets.only(left: 15, bottom: 11, top: 11, right: 15),
                  ),

                  style: TextStyle(color: Colors.black, fontSize: 18.0),
                  textAlign: TextAlign.center,
                ),

              ),
              SizedBox(
                height: 15,
              ),
              /*Container(
                height: MediaQuery.of(context).size.height / 3,
                child: FutureBuilder<List<FeaturedMovieModel>>(
                  future: featuredMovies,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return HomePageFeaturedWidget(snapshot: snapshot);
                    } else {
                      return Center(child: CircularProgressIndicator());
                    }
                  },
                ),
              ),*/
              //Container para pesquisar por genero.
              Container(
                padding: EdgeInsets.only(left: 5.0),
                height: 50,
                child: FutureBuilder<List<GenreModel>>(
                  future: genreList,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return ListView.builder(
                        itemCount: snapshot.data.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (ctx, id) {
                          return Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(25.0),
                              color: Colors.cyan[900],
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black,
                                  blurRadius: 2.5,
                                )
                              ],
                            ),
                            // width: MediaQuery.of(context).size.width / 2.5,
                            constraints: BoxConstraints(minWidth: 100),
                            alignment: Alignment.center,
                            margin: EdgeInsets.symmetric(
                              horizontal: 7,
                              vertical: 5.0,
                            ),
                            padding:
                            const EdgeInsets.symmetric(horizontal: 5.0),
                            child: Text(
                              "${snapshot.data[id].name}",
                              style: Theme.of(context)
                                  .textTheme
                                  // ignore: deprecated_member_use
                                  .headline
                                  .apply(color: Colors.white),
                            ),
                          );
                        },
                      );
                    } else {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  },
                ),
              ),
              SizedBox(
                height: 15,
              ),
              //Container para exibir os filmes.
              Container(
                  height: MediaQuery.of(context).size.height / 3,
                  child: FutureBuilder<List<MovieModel>>(
                    future: MovieList,
                    builder: (ctx, snapshot) {
                      if (snapshot.hasData) {
                        return ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: snapshot.data.length,
                          itemBuilder: (ctx, id) {
                            return MovieContainer(snapshot: snapshot.data[id]);
                          },
                        );
                      } else {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                    },
                  ),
                ),

            ],
          ),
        ),
      ),
    );
  }
}
