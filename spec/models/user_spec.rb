require 'rails_helper'

RSpec.describe User, type: :model do
  describe '#create' do
    before do
      @user = FactoryBot.build(:user)
    end
  
    it "全てのデータが正しく存在すれば登録可能" do
      expect(@user).to be_valid
    end

    it "nicknameなしでは登録不可" do
      @user.nickname = nil
      @user.valid?
      expect(@user.errors.full_messages).to include ("Nickname can't be blank")
    end

    it "emailなしでは登録不可" do
      @user.email = nil
      @user.valid?
      expect(@user.errors.full_messages).to include ("Email can't be blank")
    end

    it "重複したemailでは登録不可" do
      @user.save
      another_user = FactoryBot.build(:user, email:@user.email)
      another_user.valid?
      expect(another_user.errors.full_messages).to include("Email has already been taken")
    end

    it "emailに＠なしでは登録不可" do
      @user.email = "aaabbb"
      @user.valid?
      expect(@user.errors.full_messages).to include ("Email is invalid")
    end

    it "passwordなしでは登録不可" do
      @user.password = nil
      @user.valid?
      expect(@user.errors.full_messages).to include ("Password can't be blank")
    end

    it "passwordが半角英数字混合でも5文字以内では登録不可" do
      @user.password = "abcd1"
      @user.valid?
      expect(@user.errors.full_messages).to include ("Password is too short (minimum is 6 characters)")
    end

    it "passwprdは6文字以上でも半角英数字混合でないと登録不可" do
      @user.password = "abcdef"
      @user.password_confirmation = "abcdef"
      @user.valid?
      expect(@user.errors.full_messages).to include ("Password is invalid")
    end

    it "確認用passwordなしでは登録不可" do
      @user.password_confirmation = ""
      @user.valid?
      expect(@user.errors.full_messages).to include ("Password confirmation doesn't match Password")
    end

    it "passwordと確認用passwordが不一致では登録不可" do
      @user.password = "avc123"
      @user.password_confirmation = "abc123"
      @user.valid?
      expect(@user.errors.full_messages).to include ("Password confirmation doesn't match Password")
    end

    it "fristnameなしでは登録不可" do
      @user.fristname = nil
      @user.valid?
      expect(@user.errors.full_messages).to include ("Fristname can't be blank")
    end

    it "lastnameなしでは登録不可" do
      @user.lastname = nil
      @user.valid?
      expect(@user.errors.full_messages).to include ("Lastname can't be blank")
    end

    it "fristname・lastnameが全角漢字であれば登録可" do
      @user.fristname = "太郎"
      @user.fristname_kana = "タロウ"
      @user.lastname = "田中"
      @user.lastname_kana = "タナカ"
      expect(@user).to be_valid
    end

    it "fristname・lastnameが全角ひらがなであれば登録可" do
      @user.fristname = "たろう"
      @user.fristname_kana = "タロウ"
      @user.lastname = "たなか"
      @user.lastname_kana = "タナカ"
      expect(@user).to be_valid
    end

    it "fristname・lastnameが全角カタカナであれば登録可" do
      @user.fristname = "タロウ"
      @user.fristname_kana = "タロウ"
      @user.lastname = "タナカ"
      @user.lastname_kana = "タナカ"
      expect(@user).to be_valid
    end

    it "fristnameが全角漢字・lastnameが全角カタカナであれば登録可" do
      @user.fristname = "太郎"
      @user.fristname_kana = "タロウ"
      @user.lastname = "タナカ"
      @user.lastname_kana = "タナカ"
      expect(@user).to be_valid
    end

    it "fristnameが全角漢字・lastnameが全角ひらがなであれば登録可" do
      @user.fristname = "太郎"
      @user.fristname_kana = "タロウ"
      @user.lastname = "たなか"
      @user.lastname_kana = "タナカ"
      expect(@user).to be_valid
    end

    it "fristnameが全角カタカナ・lastnameが全角漢字であれば登録可" do
      @user.fristname = "タロウ"
      @user.fristname_kana = "タロウ"
      @user.lastname = "田中"
      @user.lastname_kana = "タナカ"
      expect(@user).to be_valid
    end

    it "fristnameが全角ひらがな・lastnameが全角漢字であれば登録可" do
      @user.fristname = "たろう"
      @user.fristname_kana = "タロウ"
      @user.lastname = "田中"
      @user.lastname_kana = "タナカ"
      expect(@user).to be_valid
    end

    it "fristnameが全角数字では登録不可" do
      @user.fristname = "１１１"
      @user.valid?
      expect(@user.errors.full_messages).to include ("Fristname is invalid")
    end

    it "fristnameが全角英字では登録不可" do
      @user.fristname = "ａｂｅ"
      @user.valid?
      expect(@user.errors.full_messages).to include ("Fristname is invalid")
    end

    it "fristnameは半角カタカナでは登録不可" do
      @user.fristname = "ﾀﾛｳ"
      @user.valid?
      expect(@user.errors.full_messages).to include ("Fristname is invalid")
    end

    it "fristnameは半角英字では登録不可" do
      @user.fristname = "aaa"
      @user.valid?
      expect(@user.errors.full_messages).to include ("Fristname is invalid")
    end

    it "fristnameは半角数字では登録不可" do
      @user.fristname = "111"
      @user.valid?
      expect(@user.errors.full_messages).to include ("Fristname is invalid")
    end

    it "fristnameが全角数字では登録不可" do
      @user.fristname = "１１１"
      @user.valid?
      expect(@user.errors.full_messages).to include ("Fristname is invalid")
    end

    it "fristnameが全角英字では登録不可" do
      @user.fristname = "ａｂｅ"
      @user.valid?
      expect(@user.errors.full_messages).to include ("Fristname is invalid")
    end

    it "fristnameは半角カタカナでは登録不可" do
      @user.fristname = "ﾀﾛｳ"
      @user.valid?
      expect(@user.errors.full_messages).to include ("Fristname is invalid")
    end

    it "fristnameは半角英字では登録不可" do
      @user.fristname = "aaa"
      @user.valid?
      expect(@user.errors.full_messages).to include ("Fristname is invalid")
    end

    it "fristnameは半角数字では登録不可" do
      @user.fristname = "111"
      @user.valid?
      expect(@user.errors.full_messages).to include ("Fristname is invalid")
    end

    it "lastnameが全角数字では登録不可" do
      @user.lastname = "１１１"
      @user.valid?
      expect(@user.errors.full_messages).to include ("Lastname is invalid")
    end

    it "lastnameが全角英字では登録不可" do
      @user.lastname = "ａｂｅ"
      @user.valid?
      expect(@user.errors.full_messages).to include ("Lastname is invalid")
    end

    it "lastnameは半角カタカナでは登録不可" do
      @user.lastname = "ﾀﾛｳ"
      @user.valid?
      expect(@user.errors.full_messages).to include ("Lastname is invalid")
    end

    it "lastnameは半角英字では登録不可" do
      @user.lastname = "aaa"
      @user.valid?
      expect(@user.errors.full_messages).to include ("Lastname is invalid")
    end

    it "lastnameは半角数字では登録不可" do
      @user.lastname = "111"
      @user.valid?
      expect(@user.errors.full_messages).to include ("Lastname is invalid")
    end

    it "fristnameカナが全角数字では登録不可" do
      @user.fristname_kana = "１１１"
      @user.valid?
      expect(@user.errors.full_messages).to include ("Fristname kana is invalid")
    end

    it "fristnameカナが全角英字では登録不可" do
      @user.fristname_kana = "ａｂｅ"
      @user.valid?
      expect(@user.errors.full_messages).to include ("Fristname kana is invalid")
    end

    it "fristnameカナは半角カタカナでは登録不可" do
      @user.fristname_kana = "ﾀﾛｳ"
      @user.valid?
      expect(@user.errors.full_messages).to include ("Fristname kana is invalid")
    end

    it "fristnameカナは半角英字では登録不可" do
      @user.fristname_kana = "aaa"
      @user.valid?
      expect(@user.errors.full_messages).to include ("Fristname kana is invalid")
    end

    it "fristnameカナは半角数字では登録不可" do
      @user.fristname_kana = "111"
      @user.valid?
      expect(@user.errors.full_messages).to include ("Fristname kana is invalid")
    end

    it "fristnameカナが全角数字では登録不可" do
      @user.fristname_kana = "１１１"
      @user.valid?
      expect(@user.errors.full_messages).to include ("Fristname kana is invalid")
    end

    it "fristnameカナが全角英字では登録不可" do
      @user.fristname_kana = "ａｂｅ"
      @user.valid?
      expect(@user.errors.full_messages).to include ("Fristname kana is invalid")
    end

    it "fristnameカナは半角カタカナでは登録不可" do
      @user.fristname_kana = "ﾀﾛｳ"
      @user.valid?
      expect(@user.errors.full_messages).to include ("Fristname kana is invalid")
    end

    it "fristnameカナは半角英字では登録不可" do
      @user.fristname_kana = "aaa"
      @user.valid?
      expect(@user.errors.full_messages).to include ("Fristname kana is invalid")
    end

    it "fristnameカナは半角数字では登録不可" do
      @user.fristname_kana = "111"
      @user.valid?
      expect(@user.errors.full_messages).to include ("Fristname kana is invalid")
    end

    it "lastnameカナが全角数字では登録不可" do
      @user.lastname_kana = "１１１"
      @user.valid?
      expect(@user.errors.full_messages).to include ("Lastname kana is invalid")
    end

    it "lastnameカナが全角英字では登録不可" do
      @user.lastname_kana = "ａｂｅ"
      @user.valid?
      expect(@user.errors.full_messages).to include ("Lastname kana is invalid")
    end

    it "lastnameカナは半角カタカナでは登録不可" do
      @user.lastname_kana = "ﾀﾛｳ"
      @user.valid?
      expect(@user.errors.full_messages).to include ("Lastname kana is invalid")
    end

    it "lastnameカナは半角英字では登録不可" do
      @user.lastname_kana = "aaa"
      @user.valid?
      expect(@user.errors.full_messages).to include ("Lastname kana is invalid")
    end

    it "lastnameカナは半角数字では登録不可" do
      @user.lastname_kana = "111"
      @user.valid?
      expect(@user.errors.full_messages).to include ("Lastname kana is invalid")
    end

    it "fristnameは正常・lastnameが異常時は登録不可①" do
      @user.fristname = "タロウ"
      @user.lastname = "ﾀﾛｳ"
      @user.valid?
      expect(@user.errors.full_messages).to include ("Lastname is invalid")
    end

    it "fristnameは正常・lastnameが異常時は登録不可②" do
      @user.fristname = "タロウ"
      @user.lastname = "taro"
      @user.valid?
      expect(@user.errors.full_messages).to include ("Lastname is invalid")
    end

    it "fristnameは正常・lastnameが異常時は登録不可③" do
      @user.fristname = "タロウ"
      @user.lastname = "123"
      @user.valid?
      expect(@user.errors.full_messages).to include ("Lastname is invalid")
    end

    it "fristnameが異常・lastnameが正常時は登録不可①" do
      @user.fristname = "ﾀﾛｳ"
      @user.lastname = "タロウ"
      @user.valid?
      expect(@user.errors.full_messages).to include ("Fristname is invalid")
    end

    it "fristnameが異常・lastnameが正常時は登録不可②" do
      @user.fristname = "taro"
      @user.lastname = "タロウ"
      @user.valid?
      expect(@user.errors.full_messages).to include ("Fristname is invalid")
    end

    it "fristnameが異常・lastnameが正常時は登録不可③" do
      @user.fristname = "123"
      @user.lastname = "タロウ"
      @user.valid?
      expect(@user.errors.full_messages).to include ("Fristname is invalid")
    end

    it "fristnameカナが異常・lastnameカナが正常時は登録不可①" do
      @user.fristname = "太郎"
      @user.fristname_kana = "ﾀﾛｳ"
      @user.lastname = "田中"
      @user.lastname_kana = "タナカ"
      @user.valid?
      expect(@user.errors.full_messages).to include ("Fristname kana is invalid")
    end

    it "fristnameカナが異常・lastnameカナが正常時は登録不可②" do
      @user.fristname = "太郎"
      @user.fristname_kana = "taro"
      @user.lastname = "田中"
      @user.lastname_kana = "タナカ"
      @user.valid?
      expect(@user.errors.full_messages).to include ("Fristname kana is invalid")
    end

    it "fristnameカナが異常・lastnameカナが正常時は登録不可③" do
      @user.fristname = "太郎"
      @user.fristname_kana = "123"
      @user.lastname = "田中"
      @user.lastname_kana = "タナカ"
      @user.valid?
      expect(@user.errors.full_messages).to include ("Fristname kana is invalid")
    end

    it "fristnameカナが正常・lastnameカナが異常時は登録不可①" do
      @user.fristname = "太郎"
      @user.fristname_kana = "タロウ"
      @user.lastname = "田中"
      @user.lastname_kana = "ﾀﾅｶ"
      @user.valid?
      expect(@user.errors.full_messages).to include ("Lastname kana is invalid")
    end

    it "fristnameカナが正常・lastnameカナが異常時は登録不可②" do
      @user.fristname = "太郎"
      @user.fristname_kana = "タロウ"
      @user.lastname = "田中"
      @user.lastname_kana = "tanaka"
      @user.valid?
      expect(@user.errors.full_messages).to include ("Lastname kana is invalid")
    end

    it "fristnameカナが正常・lastnameカナが異常時は登録不可③" do
      @user.fristname = "太郎"
      @user.fristname_kana = "タロウ"
      @user.lastname = "田中"
      @user.lastname_kana = "123"
      @user.valid?
      expect(@user.errors.full_messages).to include ("Lastname kana is invalid")
    end

    it "生年月日なしでは登録不可" do
      @user.birth_date = nil
      @user.valid?
      expect(@user.errors.full_messages).to include ("Birth date can't be blank")
    end
  end
end