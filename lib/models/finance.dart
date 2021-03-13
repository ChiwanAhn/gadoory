class Finance {
  double today;
  double yesterday;

  double get diff => today - yesterday;

  double get diffRate => ((today / yesterday) - 1) * 100;
}
