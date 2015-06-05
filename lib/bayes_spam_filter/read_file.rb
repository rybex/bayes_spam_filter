module BayesSpamFilter
  class ReadFile

    def call(file_path)
      contents = File.read(file_path)
      contents = contents.force_encoding('BINARY')
      contents.encode('UTF-8', invalid: :replace, undef: :replace)
      contents.split(/\W+/)
    end
  end
end