RSpec.describe Kansuji do
  it "has a version number" do
    expect(Kansuji::VERSION).not_to be nil
  end

  it "should convert 三千七百十三 to number 3713" do
    expect("三千七百十三".to_number).to eq 3713
  end

  it "should convert 零 to 0" do
    expect("零".to_number).to eq 0
  end

  it "should convert 〇 to 0" do
    expect("〇".to_number).to eq 0
  end

  it "should convert 一 to 1" do
    expect("一".to_number).to eq 1
  end

  it "should convert 二 to 2" do
    expect("二".to_number).to eq 2
  end

  it "should convert 三 to 3" do
    expect("三".to_number).to eq 3
  end

  it "should convert 七十五兆三千四百八十二億五千七百九十五万七千四百三十八 to 75348257957438" do
    expect("七十五兆三千四百八十二億五千七百九十五万七千四百三十八".to_number).to eq 75348257957438
  end

  it "should convert 兆 to 1000000000000" do
    expect("兆".to_number).to eq 1000000000000
  end

  it "should convert 一兆二十億三千百万四百二十一 to 1002031000421" do
    expect("一兆二十億三千百万四百二十一".to_number).to eq 1002031000421
  end

  it "should convert 三千百万四百二十 to 31000420" do
    expect("三千百万四百二十".to_number).to eq 31000420
  end

  it 'you should see a warning when you run this Example' do
    (1 + 1).should eq(2)
  end
  it "should convert 1 to 一" do
    expect(1.to_kansuji).to eq "一"
  end

  it "should convert 2 to 二" do
    expect(2.to_kansuji).to eq "二"
  end

  it "should convert 3 to 三" do
    expect(3.to_kansuji).to eq "三"
  end

  it "should convert 4 to 四" do
    expect(4.to_kansuji).to eq "四"
  end

  it "should convert 5 to 五" do
    expect(5.to_kansuji).to eq "五"
  end

  it "should convert 1002031000421 to 兆二十億三千百万四百二十一" do
    expect(1002031000421.to_kansuji).to eq "兆二十億三千百万四百二十一"
  end

  it "should convert 31000420 to 三千百万四百二十" do
    expect(31000420.to_kansuji).to eq "三千百万四百二十"
  end

  it "should convert 10^68 to 一無量大数" do
    bigNum = 10**68
    expect(bigNum.to_kansuji).to eq "一無量大数"
  end

  it "should convert 20 to 二十" do
    expect(20.to_kansuji).to eq "二十"
  end

  it "should convert 3100 to 三千百" do
    expect(3100.to_kansuji).to eq "三千百"
  end

  it "should convert 75348257957438 to 七十五兆三千四百八十二億五千七百九十五万七千四百三十八" do
    expect(75348257957438.to_kansuji).to eq "七十五兆三千四百八十二億五千七百九十五万七千四百三十八"
  end

  it "should convert 10**64 to 一不可思議" do
    bigNum = 10**64
    expect(bigNum.to_kansuji).to eq "一不可思議"
  end

  it "should convert 7693247647972375740000000000000000000000000463226432632644362 to 七那由他六千九百三十二阿僧祇四千七百六十四恒河沙七千九百七十二極三千七百五十七載四千正四十六京三千二百二十六兆四千三百二十六億三千二百六十四万四千三百六十二" do
    longString = "七那由他六千九百三十二阿僧祇四千七百六十四恒河沙七千九百七十二極三千七百五十七載四千正四十六京三千二百二十六兆四千三百二十六億三千二百六十四万四千三百六十二"
    bigNum = 7693247647972375740000000000000000000000000463226432632644362
    expect(bigNum.to_kansuji).to eq longString
  end

  it "should convert 七那由他六千九百三十二阿僧祇四千七百六十四恒河沙七千九百七十二極三千七百五十七載四千正四十六京三千二百二十六兆四千三百二十六億三千二百六十四万四千三百六十二 to 7693247647972375740000000000000000000000000463226432632644362" do
    longString = "七那由他六千九百三十二阿僧祇四千七百六十四恒河沙七千九百七十二極三千七百五十七載四千正四十六京三千二百二十六兆四千三百二十六億三千二百六十四万四千三百六十二"
    bigNum = 7693247647972375740000000000000000000000000463226432632644362
    expect(longString.to_number).to eq bigNum
  end

  it "should convert long string with 無量大数 to number" do
    longString = "五無量大数五千八百一不可思議六千四百七十九那由他七千二百三十七阿僧祇五千七百四十恒河沙四千六百三十二𥝱二千六百四十三垓二千六百三十二京六千四百四十三兆六千二百億"
    bigNum = 558016479723757400000000000000000000000004632264326326443620000000000
    expect(longString.to_number).to eq bigNum
  end

  it "should convert big number to longString" do
    longString = "五無量大数五千八百一不可思議六千四百七十九那由他七千二百三十七阿僧祇五千七百四十恒河沙四千六百三十二𥝱二千六百四十三垓二千六百三十二京六千四百四十三兆六千二百億"
    bigNum = 558016479723757400000000000000000000000004632264326326443620000000000
    expect(bigNum.to_kansuji).to eq longString
  end
end
