import 'package:cached_network_image/cached_network_image.dart';
import 'package:ditonton/common/constants.dart';
import 'package:ditonton/data/models/genre_model.dart';
import 'package:ditonton/domain/entities/tvshow.dart';
import 'package:ditonton/domain/entities/tvshow_detail.dart';
import 'package:ditonton/presentation/bloc/tvshow/tvshow_bloc.dart';

import 'package:ditonton/common/state_enum.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';

import '../../domain/entities/genre.dart';

class TvshowDetailPage extends StatefulWidget {
  static const ROUTE_NAME = '/detailtv';

  final int id;
  TvshowDetailPage({required this.id});

  @override
  _TvshowDetailPageState createState() => _TvshowDetailPageState();
}

class _TvshowDetailPageState extends State<TvshowDetailPage> {
  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      context.read<TvshowDetailBloc>().add(FetchTvshowDetail(widget.id));
      context
          .read<TvshowRecommendationBloc>()
          .add(FetchTvshowRecommendation(widget.id));
      context.read<WatchlistTvshowBloc>().add(WatchlistTvshowStatus(widget.id));
    });

    // Future.microtask(() {
    //   Provider.of<TvshowDetailNotifier>(context, listen: false)
    //       .fetchTvshowDetail(widget.id);
    //   Provider.of<TvshowDetailNotifier>(context, listen: false)
    //       .loadWatchlistStatus(widget.id);
    // });
  }

  @override
  Widget build(BuildContext context) {
    final moviesRecommendation =
        context.select<TvshowRecommendationBloc, List<Tvshow>>((value) {
      var state = value.state;
      if (state is TvshowsHasData) {
        return (state).tvshow;
      }
      return [];
    });

    final isAddedToWatchlist = context.select<WatchlistTvshowBloc, bool>((val) {
      var state = val.state;
      if (state is WatchlistTvshowStatusState) {
        return state.status;
      }
      return false;
    });

    return Scaffold(
      body: BlocBuilder<TvshowDetailBloc, TvshowStateBloc>(
          builder: (context, state) {
        if (state is TvshowLoading) {
          return Center(child: CircularProgressIndicator());
        } else if (state is TvshowDetailState) {
          return SafeArea(
            child: DetailContent(
              state.tvhsow,
              moviesRecommendation,
              isAddedToWatchlist,
            ),
          );
        } else if (state is TvshowsError) {
          return Center(
            child: Text(state.message),
          );
        } else {
          return Center(
            child: Text('No Movies Data'),
          );
        }
      }),
    );
  }
}

class DetailContent extends StatelessWidget {
  final TvshowDetail tvshow;
  final List<Tvshow> recommendations;
  final bool isAddedWatchlist;

  DetailContent(this.tvshow, this.recommendations, this.isAddedWatchlist);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Stack(
      children: [
        CachedNetworkImage(
          imageUrl: 'https://image.tmdb.org/t/p/w500${tvshow.posterPath}',
          width: screenWidth,
          placeholder: (context, url) => Center(
            child: CircularProgressIndicator(),
          ),
          errorWidget: (context, url, error) => Icon(Icons.error),
        ),
        Container(
          margin: const EdgeInsets.only(top: 48 + 8),
          child: DraggableScrollableSheet(
            builder: (context, scrollController) {
              return Container(
                decoration: BoxDecoration(
                  color: kRichBlack,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                ),
                padding: const EdgeInsets.only(
                  left: 16,
                  top: 16,
                  right: 16,
                ),
                child: Stack(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 16),
                      child: SingleChildScrollView(
                        controller: scrollController,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              tvshow.name ?? '',
                              style: kHeading5,
                            ),
                            FilledButton(
                              onPressed: () async {
                                if (!isAddedWatchlist) {
                                  context
                                      .read<WatchlistTvshowBloc>()
                                      .add(SaveWatchistTv(tvshow));
                                } else {
                                  context
                                      .read<WatchlistTvshowBloc>()
                                      .add(RemoveWatchlistTvshowEvent(tvshow));
                                }

                                String message = '';
                                final watchlistState =
                                    BlocProvider.of<WatchlistTvshowBloc>(
                                            context)
                                        .state;
                                if (watchlistState is WatchlistTvshowsState) {
                                  message = isAddedWatchlist
                                      ? WatchlistTvshowBloc
                                          .watchlistAddSuccessMessage
                                      : WatchlistTvshowBloc
                                          .watchlistRemoveSuccessMessage;
                                } else {
                                  message = isAddedWatchlist == false
                                      ? WatchlistTvshowBloc
                                          .watchlistAddSuccessMessage
                                      : WatchlistTvshowBloc
                                          .watchlistRemoveSuccessMessage;
                                }

                                if (message ==
                                        WatchlistTvshowBloc
                                            .watchlistAddSuccessMessage ||
                                    message ==
                                        WatchlistTvshowBloc
                                            .watchlistRemoveSuccessMessage) {
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(SnackBar(
                                    content: Text(message),
                                    duration: Duration(milliseconds: 500),
                                  ));
                                  BlocProvider.of<WatchlistTvshowBloc>(context)
                                      .add(WatchlistTvshowStatus(
                                          tvshow.id ?? 0));
                                }
                                // if (!isAddedWatchlist) {
                                //   await Provider.of<TvshowDetailNotifier>(
                                //           context,
                                //           listen: false)
                                //       .addWatchlist(tvshow);
                                // } else {
                                //   await Provider.of<TvshowDetailNotifier>(
                                //           context,
                                //           listen: false)
                                //       .removeFromWatchlist(tvshow);
                                // }

                                // final message =
                                //     Provider.of<TvshowDetailNotifier>(context,
                                //             listen: false)
                                //         .watchlistMessage;

                                // if (message ==
                                //         TvshowDetailNotifier
                                //             .watchlistAddSuccessMessage ||
                                //     message ==
                                //         TvshowDetailNotifier
                                //             .watchlistRemoveSuccessMessage) {
                                //   ScaffoldMessenger.of(context).showSnackBar(
                                //       SnackBar(content: Text(message)));
                                // } else {
                                //   showDialog(
                                //       context: context,
                                //       builder: (context) {
                                //         return AlertDialog(
                                //           content: Text(message),
                                //         );
                                //       });
                                // }
                              },
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  isAddedWatchlist
                                      ? Icon(Icons.check)
                                      : Icon(Icons.add),
                                  Text('Watchlist'),
                                ],
                              ),
                            ),
                            Text(
                              _showGenres(tvshow.genres!),
                            ),
                            Text(
                              _showDuration(tvshow.numberOfEpisodes ?? 0),
                            ),
                            Row(
                              children: [
                                RatingBarIndicator(
                                  rating: tvshow.voteAverage ?? 0 / 2,
                                  itemCount: 5,
                                  itemBuilder: (context, index) => Icon(
                                    Icons.star,
                                    color: kMikadoYellow,
                                  ),
                                  itemSize: 24,
                                ),
                                Text('${tvshow.voteAverage}')
                              ],
                            ),
                            SizedBox(height: 16),
                            Text(
                              'Overview',
                              style: kHeading6,
                            ),
                            Text(
                              tvshow.overview ?? '',
                            ),
                            SizedBox(height: 16),
                            Text(
                              'Recommendations',
                              style: kHeading6,
                            ),
                            Container(
                              height: 150,
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (context, index) {
                                  final tvshow = recommendations[index];
                                  return Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: InkWell(
                                      onTap: () async {
                                        Navigator.pushReplacementNamed(
                                          context,
                                          TvshowDetailPage.ROUTE_NAME,
                                          arguments: tvshow.id,
                                        );
                                      },
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(8),
                                        ),
                                        child: CachedNetworkImage(
                                          imageUrl:
                                              'https://image.tmdb.org/t/p/w500${tvshow.posterPath}',
                                          placeholder: (context, url) => Center(
                                            child: CircularProgressIndicator(),
                                          ),
                                          errorWidget: (context, url, error) =>
                                              Icon(Icons.error),
                                        ),
                                      ),
                                    ),
                                  );
                                },
                                itemCount: recommendations.length,
                              ),
                            ),
                            // Consumer<TvshowDetailNotifier>(
                            //   builder: (context, data, child) {
                            //     if (data.recommendationState ==
                            //         RequestState.Loading) {
                            //       return Center(
                            //         child: CircularProgressIndicator(),
                            //       );
                            //     } else if (data.recommendationState ==
                            //         RequestState.Error) {
                            //       return Text(data.message);
                            //     } else if (data.recommendationState ==
                            //         RequestState.Loaded) {
                            //       return Container(
                            //         height: 150,
                            //         child: ListView.builder(
                            //           scrollDirection: Axis.horizontal,
                            //           itemBuilder: (context, index) {
                            //             final tvshow = recommendations[index];
                            //             return Padding(
                            //               padding: const EdgeInsets.all(4.0),
                            //               child: InkWell(
                            //                 onTap: () {
                            //                   Navigator.pushReplacementNamed(
                            //                     context,
                            //                     TvshowDetailPage.ROUTE_NAME,
                            //                     arguments: tvshow.id,
                            //                   );
                            //                 },
                            //                 child: ClipRRect(
                            //                   borderRadius: BorderRadius.all(
                            //                     Radius.circular(8),
                            //                   ),
                            //                   child: CachedNetworkImage(
                            //                     imageUrl:
                            //                         'https://image.tmdb.org/t/p/w500${tvshow.posterPath}',
                            //                     placeholder: (context, url) =>
                            //                         Center(
                            //                       child:
                            //                           CircularProgressIndicator(),
                            //                     ),
                            //                     errorWidget:
                            //                         (context, url, error) =>
                            //                             Icon(Icons.error),
                            //                   ),
                            //                 ),
                            //               ),
                            //             );
                            //           },
                            //           itemCount: recommendations.length,
                            //         ),
                            //       );
                            //     } else {
                            //       return Container();
                            //     }
                            //   },
                            // ),
                          ],
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.topCenter,
                      child: Container(
                        color: Colors.white,
                        height: 4,
                        width: 48,
                      ),
                    ),
                  ],
                ),
              );
            },
            // initialChildSize: 0.5,
            minChildSize: 0.25,
            // maxChildSize: 1.0,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: CircleAvatar(
            backgroundColor: kRichBlack,
            foregroundColor: Colors.white,
            child: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
        )
      ],
    );
  }

  String _showGenres(List<Genre> genres) {
    String result = '';
    for (var genre in genres) {
      result += genre.name + ', ';
    }

    if (result.isEmpty) {
      return result;
    }

    return result.substring(0, result.length - 2);
  }

  String _showDuration(int runtime) {
    final int hours = runtime ~/ 60;
    final int minutes = runtime % 60;

    if (hours > 0) {
      return '${hours}h ${minutes}m';
    } else {
      return '${minutes}m';
    }
  }
}
