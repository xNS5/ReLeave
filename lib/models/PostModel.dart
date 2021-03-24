class Post {
  final String title;
  final String selftext;
  final String author;
  final String url;

  Post({
    this.title,
    this.selftext,
    this.author,
    this.url,
  });


  factory Post.fromJson(Map<String, dynamic> json) => Post(
    title: json['title'],
    selftext: json['selftext'],
    author: json['author'],
    url: json['url'],
  );

  Map<String, dynamic> toJson() =>{
    'title': this.title,
    'selftext': this.selftext,
    'author': this.author,
    'url': this.url,
  };
}