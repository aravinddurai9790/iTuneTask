import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import '../viewmodels/media_viewmodel.dart';
import '../widgets/media_grid.dart';
import '../widgets/media_list.dart';

class SearchPage extends ConsumerStatefulWidget {
  const SearchPage({super.key});

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends ConsumerState<SearchPage> {
  final TextEditingController _controller = TextEditingController();
  bool _isGridView = true;
  String? _connectionStatus;
  final Connectivity _connectivity = Connectivity();

  @override
  void initState() {
    super.initState();
    _checkConnectivity();
  }

  Future<void> _checkConnectivity() async {
    ConnectivityResult result;
    try {
      result = await _connectivity.checkConnectivity();
    } catch (e) {
      result = ConnectivityResult.none;
    }

    setState(() {
      _connectionStatus = _getStatusFromResult(result);
    });
  }

  String _getStatusFromResult(ConnectivityResult result) {
    switch (result) {
      case ConnectivityResult.wifi:
        return 'Connected to WiFi';
      case ConnectivityResult.mobile:
        return 'Connected to Mobile Data';
      case ConnectivityResult.none:
        return 'No Internet Connection';
      default:
        return 'Unknown Connection Status';
    }
  }

  void _onSearch() async {
    await _checkConnectivity();
    if (_connectionStatus == 'No Internet Connection') {
      _showNoConnectionDialog();
    } else {
      ref.read(mediaViewModelProvider.notifier).searchMedia(_controller.text);
    }
  }

  void _showNoConnectionDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('No Internet Connection'),
          content: const Text('Please check your internet connection and try again.'),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final mediaState = ref.watch(mediaViewModelProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('iTunes Media Search'),
        actions: [
          IconButton(
            icon: Icon(_isGridView ? Icons.view_list : Icons.grid_view),
            onPressed: () {
              setState(() {
                _isGridView = !_isGridView;
              });
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _controller,
              decoration: InputDecoration(
                labelText: 'Search',
                suffixIcon: IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: _onSearch,
                ),
              ),
            ),
          ),
          Expanded(
            child: mediaState.when(
              data: (mediaList) => _isGridView
                  ? MediaGrid(mediaList: mediaList)
                  : MediaList(mediaList: mediaList),
              loading: () => const Center(child: Text("No media found")),
              error: (error, _) => Center(child: Text('Error: $error')),
            ),
          ),
        ],
      ),
    );
  }
}
