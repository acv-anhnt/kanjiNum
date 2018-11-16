require "kansuji/version"
class Error < StandardError; end
Kanji = { "無量大数" => 10**68, "不可思議" => 10**64, "那由他" => 10**60, "阿僧祇" => 10**56, "恒河沙" => 10**52,
          "極" => 10**48, "載" => 10**44, "正" => 10**40, "澗" => 10**36, "溝" => 10**32, "穣" => 10**28, "𥝱" => 10**24,
          "禾予" => 10**24, "秭" => 10**24, "垓" => 10**20, "京" => 10**16, "兆" => 10**12, "億" => 10**8,
          "万" => 10**4, "千" => 1000, "百" => 100, "十" => 10, "九" => 9, "八" => 8, "七" => 7, "六" => 6, "五" => 5,
          "四" => 4, "三" => 3, "二" => 2, "一" => 1, "零" => 0, "〇" => 0 }
class KansujHelp
  def segVal(ary)
    return 1 if ary.length == 0 # Case: [100, 10]

    ary.each_with_index do |val, i| ary[i], ary[i + 1] = 0, val * ary[i + 1] if (i < ary.length - 1 and val < ary[i + 1]) end
    return ary.sum
  end

  def toKanj(pVal1, first)
    kanjStr, pVal = "", pVal1
    Kanji.select { |k, v| v > 9 }.each do |key, val|
      digit, kansujHelp = pVal / val, (KansujHelp.new if first == true)
      tmpVal = first == true ? kanjStr + kansujHelp.toKanj(digit, false) + key : kanjStr + Kanji.key(digit) + key
      kanjStr, pVal = digit == 1 ? [kanjStr + key, pVal - val] : (digit == 0 ? [kanjStr, pVal] : [tmpVal, pVal - digit * val])
    end
    restStr = pVal != 0 ? Kanji.key(pVal) : ""
    return Kanji.select { |k, v| v > 1000 }.key?(kanjStr) ? "一" + kanjStr + restStr : kanjStr + restStr
  end
end
class String
  def to_number
    kansujHelp, valAry, sum, strAry = KansujHelp.new, [], sum = 0, strAry = self.chars
    while !strAry.empty? do # Convert the Kanji String to number value array
      stranChar = true
      Kanji.each do |key, value|
        valAry.push(value) and (strAry, stranChar = strAry.drop(key.length), false) and break if key.include? strAry[0]
      end
      break if stranChar == true # If there are characters which are not Kanji number characters
    end
    return valAry[0] if valAry.length == 1

    Kanji.each do |key, value| # sum = value(Doan1)*京value + value(Doan2)*兆value+...
      valAry.each_with_index do |val, i|
        ((sum, valAry = sum + kansujHelp.segVal(valAry.take(i)) * value, valAry.drop(i + 1)) and break) if (val == value)
      end
    end
    rest = valAry.length > 0 ? valAry[0] : 0 and return sum + rest
  end
end
class Integer
  def to_kansuji
    kansujHelp = KansujHelp.new and ((self.zero?) ? Kanji.key(0) : kansujHelp.toKanj(self, true))
  end
end