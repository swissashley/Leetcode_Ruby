def x400_nth_digits(n)
  start = 1
  count = 9
  leng = 1
  while n > leng * count
    n -= leng * count
    count *= 10
    start *= 10
    leng += 1
  end
  # Reconstruct the num
  start = start + (n - 1) / leng

  # Find
  n_digit = (n - 1) % leng
  start.to_s[n_digit].to_i
end

def x249_group_shifted_str(arr)
  hash_map = {}
  arr.each do |str|
    base = str[0].ord - 'a'.ord
    new_str = 0
    str.each_char do |c|
      new_str += ((c.ord - base) % 26 + 'a'.ord)
    end
    p new_str
    unless hash_map[new_str]
      hash_map[new_str] = [str]
    else
      hash_map[new_str] << str
    end
  end
  hash_map.sort_by {|k, _| -k}.to_h.values
end

def x66_plus_one(digits)
    result = []
    carry = 1
    digits.reverse.each do |digit|
        result << (digit + carry) % 10
        carry = (digit + carry) / 10
    end
    result << carry if carry == 1
    result.reverse
end

class x288_ValidWordAbbr

    # Initialize your data structure here.
    # @param {string[]} dictionary
    def initialize(dictionary)
        @dic = {}
        dictionary.each do |word|
            abbr = abbr(word)
            if @dic[abbr] && !@dic[abbr].include?(word)
                @dic[abbr] << word
            else
                @dic[abbr] = [word]
            end
        end
    end

    # @param {string} word
    # @return {bool}
    def is_unique(word)

        return true if word.nil? || @dic[abbr(word)].nil? || @dic[abbr(word)].length == 1 && @dic[abbr(word)].include?(word)
        false
    end

    def abbr(word)
        return word if word.length < 3
        return word[0] + (word.length - 2).to_s + word[word.length - 1]
    end

end

def x463_island_perimeter(grid)
    perimeter = 0
    grid.each_with_index do |row, i|
        row.each_with_index do |el, j|
            if el == 1
                perimeter += 4
                perimeter -= 2 if i > 0 && grid[i - 1][j] == 1
                perimeter -= 2 if j > 0 && grid[i][j - 1] == 1
            end
        end
    end
    perimeter
end

def x246_is_strobogrammatic(num)
  map = {}

  map['0'] = '0'
  map['1'] = '1'
  map['6'] = '9'
  map['8'] = '8'
  map['9'] = '6'

  0.upto(num.length / 2) do |len|
      return false if !map[num[len, 1]].nil? && map[num[len, 1]] != num[num.length - 1 - len, 1]
      return false if map[num[len, 1]].nil?
  end
  true
end

def x345_reverse_vowels(s)
    out = s
    vowels = ['a','e','i','o','u','A','E','I','O','U']
    vowel_map = {}
    vowel_map['a'] = true
    vowel_map['e'] = true
    vowel_map['i'] = true
    vowel_map['o'] = true
    vowel_map['u'] = true
    vowel_map['A'] = true
    vowel_map['E'] = true
    vowel_map['I'] = true
    vowel_map['O'] = true
    vowel_map['U'] = true
    i = 0
    j = out.length - 1
    while i < j
        i+= 1 unless vowel_map[out[i, 1]]
        j-= 1 unless vowel_map[out[j, 1]]
        if vowel_map[out[i, 1]] && vowel_map[out[j, 1]]
            out[i, 1], out[j, 1] = out[j, 1], out[i, 1]
            i+= 1
            j-= 1
        end
    end
    out
end

def x408_valid_word_abbreviation(word, abbr)
    word_idx = 0
    abbr_idx = 0
    while abbr_idx < abbr.length
    digit_count = 1
    p abbr_idx
    p word_idx
        unless abbr[abbr_idx, digit_count].ord > '0'.ord && abbr[abbr_idx, digit_count].ord <= '9'.ord
            return false if abbr[abbr_idx, 1] != word[word_idx, 1]
            p 'Matching' + abbr[abbr_idx, 1]
            p 'Matching' + word[word_idx, 1]
            abbr_idx += 1
            word_idx += 1
        else
            p 'Curr' + abbr[abbr_idx, 1]
            p 'Curr' + word[word_idx, 1]
            while abbr_idx + digit_count - 1 < abbr.length &&  abbr[abbr_idx + digit_count - 1, digit_count].ord >= '0'.ord && abbr[abbr_idx + digit_count - 1, digit_count].ord <= '9'.ord
                p "Digit: " + digit_count.to_s
                digit_count += 1
            end
            word_idx += abbr[abbr_idx, digit_count - 1].to_i
            abbr_idx += digit_count - 1
        end
    end
    return false if word_idx != word.length
    true
end

def x276_num_ways(n, k)
    return 0 if n == 0 || k == 0
    return k if n == 1

    # n == 2
    same_color = k
    diff_color = k * (k - 1)

    2.upto(n - 1) do
        same_color, diff_color = diff_color, (k - 1) * (same_color + diff_color)
    end

    return same_color + diff_color
end

def x447_number_of_boomerangs(points)
    map = Hash.new(0)
    count = 0
    points.each_with_index do |p1, i|
        points.each_with_index do |p2, j|
            if i == j
                next
            else
                d = distance_sqrt(p1, p2)
                map[d] += 1
            end
        end
        map.values.each do |v|
            count += v * (v - 1)
        end
        map.clear
    end
    count
end

def distance_sqrt(p1, p2)
    x = p1[0] - p2[0]
    y = p1[1] - p2[1]
    return x * x + y * y
end

def x388_length_longest_path(input)
    # Default length
    stack = [0]
    max = 0

    dir_arr = input.split("\n")
    dir_arr.each do |path|
        level = 0
        unless path.rindex("\t").nil?
            level = path.rindex("\t") + 1
            (level + 1).upto(stack.size - 1) do
                stack.pop
            end
        else
        end
        curr_len = stack.last + path.length - level + 1
        stack << curr_len
        max = [curr_len - 1, max].max if is_file?(path)

    end

    max
end

def is_file?(name)
    dot_idx = name.index(".")
    return !dot_idx.nil? && dot_idx > 0 && dot_idx < name.length
end
