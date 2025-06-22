// lib/constants/mock_data.dart

final List<Map<String, String>> storyUsers = [
  {'name': 'Saleh', 'image': 'assets/images/Profile.png'},
  {'name': 'Edilson', 'image': 'assets/images/Edison.png'},
  {'name': 'Afrim', 'image': 'assets/images/Afrim.png'},
  {'name': 'Eduardo', 'image': 'assets/images/Eduardo.png'},
  {'name': 'Edi', 'image': 'assets/images/Eduaardo1.png'},
  {'name': 'Afrima', 'image': 'assets/images/Afrim.png'},
  {'name': 'Eduardon', 'image': 'assets/images/Eduardo.png'},
  {'name': 'Educa', 'image': 'assets/images/Eduaardo1.png'},
];

final List<Map<String, dynamic>> events = [
  {
    'title': 'Graduation Ceremony',
    'subtitle': 'The graduation ceremony is also sometimes called...',
    'seen': 8,
    'icon': 'assets/icons/LogoG.png',
    'groupImage': 'assets/icons/Avatars.png',
  },
  {
    'title': 'Photography Ideas',
    'subtitle': 'Reflections. Reflections work because they can create...',
    'seen': 11,
    'icon': 'assets/icons/Camera.png',
    'groupImage': 'assets/icons/Avatars2.png',
  }
];

final List<Map<String, dynamic>> posts = [
  {
    'user': 'Sepural Gallery',
    'userImage': 'assets/images/Edison.png',
    'time': '15h',
    'caption': '',
    'image': 'https://picsum.photos/id/1003/400/250',
    'comments': 3,
    'shares': 17,
    'likes': 9,
    'extraImage': 'assets/images/Like1.png',
    'commentList': []
  },
  {
    'user': 'Prothinidi Thomas',
    'userImage': 'assets/images/Eduardo.png',
    'time': '2d',
    'caption':
        "If you think adventure is dangerous, try routine, it’s lethal Paulo Coelho! Good morning all friends.",
    'image': 'https://picsum.photos/id/1011/400/250',
    'extraImage': 'assets/images/Like2.png',
    'comments': 3,
    'shares': 5,
    'likes': 10,
    'commentList': [
      {
        'user': 'Swapan Bala',
        'userImage': 'assets/images/Afrim.png',
        'text': 'Looks amazing and breathtaking. Been there, beautiful!',
        'replies': [
          {
            'user': 'Whitechapel Gallery',
            'userImage': 'assets/images/Edison.png',
            'text': 'Thank you @Swapan Bala',
          },
          {
            'user': 'Bijoy',
            'userImage': 'assets/images/Eduardo.png',
            'text': 'Another follow up!',
          },
        ]
      },
      {
        'user': 'Swapan Bala',
        'userImage': 'assets/images/Afrim.png',
        'text': 'Looks amazing and breathtaking. Been there, beautiful!',
        'replies': [
          {
            'user': 'Whitechapel Gallery',
            'userImage': 'assets/images/Edison.png',
            'text': 'Thank you @Swapan Bala',
          },
          {
            'user': 'Bijoy',
            'userImage': 'assets/images/Eduardo.png',
            'text': 'Another follow up!',
          },
        ]
      }
    ]
  },
];

final List<Map<String, String>> birthdays = [
  {
    'name': 'Edilson De Carvalho',
    'image': 'assets/images/Edison.png',
    'note': 'Birthday today',
  },
];
