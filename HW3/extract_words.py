import os

# function
def main():
    # load the text file
    original_file = open("./data/63273-0.txt",'r',encoding='utf-8')
    # read all words from original_file(parameter)
    words = [w.lower() for w in original_file.read().split()]
    filtered_words = []
    # filtered some special words such as specialized characters
    for word in words:
        filtered_words.append(word.strip('!"#$%&\'()*+,-./:;<=>?@[\\]^_`{|}~”“'''))
    # open a new file(allwords.txt) to write
    allwords = open("./data/allwords.txt",'w',encoding='utf-8')
    for word in filtered_words:
        allwords.write(word+'\n')
    # next, make a unit set to reduce duplicate words
    unique_set = set(filtered_words)
    uniq_file = open("./data/uniquewords.txt",'w',encoding='utf-8')
    for word in unique_set:
        uniq_file.write(word+'\n')

    # Last, make a wordfrequency.txt to count all words
    word_freq_file = open("./data/wordfrequency.txt", "w",encoding='utf-8')
    frequency = []
    words_list = ''
    frequency = [filtered_words.count(word) for word in filtered_words]
    frequency.sort()
    #print(frequency)
    count = 0

    freq_set = set(frequency)
    freq_dict = {}
    for num in freq_set:
        count = frequency.count(num)
        freq_dict[num] = count

    for freq in sorted(freq_dict.keys()):
        word_freq_file.write(str(freq) + ': ' + str(freq_dict[freq]) + '\n')

    allwords.close()
    uniq_file.close()
    word_freq_file.close()
    #words_file.close()

main()