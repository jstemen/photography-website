# Based on
# https://github.com/ng/paperclip-watermarking-app/blob/master/lib/paperclip_processors/watermark.rb
# Modified by Laurynas Butkus

module Paperclip
  class Watermark < Processor
    # Handles watermarking of images that are uploaded.
    attr_accessor :format, :whiny, :watermark_path, :position

    def initialize file, options = {}, attachment = nil
      super
      @file             = file
      @whiny            = options[:whiny].nil? ? true : options[:whiny]
      @format           = options[:format]
      @watermark_path   = options[:watermark_path]
      @position         = options[:watermark_position].nil? ? "Center" : options[:watermark_position]
      @transparency     = options[:watermark_transparency].nil? ? "20%" : options[:watermark_transparency]
      @tile_watermark     = options[:tile_watermark].nil? ? false : options[:tile_watermark]

      @current_format   = File.extname(@file.path)
      @basename         = File.basename(@file.path, @current_format)
    end

    # Performs the conversion of the +file+ into a watermark. Returns the Tempfile
    # that contains the new image.
    def make
      return @file unless watermark_path

      dst = Tempfile.new([@basename, @format].compact.join("."))
      dst.binmode

      #command = "composite"
      #params = "-gravity #{@position} #{watermark_path} #{fromfile} #{tofile(dst)}"
      command = "composite"
      params = "-gravity #{@position}"
      params = params + " -tile" if @tile_watermark
      params = params + " -dissolve #{@transparency} #{watermark_path} #{fromfile} #{tofile(dst)}"
     # composite -gravity south -geometry +0+10 stamp.png  logo.jpg \
      #      wmark_text_stamped.jpg
      begin
        success = Paperclip.run(command, params)
      rescue PaperclipCommandLineError
        raise PaperclipError, "There was an error processing the watermark for #{@basename}" if @whiny
      end

      dst
    end

    def fromfile
      "\"#{ File.expand_path(@file.path) }[0]\""
    end

    def tofile(destination)
      "\"#{ File.expand_path(destination.path) }[0]\""
    end
  end
end