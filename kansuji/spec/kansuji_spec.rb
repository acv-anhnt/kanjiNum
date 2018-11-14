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


end
