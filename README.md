# Stanford-MELD-Desconstructed

Calculator code:
```js
methods: {
  calculateResults: function(t) {
      this.originalMeld = this.calculateOriginalMeld(t.creatinine, t.bilirubin, t.inr),
      this.meldNa = this.calculateMeldNa(t.na),
      this.meld3 = this.calculateMeld3(t.gender, t.bilirubin, t.na, t.inr, t.creatinine, t.albumin);
      var e = (.17698 * this.meld3).toFixed(1);
      this.thirtyDayPrediction = 100 * Math.pow(.981, Math.exp(e - 3.56)),
      this.ninetyDayPrediction = 100 * Math.pow(.946, Math.exp(e - 3.56))
  },
  calculateOriginalMeld: function(t, e, n) {
      var r = 9.57 * Math.log(Math.max(1, Math.min(4, t))) + 3.78 * Math.log(Math.max(1, e)) + 11.2 * Math.log(Math.max(1, n)) + 6.43;
      return Math.round(r)
  },
  calculateMeldNa: function(t) {
      var e = this.originalMeld;
      if (this.originalMeld > 11) {
          var n = 137 - Math.min(137, Math.max(t, 125));
          e = this.originalMeld + 1.32 * n - .033 * this.originalMeld * n
      }
      return e
  },
  calculateMeld3: function(t, e, n, r, i, o) {
      return 1.33 * t + 4.56 * Math.log(Math.max(1, e)) + .82 * (137 - Math.min(137, Math.max(n, 125))) - .24 * (137 - Math.min(137, Math.max(n, 125))) * Math.log(Math.max(1, e)) + 9.09 * Math.log(Math.max(1, r)) + 11.14 * Math.log(Math.max(1, Math.min(3, i))) + 1.85 * (3.5 - Math.max(Math.min(o, 3.5), 1.5)) - 1.83 * (3.5 - Math.max(Math.min(o, 3.5), 1.5)) * Math.log(Math.max(1, Math.min(3, i))) + 6
  }
}
```

Mapping the variables correctly:

<!-- Create a table of all the variables in the function and their corresponding values -->

### Original MELD

| Letter | Name |
| --- | --- |
| t | Creatinine |
| e | Bilirubin |
| n | INR |

### MELD-Na

| Letter | Name |
| --- | --- |
| t | Na |

### MELD-3

| Letter | Name |
| --- | --- |
| t | Gender |
| e | Bilirubin |
| n | Na |
| r | INR |
| i | Creatinine |
| o | Albumin |

# SAFE Calculator

```js
calculateResults: function(t) {
    this.touched || (this.touched = !0);
    var e = 2.97 * t.age
      , n = 5.99 * Math.min(t.bmi, 40)
      , r = 62.85 * t.diabetes
      , i = 154.85 * Math.log(Math.max(1, t.ast))
      , o = 58.23 * Math.log(Math.max(1, t.alt))
      , a = 195.48 * Math.log(Math.max(1, t.globulin))
      , s = 141.61 * Math.log(Math.max(1, t.platelets));
    this.safe = Math.round(e + n + r + i - o + a - s - 75)
}
```
