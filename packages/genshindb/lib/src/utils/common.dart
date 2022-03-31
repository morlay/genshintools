int levelUpCostFor(List<int> rng, int current, int to) {
  var n = rng.length;
  if (to > n) {
    to = n;
  }

  var t = 0;

  for (var toLevel = current + 1; toLevel <= to; toLevel++) {
    t = t + rng[toLevel - 1];
  }

  return t;
}
