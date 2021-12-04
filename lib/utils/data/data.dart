import 'package:flutter/material.dart';
import 'package:loveria/models/models.dart';

const Profile profile = Profile(
  name: 'John Doe',
  profileImageUrl:
      'https://images.unsplash.com/photo-1520341280432-4749d4d7bcf9?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=634&q=80',
  age: '22',
  college: 'Stanford University',
  media: [
    "https://images.unsplash.com/photo-1604004555489-723a93d6ce74?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=634&q=80",
    "https://images.unsplash.com/photo-1516522973472-f009f23bba59?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=634&q=80",
    "https://images.unsplash.com/photo-1515468381879-40d0ded81044?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=634&q=80",
    "https://images.unsplash.com/photo-1516888023223-b9c385b94153?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=634&q=80",
    "https://images.unsplash.com/photo-1514091536534-d2c38c033445?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=634&q=80",
    "https://images.unsplash.com/photo-1516195851888-6f1a981a862e?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=634&q=80",
  ],
);

const streamBackground =
    "https://images.unsplash.com/photo-1635346779624-aba5ccb7ebca?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=634&q=80";

const List<User> users = [
  User(
    name: 'Mary',
    profileImageUrl:
        'https://images.unsplash.com/photo-1516522973472-f009f23bba59?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=634&q=80',
    age: '17',
    college: 'Stanford University',
  ),
  User(
    name: 'Chieko',
    profileImageUrl:
        'https://images.unsplash.com/photo-1525786210598-d527194d3e9a?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=634&q=80',
    age: '17',
    college: 'University of Oxford',
  ),
  User(
    name: 'Emma',
    profileImageUrl:
        'https://images.unsplash.com/flagged/photo-1556138740-9ea22b0db0f5?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=634&q=80',
    age: '21',
    college: 'University of Callifornia',
  ),
  User(
    name: 'Elina',
    profileImageUrl:
        'https://images.unsplash.com/photo-1617251997846-b6139ae96682?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=634&q=80',
    age: '20',
    college: 'Harvard University',
  ),
  User(
    name: 'Jenifer',
    profileImageUrl:
        'https://images.unsplash.com/photo-1525134479668-1bee5c7c6845?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=634&q=80',
    age: '19',
    college: 'Imperial College London',
  ),
  User(
    name: 'Mary',
    profileImageUrl:
        'https://images.unsplash.com/photo-1574163959954-b9adbc5a6aea?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=634&q=80',
    age: '17',
    college: 'University of Oxford',
  ),
  User(
    name: 'Jenifer',
    profileImageUrl:
        'https://images.unsplash.com/photo-1503185912284-5271ff81b9a8?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=634&q=80',
    age: '20',
    college: 'University of Cambridge',
  ),
];

final List adds = [
  {
    'icon': Icons.whatshot,
    'color': Colors.indigo,
    'title': "Get matches faster",
    'subtitle': "Boost your profile once a month",
  },
  {
    'icon': Icons.favorite,
    'color': Colors.lightBlueAccent,
    'title': "more likes",
    'subtitle': "Get free rewindes",
  },
  {
    'icon': Icons.star_half,
    'color': Colors.amber,
    'title': "Increase your chances",
    'subtitle': "Get unlimited free likes",
  },
  {
    'icon': Icons.location_on,
    'color': Colors.purple,
    'title': "Swipe around the world",
    'subtitle': "Passport to anywhere with ashiqui",
  },
  {
    'icon': Icons.vpn_key,
    'color': Colors.orange,
    'title': "Control your profile",
    'subtitle': "highly secured",
  }
];
