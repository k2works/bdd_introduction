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
+ [セットアップ](#1)
+ [ビヘイビア駆動開発(BDD)とは](#2)
+ [サンプル実行](#3)

# 詳細 #

## <a name="1">セットアップ</a> ##

[RailsBricks入門参照](https://github.com/k2works/rails_bricks_introduction)

[RailsBricks入門(BDD適用編)参照](https://github.com/k2works/rails_bricks_bdd)

## <a name="2">ビヘイビア駆動開発(BDD)とは</a> ##

テスト駆動開発(TDD)からビヘイビア駆動開発(BDD)へ

TDD・・・オブジェクトが何をするかではなく、オブジェクトが何であるか。構造に焦点を合わせる。

<a href="https://www.flickr.com/photos/k2works/13635473944" title="TDD by Katuyuki Kakigi, on Flickr"><img src="https://farm3.staticflickr.com/2938/13635473944_bb1b6b7d38_n.jpg" width="319" height="320" alt="TDD"></a>

TDD概念図

BDD・・・オブジェクトが何をするか。構造ではなく振る舞いに焦点を合わせる。

<a href="https://www.flickr.com/photos/k2works/13634941835" title="BDD by Katuyuki Kakigi, on Flickr"><img src="https://farm8.staticflickr.com/7176/13634941835_7bcc39f7f4_n.jpg" width="320" height="310" alt="BDD"></a>

BDD概念図

## <a name="2">サンプル実行</a>
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

# 参照 #

[RSpec](https://github.com/rspec)

[Cucumber](http://cukes.info/)
