import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:movie/Model/movie.dart';
import 'package:movie/services/http_service.dart';

class MovieService{
  final GetIt getIt=GetIt.instance;
  HTTPService? http;
  MovieService(){
    http=getIt.get<HTTPService>();
  }
  Future<List<Movie>> getPopularMovies({required int page}) async{
    Response? _response=await http?.get('/movie/popular',query: {
      'page':page,
    });
    if(_response!.statusCode ==200){
      Map _data =_response.data;
      List<Movie>  movies=_data['results'].map<Movie>((_movieData){
        return Movie.fromJson(_movieData);
      }).toList();
      return movies;
    }else{
      throw Exception("not loading...");
    }
}
Future<List<Movie>> getUpcomingMovies({required int page}) async{
    Response? _response=await http?.get('/movie/upcoming',query: {
      'page':page,
    });
    if(_response!.statusCode ==200){
      Map _data =_response.data;
      List<Movie>  movies=_data['results'].map<Movie>((_movieData){
        return Movie.fromJson(_movieData);
      }).toList();
      return movies;
    }else{
      throw Exception("not loading...");
    }
}

  Future<List<Movie>?> searchMovies(String? _seachTerm, {int? page}) async {
    Response? _response = await http!.get('/search/movie', query: {
      'query': _seachTerm,
      'page': page,
    });
    if (_response!.statusCode == 200) {
      Map _data = _response.data;
      List<Movie>? _movies = _data['results'].map<Movie>((_movieData) {
        return Movie.fromJson(_movieData);
      }).toList();
      return _movies;
    } else {
      throw Exception('Couldn\'t perform movies search.');
    }
  }
}