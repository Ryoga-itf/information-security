#import "../template.typ": *
#import "@preview/tenv:0.1.2": parse_dotenv

#let env = parse_dotenv(read("../.env"))

#show: project.with(
  week: "第2回",
  authors: (
    (name: env.STUDENT_NAME, email: "学籍番号：" + env.STUDENT_ID, affiliation: "所属：情報科学類"),
  ),
  date: "2025 年 5 月 2 日",
)

#show math.equation: set text(font: ("New Computer Modern Math", "Noto Serif", "Noto Serif CJK JP"))

== 問題 1

まず、

$
n = p q = 7 dot 11 = 77 \
phi(n) = (p - 1)(q - 1) = 6 dot 10 = 60
$

公開鍵 $e = 7$ に対して秘密鍵 $d$ は $7d equiv 1 (mod 60)$ を満たすように求めればよく、

拡張ユークリッドの互助法により係数を求めると、

$
60 &= 7 dot 8 + 4 \
7 &= 4 dot 1 + 3 \
4 &= 3 dot 1 + 1 \
3 &= 1 dot 3 + 0 \
$

逆向きに代入して

$
1
&= 4 - 3 dot 1 \
&= 4 - (7 - 4 dot 1) dot 1 \
&= 4 dot 2 - 7 \
&= (60 - 7 dot 8) dot 2 - 7 \
&= 60 dot 2 - 7 dot 17
$

よって $7 dot -17 equiv 1 (mod 60)$ であり、これが求める $d$ は、

$
d equiv -17 equiv 43 (mod 60)
$

より、$d = 43$

== 問題 2

暗号文 $C = 31$ を復号するには、$M = C^d mod n = 31^43 mod 77$ を計算すればよい。

中国剰余定理を用いる用いることにより、

- $31 mod 7 = 3$、$phi(7) = 6$ より、

  $3^43 mod 7 = 3^(43 mod 6) mod 7 = 3^1 mod 7 = 3$

- $31 mod 11 = 9$、$phi(11) - 10$ より、

  $9^43 mod 11 = 9^(43 mod 10) mod 11 = 9^3 mod 11 = 3$

となるので、

$
M &equiv 3 (mod 7) \
M &equiv 3 (mod 11)
$

よって、$M = 3$

== 問題 3

法は $11$ で素数であるから、フェルマーの小定理により、

$
7^(11 - 1) mod 11 = 7^10 mod 11 = 1
$

また、

#let n = 833173
#let p = calc.div-euclid(833173, 10)
#let q = 833173 - 10 * p

$
833173 = 10 dot #p + #q
$

と表すことができるから、

$
7^#n mod 11
&= 7^(10 dot #p + #q) mod 11 \
&= ((7^10 mod 11)^#p dot 7^#q) mod 11 \
&= 7^#q mod 11 \
&= #calc.pow(7, q) mod 11 \
&= #calc.rem(calc.pow(7, q), 11)
$

== 問題 4

公開鍵である $n$ は素数 $p, q$ を用いて、$n = p q$ と表される。

$n$ が偶数のとき、#footnote[このような脆弱な $p, q$ の選び方は普通されないが便宜上考えることとする。]
$p, q$ は素数であり、$2$ は唯一の偶数の素数であるから、$p, q$ の少なくとも一方は $2$ である。

この場合、RSA の秘密鍵を知ることが可能であるため、もちろん $M/2$ の暗号文を得ることができる。

$n$ が奇数のとき、$2$ と $n$ は互いに素であるため、法 $n$ における $2$ の逆元 ($2^(-1) mod n$) が存在する。
また、この逆元を $i$ とおく。

$M/2$ の暗号文を $C$ とすると、$C = (M/2)^e mod n$ であるから、

$
C'
&= M^e mod n \
&= (M/2 dot 2)^e mod n \
&= (M/2)^e dot 2^e mod n \
&= C dot 2^e mod n
$

よって、

$
C' dot i^e mod n = C
$

以上より、平文 $M/2$ の暗号文を得ることができる。
