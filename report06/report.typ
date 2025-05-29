#import "../template.typ": *
#import "@preview/tenv:0.1.2": parse_dotenv

#let env = parse_dotenv(read("../.env"))

#show: project.with(
  week: "第6回",
  authors: (
    (name: env.STUDENT_NAME, email: "学籍番号：" + env.STUDENT_ID, affiliation: "所属：情報科学類"),
  ),
  date: "2025 年 5 月 29 日",
)

#show math.equation: set text(font: ("New Computer Modern Math", "Noto Serif", "Noto Serif CJK JP"))

== 課題 1

余事象（$23$ 人が集まるとき、全員の誕生日が相異なる）の確率を考える。

このとき、$("二人目が一人目と異なる確率") times ("三人目が最初の二人と異なる確率") times dots.c$ で求めることができるから、

$
364/365 times 363/365 times dots.c times (365 - (23 - 1))/365
= (space_(365) P_(23)) / 365^(23)
$

よって、もとの確率は、

$
1 - (space_(365) P_(23)) / 365^(23) approx 0.507
$

となり、確かに $23$ 人集まると、確率 $1\/2$ 程度で同じ誕生日の組が存在する。

== 課題 2

$"ctr" <- C_0$ とする。

その後、各ブロック ($i = 1 dots t$) に対して以下の操作を繰り返す。

$
m_i <- C_i xor "Enc"(K; "ctr" + i) space (1 <= i <= t)
$

その後、連結して $(m_1, dots , m_t)$ を返す。
