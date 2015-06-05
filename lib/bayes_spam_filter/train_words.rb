module BayesSpamFilter
  class TrainWords

    def initialize
      @all_words = []
      @spam_total = 0
      @ham_total = 0
    end

    def call(ham_words, spam_words)
      puts 'Calculating...'
      train_ham(ham_words)
      train_spam(spam_words)
      count_propabilities
      @all_words
    end

    private

    def train_ham(ham_words)
      ham_words.each do |token|
        token.downcase!
        @ham_total += 1
        word = find_or_create_in_words_set(token)
        word.count_good
      end
    end

    def train_spam(spam_words)
      spam_words.each do |token|
        token.downcase!
        @spam_total += 1
        word = find_or_create_in_words_set(token)
        word.count_bad
      end
    end

    def count_propabilities
      @all_words.each do |word|
        word.count_probability(@ham_total, @spam_total)
      end
    end

    def find_or_create_in_words_set(token)
      word = @all_words.detect { |w| w.value.eql? token}
      unless word
        new_word = Word.new(token)
        @all_words << new_word
        word = new_word
      end
      word
    end
  end
end