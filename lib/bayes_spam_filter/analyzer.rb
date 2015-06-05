module BayesSpamFilter
  class Analyzer

    def initialize
      @word_base = []
    end

    def train_from_file(good_path, spam_path)
      ham_words = ReadFile.new.call(good_path)
      spam_words = ReadFile.new.call(spam_path)
      @word_base = TrainWords.new.call(ham_words, spam_words)
    end

    def verify_email(message_path)
      message_words = ReadFile.new.call(message_path)
      VerifyMessage.new(@word_base).call(message_words)
    end
  end
end