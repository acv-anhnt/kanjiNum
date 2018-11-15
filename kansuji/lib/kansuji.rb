require "kansuji/version"
class Error < StandardError; end
Kanji = Hash["無量大数" => 10**68, "不可思議" => 10**64, "那由他" => 10**60, "阿僧祇" => 10**56, "恒河沙" => 10**52, 
              "極" => 10**48, "載" => 10**44, "正" => 10**40, "澗" => 10**36,"溝" => 10**32,"穣" => 10**28, "秭" => 10**24,
              "禾予" => 10**24, "𥝱" => 10**24, "垓" => 10**20, "京" => 10**16, "兆" => 10**12, "億" => 10**8,
              "万" => 10**4, "千" => 1000, "百" => 100, "十" => 10, "九" => 9, "八" => 8, "七" => 7, "六" => 6, "五" => 5,
              "四" => 4, "三" => 3, "二" => 2, "一" => 1, "零" => 0, "〇" => 0]
class KansujiHelp
  def segmentVal (array)
    return 1 if array.length == 0 #Case: [100, 10]
    array.each_with_index do |a, i| array[i], array[i+1] = 0, a*array[i+1] if (i < array.length-1 and a < array[i+1]) end
    return array.reduce(:+)
  end
  def onePartToKanji (partValue)
    kanjiString = ""
    Kanji.each do |key, value|
      break if value == 9
      intPart = partValue/value
      kanjiString, partValue = kanjiString + key, partValue - value if intPart == 1
      kanjiString, partValue = kanjiString + Kanji.key(intPart) + key, partValue - intPart*value if intPart > 1
    end
    restPart = partValue != 0 ? Kanji.key(partValue): ""
    return kanjiString + restPart
  end
end
class String
  def to_number
    kansujiHelp = KansujiHelp.new()
    numberValueArray = Array.new()
    sum = 0
    stringArr = self.split('')
    while !stringArr.empty? do  #Convert the Kanji String to number value array
      stranChar = true
      Kanji.each do |key, value|
        if key.include? stringArr[0] then
          numberValueArray.push(value)
          stringArr, stranChar = stringArr.drop(key.length), false  #case: has many letters for one value
          break
        end
      end
      if stranChar == true then
        puts "**********There is strange character: #{stringArr[0]}"
        break
      end
    end  
    return numberValueArray[0] if numberValueArray.length == 1
    Kanji.each do |key, value|     #sum = value(Doan1)*京value + value(Doan2)*兆value+...
      numberValueArray.each_with_index do |n, i|  
        if (n == value) then
          sum, numberValueArray = sum + kansujiHelp.segmentVal(numberValueArray.take(i))*value, numberValueArray.drop(i+1)
          break
        end
      end
    end
    rest = numberValueArray.length > 0 ? numberValueArray[0]:0
    return sum + rest #After running the loop, we can have the last part
  end
end
class Integer
  def to_kansuji
    kanjiString, number, hasOneAtBegin = "", self, false
    kansujiHelp = KansujiHelp.new()
    Kanji.each do |key, value|
      break if value == 9
      intPart = number/value
      kanjiString, number = kanjiString + key, number - value if intPart == 1
      #There is value before the break
      kanjiString, number = kanjiString + kansujiHelp.onePartToKanji(intPart) + key, number - intPart*value if intPart > 1
    end
    restPart = number != 0 ? Kanji.key(number): ""
    kanjiString = "一" + kanjiString if self.digits().last == 1 and self != 1
    return kanjiString + restPart
  end
end