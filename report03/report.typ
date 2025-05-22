#import "../template.typ": *
#import "@preview/tenv:0.1.2": parse_dotenv

#let env = parse_dotenv(read("../.env"))

#show: project.with(
  week: "第3回",
  authors: (
    (name: env.STUDENT_NAME, email: "学籍番号：" + env.STUDENT_ID, affiliation: "所属：情報科学類"),
  ),
  date: "2025 年 5 月 9 日",
)

#show math.equation: set text(font: ("New Computer Modern Math", "Noto Serif", "Noto Serif CJK JP"))

== 問題 1

$
y = g^x mod p = 6^9 mod 41 = 19
$

== 問題 2

ElGamal では、

$
s = c_1^x mod p, 
space
m = c_2 dot s^(-1) mod p
$

ここで、$s = 29^9 mod 41 = 30$

拡張ユークリッド法により、

$
30^(-1) mod 41 = 26
$

よって、平文 $m$ は

$
m = 27 times 26 mod 41 = 702 mod 41 = 5
$

== 問題 3

すでに提示されている暗号文

$
E_(k_0_x) ( E_(k_0_y) ( k_(w 0) ) ), space E_(k_0_x) ( E_(k_1_y) ( k_(w 1) ) )
$

は表の2行 $(0, 0)$ と $(0, 1)$ に対応している。

残り2行について同じ規則を用いれば

$(x, y) = (1, 0), space w = 1$ については

$
E_(k_1_x) (E_(k_0_y) (k_(w 1)))
$

$(x, y) = (1, 1), space w = 0$ については

$
E_(k_1_x) (E_(k_1_y) (k_(w 0)))
$

== 問題 4

ステップ (a) では、Sender は 4 個の平文

$
m_(00), space m_(01) space m_(10), space m_(11) space (c = (c_1 c_0) in { 00, 01, 10, 11 })
$

をそれぞれ2段暗号化で送信している。

受信者が $m_(c_1, c_0)$ だけを復号するには

- 鍵 $k_(c_1 x)$
- 鍵 $k_(c_0 y)$

のちょうど 2 個があれば十分であり、ほかのメッセージには 2 個そろわないので解読できない。

ステップ (b) で行う2回の 1-out-of-2 OT では、

1回目では Sender は $(k_(0 x), k_(1 x))$ の2つのメッセージを用意し、
Receiver は上位ビット $c_1$ を指定して $k_(c_1 x)$ を鍵として受け取る。

2回目では Sender は $(k_(0 y), k_(1 y))$ の2つのメッセージを用意し、
Receiver は上位ビット $c_0$ を指定して $k_(c_0 y)$ を鍵として受け取る。

OT の性質により、Receiver は自分の選択ビット以外をSenderに漏らさずに欲しい鍵だけを得る。
また、Senderはどちらの鍵が渡ったかわからない。

ステップ (c) での復号においては、

Receiver は OT で得た2個の鍵を使い

$
E_(k_(c_1 x)) ( E_(k_(c_0 y)) (m_(c_1 c_0)) )
-->_(k_(c_1 x)) E_(k_(c_0 y)) (m_(c_1 c_0))
-->_(k_(c_0 y)) m_(c_1 c_0)
$

を取得する。
ほかの 3 通の暗号文については 2 鍵そろわず、依然として 1 段暗号が残るため内容は分からない。

以上により、

- 第1OT: 送信メッセージ $(k_(0 x), k_(1 x))$、選択ビットは Receiver の上位ビット $c_1$
- 第2OT: 送信メッセージ $(k_(0 y), k_(1 y))$、選択ビットは Receiver の上位ビット $c_0$

これにより、Receiver は望む 1 つの平文 $m_(c_1 c_0)$ だけを得て、
Sender に自分の選択 $c$ を知られない 1-out-of-4 OT が実現できる。
