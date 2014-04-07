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
