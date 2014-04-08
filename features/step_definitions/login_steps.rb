前提(/^"(.*?)"の登録が完了している$/) do |user|
  if user == "admin"
    FactoryGirl.create(:user)
  end
end

もし(/^"(.*?)"が"(.*?)"を使ってログインしたら$/) do |user, pass|
  visit '/'
  click_link 'Sign in'
  fill_in 'Username', with: user
  fill_in 'Password', with: pass
  click_button('Sign in')
end

ならば(/^管理画面に移動して"(.*?)"と表示される$/) do |message|
  expect(page).to have_content message
end
