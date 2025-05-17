require "fileutils"
require "securerandom"
require_relative "hangman"

# writing mpack to file, reading mpack from file
module Saving
  DIR = "data/saves".freeze
  FileUtils.mkdir_p(DIR) # make "saves" directory if not already present

  def self.save(hangman)
    mpack = hangman.to_mpack
    uuid = SecureRandom.uuid
    File.write("#{DIR}/#{uuid}.mpk", mpack)
  end

  def self.read_save_files
    @saves = []
    Dir.children(DIR).each do |filename|
      File.open("#{DIR}/#{filename}") do |f|
        @saves.push({
                      game: Hangman.from_mpack(f.readlines[0]),
                      filename: filename,
                      timestamp: f.atime
                    })
      end
    end
  end

  def self.sort_save_files
    @saves = @saves.sort_by { |s| s[:timestamp] }
  end

  def self.show_save_entries
    read_save_files
    sort_save_files
    @saves.each_with_index.map do |save, index|
      "[#{index + 1}] #{
        Time.at(save[:timestamp]).strftime('%B %-d, %Y, %H:%M')
      } : \"#{
        save[:game].concealed_word
      }\""
    end
  end

  def self.load_by_index(index)
    @saves[index - 1][:game]
  end

  def self.delete_by_index(index)
    target_filename = @saves[index - 1][:filename]
    File.delete("#{DIR}/#{target_filename}")
  end
end
