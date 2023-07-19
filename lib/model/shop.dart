
class Shop {
  const Shop({required this.name, required this.tags, required this.evaluation});

  final String name;
  final List<String> tags;
  final Evaluation evaluation;
}

class Evaluation{
  Evaluation(this.meat, this.fish, this.vegetable);
  int meat = 0;
  int fish = 0;
  int vegetable = 0;
}
