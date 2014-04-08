require 'spec_helper'

describe User do
  before(:each) do
    FactoryGirl.create(:user)
    @params = Hash.new
  end

  context "正常系" do

    it "管理ユーザーが正しいパスワードでログインする" do
      @params[:username] = 'admin'
      @params[:password] = '1234'

      user = User.where(username: @params[:username].strip).first
      ret = user.authenticate(@params[:password])
      expect(ret).not_to eq(nil)
    end

  end

  context "例外系" do

    it "管理ユーザーが間違ったパスワードでログインする" do
      @params[:username] = 'admin'
      @params[:password] = '0000'

      user = User.where(username: @params[:username].strip).first
      ret = user.authenticate(@params[:password])
      expect(ret).to eq(false)
    end

  end
end
