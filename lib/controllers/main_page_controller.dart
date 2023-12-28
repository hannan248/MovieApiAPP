import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:movie/Model/mian_page_data.dart';
import 'package:movie/Model/movie.dart';
import 'package:movie/Model/search_category.dart';
import 'package:movie/services/movie_service.dart';

class MainPageController extends StateNotifier<MainPageData>{
  MainPageController([MainPageData? state]):super(state??MainPageData.initial()){
   getMovies();
  }
  final MovieService movieService=GetIt.instance.get<MovieService>();
  Future<void> getMovies() async {
    try{
      List<Movie> movies=[];
      if(state.searchText.isEmpty){
        if(state.searchCategory== SearchCategory.popular){
          movies=await movieService.getPopularMovies(page:state.page);
        }else if(state.searchCategory== SearchCategory.upcoming){
          movies=await movieService.getUpcomingMovies(page:state.page);
        }else if(state.searchCategory== SearchCategory.none){
          movies=[];
        }
      }else{
        movies=(await movieService.searchMovies(state.searchText))!;
      }
      state=state.copyWith(movies:[...state.movies,...movies],page:state.page+1,);
    }catch(e){print(e);}
  }
  void updateSearchCategory(String _caterogry){
    try{
      state=state.copyWith(movies:[],page:1,searchCategory: _caterogry,searchText: '');
      getMovies();
    }catch(e){
      print(e);
    }
  }
  void updateTextSearch(String _searchText) {
    try {
      state = state.copyWith(
          movies: [],
          page: 1,
          searchCategory:'',
          searchText: _searchText);
      getMovies();
    } catch (e) {
      print(e);
    }
  }
}