class videoData {
  int page;
  int perPage;
  int totalResults;
  String url;
  List<Videos> videos;

  videoData({this.page, this.perPage, this.totalResults, this.url, this.videos});

  videoData.fromJson(Map<String, dynamic> json) {
    page = json['page'];
    perPage = json['per_page'];
    totalResults = json['total_results'];
    url = json['url'];
    if (json['videos'] != null) {
      videos = new List<Videos>();
      json['videos'].forEach((v) {
        videos.add(new Videos.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['page'] = this.page;
    data['per_page'] = this.perPage;
    data['total_results'] = this.totalResults;
    data['url'] = this.url;
    if (this.videos != null) {
      data['videos'] = this.videos.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Videos {
  int id;
  int width;
  int height;
  String url;
  String image;
  int duration;
  Users user;
  List<VideoFiles> videoFiles;
  List<VideoPictures> videoPictures;

  Videos(
      {this.id,
        this.width,
        this.height,
        this.url,
        this.image,
        this.duration,
        this.user,
        this.videoFiles,
        this.videoPictures});

  Videos.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    width = json['width'];
    height = json['height'];
    url = json['url'];
    image = json['image'];
    duration = json['duration'];
    user = json['user'] != null ? new Users.fromJson(json['user']) : null;
    if (json['video_files'] != null) {
      videoFiles = new List<VideoFiles>();
      json['video_files'].forEach((v) {
        videoFiles.add(new VideoFiles.fromJson(v));
      });
    }
    if (json['video_pictures'] != null) {
      videoPictures = new List<VideoPictures>();
      json['video_pictures'].forEach((v) {
        videoPictures.add(new VideoPictures.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['width'] = this.width;
    data['height'] = this.height;
    data['url'] = this.url;
    data['image'] = this.image;
    data['duration'] = this.duration;
    if (this.user != null) {
      data['user'] = this.user.toJson();
    }
    if (this.videoFiles != null) {
      data['video_files'] = this.videoFiles.map((v) => v.toJson()).toList();
    }
    if (this.videoPictures != null) {
      data['video_pictures'] =
          this.videoPictures.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Users {
  int id;
  String name;
  String url;

  Users({this.id, this.name, this.url});

  Users.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['url'] = this.url;
    return data;
  }
}

class VideoFiles {
  int id;
  String quality;
  String fileType;
  int width;
  int height;
  String link;

  VideoFiles(
      {this.id,
        this.quality,
        this.fileType,
        this.width,
        this.height,
        this.link});

  VideoFiles.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    quality = json['quality'];
    fileType = json['file_type'];
    width = json['width'];
    height = json['height'];
    link = json['link'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['quality'] = this.quality;
    data['file_type'] = this.fileType;
    data['width'] = this.width;
    data['height'] = this.height;
    data['link'] = this.link;
    return data;
  }
}

class VideoPictures {
  int id;
  String picture;
  int nr;

  VideoPictures({this.id, this.picture, this.nr});

  VideoPictures.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    picture = json['picture'];
    nr = json['nr'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['picture'] = this.picture;
    data['nr'] = this.nr;
    return data;
  }
}