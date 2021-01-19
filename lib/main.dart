import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

void main() => runApp(MyApp());

class RandomWords extends StatefulWidget {
  @override
  createState() {
    return _RandomWordsState();
  }
}

class _RandomWordsState extends State<RandomWords> {
  // Contains the state about certain words and their

  final _biggerFont = TextStyle(fontSize: 16, fontWeight: FontWeight.bold);
  final _suggestions = <WordPair>[];
  final _faves = Set<WordPair>();

  Widget _buildRow(WordPair wp) {
    final isFaved = _faves.contains(wp);
    return Row(children: [
      Text(wp.asPascalCase, style: _biggerFont),
      Material(
          child: IconButton(
              icon: Icon(Icons.favorite,
                  color: isFaved ? Colors.red : Colors.grey),
              onPressed: () {
                setState(() => isFaved ? _faves.remove(wp) : _faves.add(wp));
              })),
      IconButton(
          icon: Icon(Icons.delete),
          onPressed: () => setState(() {
                _suggestions.remove(wp);
                var s = "${wp.asPascalCase} was removed.";
                final bar =
                    SnackBar(content: Text(s), duration: Duration(seconds: 2));
                ScaffoldMessenger.of(context).showSnackBar(bar);
              }))
    ]);
  }

  Widget _buildSuggestions() {
    return ListView.builder(
        padding: EdgeInsets.all(10),
        itemBuilder: (context, i) {
          if (i.isOdd) {
            return Divider(thickness: 1);
          }
          if (i >= _suggestions.length) {
            _suggestions.addAll(generateWordPairs().take(10));
          }
          return _buildRow(_suggestions[i]);
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Startup Name Generator'),
      ),
      body: _buildSuggestions(),
    );
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(title: 'Welcome to Flutter', home: RandomWords());
  }
}
