#import "../template.typ": *
#import "@preview/tenv:0.1.2": parse_dotenv

#let env = parse_dotenv(read("../.env"))

#show: project.with(
  week: "第5回",
  authors: (
    (name: env.STUDENT_NAME, email: "学籍番号：" + env.STUDENT_ID, affiliation: "所属：情報科学類"),
  ),
  date: "2025 年 5 月 23 日",
)

#show math.equation: set text(font: ("New Computer Modern Math", "Noto Serif", "Noto Serif CJK JP"))

== 課題 1

=== (1)

- $S_1 = 7$
- $S_2 = 1$
- $S_3 = 6$

=== (2)

$
g(x)
&= g_1(x) + g_2(x) + g_3(x) \
&= (4x + 1 + 7x + 0 + 5x + 1) mod 11 \
&= (16x + 2) mod 11
$

=== (3)

- $g(1) = (16 dot 1 + 2) mod 11 = 18 mod 11 = 7 = S_1$
- $g(2) = (16 dot 2 + 2) mod 11 = 34 mod 11 = 1 = S_2$
- $g(3) = (16 dot 3 + 2) mod 11 = 50 mod 11 = 6 = S_3$

== 課題 2

本課題は Paillier 暗号の復号処理により、正しく復号できることを確認するものである。

Paillier 暗号の復号処理は

$
m <- ((c^lambda  - 1) / n mod n) slash ((g^lambda - 1) / n mod n) mod n
$

で計算される。

$r^(lambda n) mod n^2 = 1$ の性質を用いることにより、

$
c^lambda mod n^2
= (g^m r^n)^lambda mod n^2
= g^(lambda m) (r^lambda n) mod n^2
= g^(lambda m) mod n^2
$

ここで $g = 1 + k n mod n^2$ であるから、二項定理により、

$
(1 + k n)^(m lambda) = sum_(i=0)^(m lambda) binom(m lambda, i) (k n)^i
$

これは、

- $i = 0$ であるとき、$1$
- $i = 1$ であるとき、$binom(m lambda, 1) k n = m lambda k n$
- $i >= 2$ であるとき、すべて $n^2$ 以上の次数

となる。よって、

$
c^lambda mod n^2 = (1 + k n)^(m lambda) mod n^2 = 1 + m lambda k n
$

同様に、$g^lambda = (1 + k n)^lambda$ に対して考えれば

$
g^lambda mod n^2 = (1 + k n)^(lambda) mod n^2 = 1 + lambda k n
$

よって、

$
((c^lambda  - 1) / n mod n) slash ((g^lambda - 1) / n mod n) mod n
&= ((1 + m lambda k n  - 1) / n mod n) slash ((1 + lambda k n - 1) / n mod n) mod n \
&= (m lambda k mod n) / (lambda k mod n) mod n \
&= m
$

よって平文を得ることができる。
