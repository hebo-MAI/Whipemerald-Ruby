# A Whipemerald-language implementation by Ruby
# Author: hebo-MAI
# Original Idea: DirectKidman (Seiji M)
# Special Thanks: @whipemerald
# only use the following 5 characters: 🔥👼🏠🍄🐸

# initial setting
MAX_CELL_VALUE = 0xff
MEMORY_SIZE = 65536

in_file_name = ARGV[0]

def tweet(string)
    raise "this function is not implemented yet.\nOutput string is: #{output_string}"
end

def to_unicode(memory, pointer)
    # p memory[pointer..(pointer+3)]
    memory[pointer..(pointer+3)].pack("U")
end

def main_operation(reader)
    memory = Array.new(MEMORY_SIZE, 0)
    curr1, curr2, cmd = nil
    output_string = ''
    jz = false
    jnz = false
    pointer = 0
    loop do
        curr1 = reader.getc
        next if curr1 =~/\s/
        curr2 = reader.getc
        break if !curr1 || !curr2
        cmd = curr1 + curr2
        # print cmd
        if jz
            jz = false if cmd != '👼🔥'
            next
        end
        if jnz
            jnz = false if cmd != '🔥👼'
            next
        end
        case cmd
        when '🔥🐸'
            # increments pointer
            pointer += 1
            pointer %= MEMORY_SIZE
        when '🐸🔥'
            # decrements pointer
            pointer += MEMORY_SIZE - 1
            pointer %= MEMORY_SIZE
        when '🔥🏠'
            # increments the current value
            memory[pointer] += 1
            memory[pointer] %= MAX_CELL_VALUE + 1
        when '🏠🔥'
            # decrements the current value
            memory[pointer] += MAX_CELL_VALUE
            memory[pointer] %= MAX_CELL_VALUE + 1
        when '🔥👼'
            # jumps if zero
            jz = true
        when '👼🔥'
            # jumps if not zero
            jnz = true
        when '🔥🍄'
            # reads a character from standard input
            memory[pointer] = $stdin.getc.to_i
        when '🍄🔥', '🔥🔥'
            # outputs to standard output the current value as Unicode
            print to_unicode(memory, pointer)
            output_string += to_unicode(memory, pointer)
        when '🐸🐸'
            # 現在までの出力結果をツイートする
            tweet(output_string)
        else
            raise "invalid operation: #{cmd}"
        end
    end
end

File.open(in_file_name, 'r') do |f|
    main_operation(f)
end