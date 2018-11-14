require "kansuji/version"
class Error < StandardError; end
Kanji = Hash["京" => 10**16, "兆" => 10**12, "億" => 10**8, "万" => 10**4, "千" => 1000, "百" => 100, "十" => 10,
             "九" => 9, "八" => 8, "七" => 7, "六" => 6, "五" => 5, "四" => 4, "三" => 3, "二" => 2, "一" => 1, 
             "零" => 0, "〇" => 0]
Break = Array[10**16, 10**12, 10**8, 10**4, 1000, 100, 10]

class KansujiHelp
  def segmentVal (array)
      return 1 if array.length == 0 #Case: [100, 10]
      array.each_with_index do |a, i|
        if (i < array.length-1 and a < array[i+1]) then
          array[i] = 0
          array[i+1] = a*array[i+1]
        end
      end
      return array.reduce(:+)
    end
end

class String
    def to_number
      kansujiHelp = KansujiHelp.new()
      numberValueArray = Array.new()
      sum = 0
      self.split('').each do |c| numberValueArray.push(Kanji[c]) end  #Convert the Kanji String to number value array
      return numberValueArray[0] if numberValueArray.length == 1
      Break.each do |b|     #sum = value(Doan1)*京value + value(Doan2)*兆value+...
        numberValueArray.each_with_index do |n, i|  
          if (n==b) then
            sum += kansujiHelp.segmentVal(numberValueArray.take(i))*b
            numberValueArray = numberValueArray.drop(i+1)
            break
          end
        end
      end
      rest = numberValueArray.length > 0 ? numberValueArray[0]:0
      return sum + rest #After running the loop, we can have the last part
    end
end

class Integer
end