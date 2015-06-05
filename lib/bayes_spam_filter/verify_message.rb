module BayesSpamFilter
  class VerifyMessage

    def initialize(all_words)
      @all_words = all_words
      @test = []
    end

    def call(message_tokens)
      analyze_words(message_tokens)
      is_spam?(message_tokens)
    end

    private

    def is_spam?(message_tokens)
      probabilities_product = 1.0
      probabilities_sum = 1.0
      message_tokens.each do |token|
        word = find_word(token)
        probabilities_product *= word.probably_spam
        @test << probabilities_product
        probabilities_sum *= (1.0 - word.probably_spam)
      end
      pspam = probabilities_product/(probabilities_product + probabilities_sum)
      "Probability that this message is SPAM equal = " + pspam.to_s
    end

    def analyze_words(message_tokens)
      message_tokens.each do |token|
        word = find_word(token)
        unless word
          create_word_in_set(token)
        end
      end
    end

    def find_word(token)
      @all_words.detect { |w| w.value.eql? token}
    end

    def create_word_in_set(token)
      new_word = Word.new(token)
      new_word.probably_spam = 0.4
      @all_words << new_word
    end
  end
end