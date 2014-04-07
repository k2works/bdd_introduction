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
