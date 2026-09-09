/// Offline, no-LLM read-aloud scoring.
/// Compares what the student actually said (from the on-device Vosk
/// speech recognizer, which never leaves the phone) against the
/// expected line, using plain word-overlap math — no network call,
/// no AI model, no server.

class ScoreResult {
  final int percent;
  final String verdict; // excellent | good | okay | tryagain
  const ScoreResult(this.percent, this.verdict);
}

List<String> _normalizeWords(String text) {
  final cleaned = text.toLowerCase().replaceAll(RegExp(r"[^a-z0-9'\s]"), " ");
  return cleaned.split(RegExp(r"\s+")).where((w) => w.isNotEmpty).toList();
}

int _longestCommonSubsequence(List<String> a, List<String> b) {
  final m = a.length, n = b.length;
  final dp = List.generate(m + 1, (_) => List<int>.filled(n + 1, 0));
  for (var i = 1; i <= m; i++) {
    for (var j = 1; j <= n; j++) {
      if (a[i - 1] == b[j - 1]) {
        dp[i][j] = dp[i - 1][j - 1] + 1;
      } else {
        dp[i][j] = dp[i - 1][j] > dp[i][j - 1] ? dp[i - 1][j] : dp[i][j - 1];
      }
    }
  }
  return dp[m][n];
}

ScoreResult scoreReading(String expectedText, String heardText) {
  final expected = _normalizeWords(expectedText);
  final heard = _normalizeWords(heardText);

  if (expected.isEmpty || heard.isEmpty) {
    return const ScoreResult(0, "tryagain");
  }

  final expectedBag = <String, int>{};
  for (final w in expected) {
    expectedBag[w] = (expectedBag[w] ?? 0) + 1;
  }
  final heardBag = <String, int>{};
  for (final w in heard) {
    heardBag[w] = (heardBag[w] ?? 0) + 1;
  }

  var overlap = 0;
  expectedBag.forEach((word, count) {
    final other = heardBag[word] ?? 0;
    overlap += count < other ? count : other;
  });
  final diceScore = (2 * overlap) / (expected.length + heard.length);

  final lcs = _longestCommonSubsequence(expected, heard);
  final orderScore = lcs / expected.length;

  final combined = diceScore * 0.6 + orderScore * 0.4;
  final percent = (combined * 100).clamp(0, 100).round();

  String verdict = "tryagain";
  if (percent >= 85) {
    verdict = "excellent";
  } else if (percent >= 65) {
    verdict = "good";
  } else if (percent >= 40) {
    verdict = "okay";
  }

  return ScoreResult(percent, verdict);
}

/// Lighter scoring for the free-practice challenges, which have no single
/// correct answer. Rewards speaking in reasonably full English sentences —
/// still fully offline, still no LLM: just a word-count / variety heuristic.
ScoreResult scoreFreePractice(String heardText) {
  final words = _normalizeWords(heardText);
  if (words.isEmpty) return const ScoreResult(0, "tryagain");
  final uniqueWords = words.toSet().length;
  // Reward both length of attempt and vocabulary variety.
  final lengthScore = (words.length / 18).clamp(0, 1);
  final varietyScore = (uniqueWords / 14).clamp(0, 1);
  final percent = ((lengthScore * 0.6 + varietyScore * 0.4) * 100).clamp(0, 100).round();

  String verdict = "tryagain";
  if (percent >= 85) {
    verdict = "excellent";
  } else if (percent >= 65) {
    verdict = "good";
  } else if (percent >= 40) {
    verdict = "okay";
  }
  return ScoreResult(percent, verdict);
}

int starsForPercent(int percent) {
  if (percent >= 85) return 3;
  if (percent >= 65) return 2;
  if (percent >= 40) return 1;
  return 0;
}

String verdictLabel(String verdict) {
  switch (verdict) {
    case "excellent":
      return "Excellent! 🌟";
    case "good":
      return "Good job! 👍";
    case "okay":
      return "Okay, keep trying! 💪";
    default:
      return "Try again! 🔁";
  }
}
