class Until
  class Log < ::Log
    def tag!(tags)
      tags << :until
      tags << :library
      tags << :verbose
    end
  end
end
