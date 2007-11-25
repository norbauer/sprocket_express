module NetFtpExtensions
  
  # thanks to Jeff Cohen http://www.ruby-forum.com/topic/103726
  
  # Sends a collection of lines to be saved in a file on the server
  # lines can be an array, or anything responding to #each
  def send_text_lines(lines, remotefile, &block) # :yield: line
    storlines_from_array("STOR " + remotefile, lines, &block)
  end

  # Gets a file from the server as a collection of text lines.
  # If you don't provide a block, it will return an array of lines.
  # If you provide a block, each line will be passed to the block,
  # and the return value will be an empty array.
  # Large files should use the block form.
  def get_text_lines(remotefile, &block) # :yield: line
    lines = []
    retrlines("RETR " + remotefile) do |line|
      if block
        yield(line)
      else
        lines << line
      end
    end
    lines
  end

  private

  def storlines_from_array(cmd, lines, &block) # :yield: line
    synchronize do
      voidcmd("TYPE A")
      conn = transfercmd(cmd)
      lines.each do |line|
        conn.write(line)
        yield(line) if block
      end
      conn.close
      voidresp
    end
  end
  
end