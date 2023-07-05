class DoctorItem {
  final int position;
  final String name;
  final String iconImage;
  final String description;
  final List<String> images;

  DoctorItem(this.position,
      {required this.name,
      required this.iconImage,
      required this.description,
      required this.images});
}

List<DoctorItem> doctors = [
  DoctorItem(1,
      name: 'Nurse',
      iconImage: 'assets/images/medical.png',
      description: 'Dra. María Alvarado',
      images: [
        'https://cdn.pixabay.com/photo/2013/07/18/10/57/mercury-163610_1280.jpg',
        'https://cdn.pixabay.com/photo/2014/07/01/11/38/planet-381127_1280.jpg',
        'https://cdn.pixabay.com/photo/2015/06/26/18/48/mercury-822825_1280.png',
        'https://image.shutterstock.com/image-illustration/mercury-high-resolution-images-presents-600w-367615301.jpg'
      ]),
  DoctorItem(2,
      name: 'Doctor1',
      iconImage: 'assets/images/medical.png',
      description: "Doctor.",
      images: [
        'https://cdn.pixabay.com/photo/2011/12/13/14/39/venus-11022_1280.jpg',
        'https://image.shutterstock.com/image-photo/solar-system-venus-second-planet-600w-515581927.jpg'
      ]),
  DoctorItem(3,
      name: 'Doctor2',
      iconImage: 'assets/images/medical.png',
      description: "Doctor.",
      images: [
        'https://cdn.pixabay.com/photo/2011/12/13/14/31/earth-11015_1280.jpg',
        'https://cdn.pixabay.com/photo/2011/12/14/12/11/astronaut-11080_1280.jpg',
        'https://cdn.pixabay.com/photo/2016/01/19/17/29/earth-1149733_1280.jpg',
        'https://image.shutterstock.com/image-photo/3d-render-planet-earth-viewed-600w-1069251782.jpg'
      ]),
  DoctorItem(4,
      name: 'Doctor3',
      iconImage: 'assets/images/medical.png',
      description: "Doctor. ",
      images: []),
  DoctorItem(5,
      name: 'Doctor4',
      iconImage: 'assets/images/medical.png',
      description: "Doctor.",
      images: []),
  DoctorItem(6,
      name: 'Doctor5',
      iconImage: 'assets/images/medical.png',
      description: "Doctor.",
      images: []),
  DoctorItem(7,
      name: 'Doctor6',
      iconImage: 'assets/images/medical.png',
      description: "Doctor",
      images: []),
  DoctorItem(8,
      name: 'Doctor7',
      iconImage: 'assets/images/medical.png',
      description: "Doctor",
      images: []),
];
