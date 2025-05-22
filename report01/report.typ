#import "../template.typ": *
#import "@preview/tenv:0.1.2": parse_dotenv

#let env = parse_dotenv(read("../.env"))

#show: project.with(
  week: "第1回",
  authors: (
    (name: env.STUDENT_NAME, email: "学籍番号：" + env.STUDENT_ID, affiliation: "所属：情報科学類"),
  ),
  date: "2025 年 4 月 25 日",
)

#show math.equation: set text(font: ("New Computer Modern Math", "Noto Serif", "Noto Serif CJK JP"))

== 問題 1

ユークリッドの互助法を用いることにより、

$
gcd(2106, 5473)
&= gcd(2106, 5473 mod 2106) \
&= gcd(2106, 1261) \
&= gcd(1261, 2106 mod 1261) \
&= gcd(1261, 845) \
&= gcd(845, 1261 mod 845) \
&= gcd(845, 416) \
&= gcd(416, 845 mod 416) \
&= gcd(416, 13) \
&= 13
$

== 問題 2

まず、$143 = 11 times 13$ であり、$gcd(17, 143) = 1$ なので逆元が存在。

拡張ユークリッドの互助法により係数を求めると、

$
143 &= 17 times 8 + 7, \
17 &= 7 times 2 + 3, \
7 &= 3 times 2 + 1, \
3 &= 1 times 3 + 0
$

逆向きに代入して

$
1
&= 7 - 3 times 2 \
&= 7 - (17 - 7 times 2) times 2 \
&= 5 times 7 - 2 times 17 \
&= 5 (143 - 17 times 8) - 2 times 17 \
&= 5 times 143 - 42 times 17
$

よって、

$
-42 times 17 equiv 1 (mod 143) ==> 101 times 17 equiv 1 (mod 143)
$

したがって、

$
17^(-1) mod 143 = 101
$

#pagebreak(weak: true)

また、$x^(-1) mod 143$ が存在しない整数 $x$ の条件について考える。

一般に、整数 $x$ が法 $m$ の下で逆元を持つための必要十分条件は、

$
gcd(x, m) = 1
$

である。ここで、$m = 143 = 11 times 13$ のとき、

$
gcd(x, 143) > 1 <==> 11 | x "または" 13 | x
$

となるから、逆元が存在しないのは「$x$ が $11$ または $13$ の倍数である整数」である。

== 問題 3

$a$ は奇数であるから、整数 $n$ を用いて $a = 2n + 1$ と表せる。

ここで、

$
a^2
&= (2n + 1)^2 \
&= 4n^2 + 4n + 1 \
&= 4n(n+1) + 1
$

である。

連続する整数であるから、$n(n+1)$ は $2$ の倍数である。

よって、

$
a^2 = 4n(n+1) + 1 equiv 1 (mod 8)
$
