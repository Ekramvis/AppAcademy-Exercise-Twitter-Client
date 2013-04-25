class Status

  def initialize(author, message)
    @author = author
    @message = message
  end

  def text
    @message
  end

  def user
    @author
  end

end