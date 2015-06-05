module BayesSpamFilter
  class Word

    def initialize(word)
      @value = word
      @count_bad = 0
      @count_good = 0
      @probably_spam = 0.0
    end
    attr_accessor :value, :count_bad, :count_good, :probably_spam

    def count_bad
      @count_bad += 1
    end

    def count_good
      @count_good += 1
    end

    def count_probability(ham_total, spam_total)
      if ham_total > 0 && spam_total > 0
        pr_ham = @count_good.to_f/ham_total
        pr_spam = @count_bad.to_f/spam_total
        @probably_spam = pr_spam/(pr_spam + pr_ham)
        @probably_spam = 0.01 if @probably_spam < 0.01
        @probably_spam = 0.99 if @probably_spam > 0.99
      end
    end
  end
end