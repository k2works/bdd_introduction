ビヘイビア駆動開発入門
===================

# 目的 #
ビヘイビア駆動開発(BDD)習得

# 前提 #
| ソフトウェア   | バージョン   | 備考        |
|:---------------|:-------------|:------------|
| OS X           |10.8.5        |             |
| ruby           |2.1.1         |             |
| rvm            |1.24.0        |             |
| rbricks        |2.0.5         |             |
| heroku-toolbelt |3.6.0        |             |
| rspec          |2.14.8        |             |
| cucumber       |1.3.14        |             |

+ [Herokuにサインアップしている](https://id.heroku.com/signup/devcenter)
+ [Heroku Toolbeltをインストールしている](https://toolbelt.heroku.com/)
+ [LiveReloadをChromeにインストールしている](https://chrome.google.com/webstore/detail/livereload/jnihajbhpnppcggbcgedagnkighmdlei)

# 構成 #
+ [ビヘイビア駆動開発(BDD)とは](#1)
+ [セットアップ](#2)
+ [サンプル実行](#3)
+ [日本語シナリオ](#4)

# 詳細 #

## <a name="1">ビヘイビア駆動開発(BDD)とは</a> ##

### テスト駆動開発(TDD)からビヘイビア駆動開発(BDD)へ

TDD・・・オブジェクトが何をするかではなく、オブジェクトが何であるか。構造に焦点を合わせる。

<a href="https://www.flickr.com/photos/k2works/13635473944" title="TDD by Katuyuki Kakigi, on Flickr"><img src="https://farm3.staticflickr.com/2938/13635473944_bb1b6b7d38_n.jpg" width="319" height="320" alt="TDD"></a>

TDD概念図

BDD・・・オブジェクトが何をするか。構造ではなく振る舞いに焦点を合わせる。

<a href="https://www.flickr.com/photos/k2works/13634941835" title="BDD by Katuyuki Kakigi, on Flickr"><img src="https://farm8.staticflickr.com/7176/13634941835_7bcc39f7f4_n.jpg" width="320" height="310" alt="BDD"></a>

BDD概念図


### BDDの概要
>BDDとは、ステークホルダーの視点に立って振る舞いを説明することにより、アプリケーションを実装するための手法である。

>『The RSpec Book』

### BDDサイクル  
1. Cucmberで始める
  1. １つのシナリオに焦点を合わせる
  1. 失敗するステップ定義を各
  1. RSpecに進む
    1. 失敗するサンプルを書く
    1. サンプルを失敗させる
    1. リファクタリング
    1. ステップが成功するまで1-3を繰り返す
  1. リファクタリング
  1. シナリオが成功するまで1-5を繰り返す
1. シナリオが成功したら1に戻る


### BDDの原則
+ 十分といったら十分
+ ステークホルダーに価値をもたらす
+ すべては振る舞いから

### プロジェクトのインセプション
1. すべてのステークホルダーを集めて、プロジェクトのビジョンまたは目的を定める。
1. 定めたことを理解するためそのビジョンを持つコアステークホルダーと協力し、結果または目標を洗い出す。洗い出す対象はSMARTであることが望ましい。
1. 洗いだしたことを達成するソフトウエアで実行する必要があることを、フィーチャーセットまたはテーマ（レポートや顧客の登録など）として表現する。
1. 最後にこれらのテーマを構成する特定のフィーチャやストーリーについて話し合う

BDDは主にこの最後のレベルで適用される。また、ステークホルダーやビジネスアナリストといった用語は、個人ではなく役割を表す。

>SMARTな結果

>SMARTは、ある種の特性を持つ結果または目標を表現するために使われる頭文字です。その特性とは、Specific(具体的)、Measurable(測定可能)、Achievable(達成可能)、Relevant(適切)、Timeboxed(期限付き)の５つです。

>『The RSpec Book』

### リリースサイクル

1. ステークホルダーがビジネスアナリストと話し合い要件をフィーチャとして表現する。必要があればフィーチャを検証可能な小さなストーリーに分解する。
1. ステークホルダーとビジネスアナリストがテスト担当者と協力してストーリーの範囲を決定する。各ストーリーはどのように完結するかを意識する。
1. プログラマがストーリーの実装にとりかかる前の最後のタスクとして必要に応じてシナリオを自動化する。
1. 開発者はRSpecと「Coding by Example」に基づいてシナリオを実際に動かす。
  1. 必要な振る舞いを説明するサンプルコードを記述する
  1. そのサンプルを動作させるためのコードを実装する
  1. リファクタリングをおこなう
1. このシナリオを動かすのに十分なソフトウエアを完成させ、他のシナリオが動くようになるまでこの作業を繰り返す。
1. 一周して元に戻り、実際に動くシナリオをステークホルダーに見てもらいストーリーを完成させる。

BDDのもっとも重要な特徴の１つはシナリオを自動化するのが簡単で、しかもステークホルダーにとって理解しやすいこと。
これらのシナリオを定義し、自動化するのがCucumberが担当する。

>ストーリーイン、フィーチャアウト

>フィーチャは凝集された価値をステークホルダーに提供するものであり、ストーリーはほんの数日で実装できる機能を見てもらうためのものです。
>したがって、ステークホルダーにとって意味があるのはフィーチャのほうであり、フィーチャを提供するチームにとって意味があるのはストーリーのほうです。

>『The RSpec Book』

### ストーリーの構造
+ タイトル  
  どのストーリーについて説明するのかを明確にする。
+ ナラティブ  
  最低でもこのストーリーの**ステークホルダー**、ステークホルダーが望んでいる**フィーチャ**の説明、およびステークホルダーがそれを望んでいる理由を明らかにする。そしてこの振る舞いによりどのような**利益**を手にするのかを明らかにする。
+ 受け入れ基準  
  BDDの受け入れ基準は個々の**ステップ**で構成されるいくつかの**シナリオ**として定義される。

ナラティブの例
```
<ステークホルダー>として
<フィーチャ>をしたい
なぜなら<利益>だからだ
```

+ ビジネスアナリストはステークホルダーの使う言葉(ドメイン用語)をストーリーに使うことで全員が同じ用語を使うようにしなければならない
+ ドメイン用語はオブジェクト、メソッド、変数などコードベースにそのまま含まれる
+ ストーリーの「完了」を定義する受け入れい基準となるシナリオにおいて重要なのはステークホルダーが行うのとまったく同じ方法でアプリケーションとやりとりすること

### まとめ
+ BDDはTDDの枠組みを変化させ、本格的なアジャイル開発を理解しやすくする試みから発展した手法。  
+ BDDには３つの原則がある
  + 十分といったら十分
  + ステークホルダーに価値をもたらす
  + すべては振る舞いから


+ BDDのストーリーとシナリオは、自動化しやすく、ステークホルダーが明確に理解できることに重点を置いてた上で、一連の作業モデルをサポートするように設計されている。

## <a name="2">セットアップ</a> ##

[RailsBricks入門参照](https://github.com/k2works/rails_bricks_introduction)

[RailsBricks入門(BDD適用編)参照](https://github.com/k2works/rails_bricks_bdd)

## <a name="3">サンプル実行</a>
### Hello RSpec

spec/greeter_spec.rb

```Ruby
describe "RSpec Greeter" do
  it "should say 'Hello RSpec!' when it receives the greet() message" do
    greeter = RSpecGreeter.new
    greeting = greeter.greet
    greeting.should == "Hello RSpec!"
  end
end
```
RSpecの実行

```
$ rspec spec/greeter_spec.rb
F

Failures:

  1) RSpec Greeter should say 'Hello RSpec!' when it receives the greet() message
     Failure/Error: greeter = RSpecGreeter.new
     NameError:
       uninitialized constant RSpecGreeter
     # ./spec/greeter_spec.rb:3:in `block (2 levels) in <top (required)>'

Finished in 0.00073 seconds
1 example, 1 failure

Failed examples:

rspec ./spec/greeter_spec.rb:2 # RSpec Greeter should say 'Hello RSpec!' when it receives the greet() message

```
修正
```Ruby
class RSpecGreeter
  def greet
    "Hello RSpec!"
  end
end

describe "RSpec Greeter" do
  it "should say 'Hello RSpec!' when it receives the greet() message" do
    greeter = RSpecGreeter.new
    greeting = greeter.greet
    expect(greeting).to eq("Hello RSpec!")
  end
end
```

再実行

```
$ rspec spec/greeter_spec.rb
No examples found.


Finished in 0.00007 seconds
0 examples, 0 failures
```

### Hello Cucumber
feature/greeter_says_hello.feature

```
Feature: greeter says hello

  In order to start learning RSpec and Cucumber
  As a reader of The RSpec Book
  I want a greeter to say Hello

  Scenario: greeter says hello
    Given a greeter
    When I send it the greet message
    Then I should see "Hello Cucumber"
```

cucumberの実行

```
$ cucumber features
Using the default profile...
Feature: greeter says hello

  In order to start learning RSpec and Cucumber
  As a reader of The RSpec Book
  I want a greeter to say Hello

  Scenario: greeter says hello         # features/greeter_says_hello.feature:7
    Given a greeter                    # features/greeter_says_hello.feature:8
      Undefined step: "a greeter" (Cucumber::Undefined)
      features/greeter_says_hello.feature:8:in `Given a greeter'
    When I send it the greet message   # features/greeter_says_hello.feature:9
      Undefined step: "I send it the greet message" (Cucumber::Undefined)
      features/greeter_says_hello.feature:9:in `When I send it the greet message'
    Then I should see "Hello Cucumber" # features/greeter_says_hello.feature:10
      Undefined step: "I should see "Hello Cucumber"" (Cucumber::Undefined)
      features/greeter_says_hello.feature:10:in `Then I should see "Hello Cucumber"'

1 scenario (1 undefined)
3 steps (3 undefined)
0m0.350s

You can implement step definitions for undefined steps with these snippets:

Given(/^a greeter$/) do
  pending # express the regexp above with the code you wish you had
end

When(/^I send it the greet message$/) do
  pending # express the regexp above with the code you wish you had
end

Then(/^I should see "(.*?)"$/) do |arg1|
  pending # express the regexp above with the code you wish you had
end
```
feature/step_definitions/greeter_steps.rb

```Ruby
Given(/^a greeter$/) do
  @greeter = CucumberGreeter.new
end

When(/^I send it the greet message$/) do
  @message = @greeter.greet
end

Then(/^I should see "(.*?)"$/) do |arg1|
  @message.should == greeting
end
```

再実行

```
$ cucumber features
Using the default profile...
Feature: greeter says hello

  In order to start learning RSpec and Cucumber
  As a reader of The RSpec Book
  I want a greeter to say Hello

  Scenario: greeter says hello         # features/greeter_says_hello.feature:7
    Given a greeter                    # features/step_definitions/greeter_steps.rb:1
      uninitialized constant CucumberGreeter (NameError)
      ./features/step_definitions/greeter_steps.rb:2:in `/^a greeter$/'
      features/greeter_says_hello.feature:8:in `Given a greeter'
    When I send it the greet message   # features/step_definitions/greeter_steps.rb:5
    Then I should see "Hello Cucumber" # features/step_definitions/greeter_steps.rb:9

Failing Scenarios:
cucumber features/greeter_says_hello.feature:7 # Scenario: greeter says hello

1 scenario (1 failed)
3 steps (1 failed, 2 skipped)
0m0.359s
```
修正

```Ruby
class CucumberGreeter
  def greet
    "Hello Cucumber!"
  end
end

Given(/^a greeter$/) do
  @greeter = CucumberGreeter.new
end

When(/^I send it the greet message$/) do
  @message = @greeter.greet
end

Then(/^I should see "(.*?)"$/) do |greeting|
  @message.should == greeting
end
```

再実行

```
$ cucumber features
Using the default profile...
Feature: greeter says hello

  In order to start learning RSpec and Cucumber
  As a reader of The RSpec Book
  I want a greeter to say Hello

  Scenario: greeter says hello          # features/greeter_says_hello.feature:7
    Given a greeter                     # features/step_definitions/greeter_steps.rb:7
    When I send it the greet message    # features/step_definitions/greeter_steps.rb:11
    Then I should see "Hello Cucumber!" # features/step_definitions/greeter_steps.rb:15

1 scenario (1 passed)
3 steps (3 passed)
0m0.370s
```

一括実行

```
bash-3.2$ rake
/Users/k2works/.rvm/rubies/ruby-2.0.0-p247/bin/ruby -S rspec ./spec/greeter_spec.rb
.

Finished in 0.00141 seconds
1 example, 0 failures
/Users/k2works/.rvm/rubies/ruby-2.0.0-p247/bin/ruby -S bundle exec cucumber  --profile default
Using the default profile...
Feature: greeter says hello

  In order to start learning RSpec and Cucumber
  As a reader of The RSpec Book
  I want a greeter to say Hello

  Scenario: greeter says hello          # features/greeter_says_hello.feature:7
    Given a greeter                     # features/step_definitions/greeter_steps.rb:7
    When I send it the greet message    # features/step_definitions/greeter_steps.rb:11
    Then I should see "Hello Cucumber!" # features/step_definitions/greeter_steps.rb:15

1 scenario (1 passed)
3 steps (3 passed)
0m0.389s
```

## <a name="4">日本語シナリオ</a>

spec/greeter_ja_spec.rb

```ruby
class RSpecGreeterJa
  def greet
    "こんにちはRSpec!"
  end
end

describe "RSpecあいさつ" do
  it "greet()メッセージを受けっとった場合'こんにちはRSpec!'と表示される" do
    greeter = RSpecGreeterJa.new
    greeting = greeter.greet
    expect(greeting).to eq("こんにちはRSpec!")
  end
end
```
features/greeter_says_hello_ja.feature
```
# language: ja
機能: こんにちはとあいさつする

  RSpec Book読者として
  こんにちはとあいさつしたい
  なぜならRSpecとCucumberの学習を始めたいからだ

  シナリオ: こんにちはとあいさつする
    前提 あいさつする人がいる
    もし あいさつのメッセージを送った
    ならば "こんにちはCucumber!"と表示される

```
features/step_definitions/greeter_steps_ja.rb

```ruby
class CucumberGreeter
  def greet_ja
    "こんにちはCucumber!"
  end
end

前提(/^あいさつする人がいる$/) do
  @greeter = CucumberGreeter.new
end

もし(/^あいさつのメッセージを送った$/) do
  @message = @greeter.greet_ja
end

ならば(/^"(.*?)"と表示される$/) do |greeting|
  @message.should == greeting
end
```
命令一覧
```
$ cucumber --i18n ja
      | feature          | "フィーチャ", "機能"                                  |
      | background       | "背景"                                           |
      | scenario         | "シナリオ"                                         |
      | scenario_outline | "シナリオアウトライン", "シナリオテンプレート", "テンプレ", "シナリオテンプレ" |
      | examples         | "例", "サンプル"                                    |
      | given            | "* ", "前提"                                     |
      | when             | "* ", "もし"                                     |
      | then             | "* ", "ならば"                                    |
      | and              | "* ", "かつ"                                     |
      | but              | "* ", "しかし", "但し", "ただし"                       |
      | given (code)     | "前提"                                           |
      | when (code)      | "もし"                                           |
      | then (code)      | "ならば"                                          |
      | and (code)       | "かつ"                                           |
      | but (code)       | "しかし", "但し", "ただし"                             |
```
一括実行
```
$ rake
/Users/k2works/.rvm/rubies/ruby-2.0.0-p247/bin/ruby -S rspec ./spec/greeter_ja_spec.rb ./spec/greeter_spec.rb
..

Finished in 0.00121 seconds
2 examples, 0 failures
/Users/k2works/.rvm/rubies/ruby-2.0.0-p247/bin/ruby -S bundle exec cucumber  --profile default
Using the default profile...
Feature: greeter says hello

  In order to start learning RSpec and Cucumber
  As a reader of The RSpec Book
  I want a greeter to say Hello

  Scenario: greeter says hello          # features/greeter_says_hello.feature:7
    Given a greeter                     # features/step_definitions/greeter_steps.rb:7
    When I send it the greet message    # features/step_definitions/greeter_steps.rb:11
    Then I should see "Hello Cucumber!" # features/step_definitions/greeter_steps.rb:15

# language: ja
機能: こんにちはとあいさつする

  RSpec Book読者として
  こんにちはとあいさつしたい
  なぜならRSpecとCucumberの学習を始めたいからだ

  シナリオ: こんにちはとあいさつする          # features/greeter_says_hello_ja.feature:8
    前提あいさつする人がいる              # features/step_definitions/greeter_steps_ja.rb:7
    もしあいさつのメッセージを送った          # features/step_definitions/greeter_steps_ja.rb:11
    ならば"こんにちはCucumber!"と表示される # features/step_definitions/greeter_steps_ja.rb:15

2 scenarios (2 passed)
6 steps (6 passed)
0m0.391s
```


# 参照 #

[RSpec](https://github.com/rspec)

[Cucumber](http://cukes.info/)

# 参考文献 #
<iframe src="http://rcm-fe.amazon-adsystem.com/e/cm?t=k2works0c-22&o=9&p=8&l=as1&asins=4798121932&ref=qf_sp_asin_til&fc1=000000&IS2=1&lt1=_blank&m=amazon&lc1=0000FF&bc1=000000&bg1=FFFFFF&f=ifr" style="width:120px;height:240px;" scrolling="no" marginwidth="0" marginheight="0" frameborder="0"></iframe>
