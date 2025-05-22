#import "../template.typ": *
#import "@preview/tenv:0.1.2": parse_dotenv

#let env = parse_dotenv(read("../.env"))

#show: project.with(
  week: "第4回",
  authors: (
    (name: env.STUDENT_NAME, email: "学籍番号：" + env.STUDENT_ID, affiliation: "所属：情報科学類"),
  ),
  date: "2025 年 5 月 16 日",
)

#show math.equation: set text(font: ("New Computer Modern Math", "Noto Serif", "Noto Serif CJK JP"))

== 課題 1

+ $i = j$ のとき

  $
  lambda_i (x_j)
  &= product_(1 <= m <= t \ m != i) (x_j - x_m) / (x_i - x_m) mod p \
  &= product_(1 <= m <= t \ m != i) (x_j - x_m) / (x_j - x_m) mod p \
  &= product_(1 <= m <= t \ m != i) 1 mod p \
  &= 1 \
  $

+ $i != j$ のとき

  $
  lambda_i (x_j)
  &= product_(1 <= m <= t \ m != i) (x_j - x_m) / (x_i - x_m) mod p \
  &= (x_j - x_j) / (x_i - x_j) times product_(1 <= m <= t \ m != i \ m != j) (x_j - x_m) / (x_i - x_m) mod p \
  &= 0 \
  $

== 課題 2

$p = 11, T = 3, lambda_t = 5$ のとき、

$
S = 3 + 5 f(x_t) mod 11
$

#let f = (x) => calc.rem(3 + 5 * x, 11)

が成り立つ。$f(x_t), S$ の取り得る組は、

#align(center)[
  #table(
    stroke: (x, y) => {
      if x > 0 {
        (left: 0.7pt + black)
      }
      if y == 0 {
        (bottom: 0.7pt + black)
      }
    },
    columns: 12,
    inset: 10pt,
    align: horizon + center,
    [$f(x_t)$],
    ..range(0, 11).map(v => [$#v$]),
    [$S$],
    ..range(0, 11).map(v => [$#f(v)$]),
  )
]

== 課題 3

条件より、

$
s equiv f(0) (mod q)
$

Lagrange 補間の係数

$
lambda_k = product^(t)_(j = 1 \ j != k) (-i)/(i_k - i_j) (mod q)
$

は、「点 $(i_k, f(i_k))$ だけを使って $x = 0$ での値を再現する重み」になっている。
よって、

$
f(0) equiv sum_(k=1)^t lambda_k f(k) (mod q)
$

また、

$
(C_1^(f(k)))^(lambda_k) mod p = (g^(r f(k)))^(lambda_k) mod p = g^(r lambda_k f(k)) mod p
$

である。ここでこの式を $k = 1, ..., t$ で掛け合わせたものを考えると、

$
product_(k = 1)^t g^(r lambda_k f(k)) mod p
= g^(r sum_(k=1)^t lambda_k f(k)) mod p
= g^(r s)
= C_1^s
$
