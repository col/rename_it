require 'fileutils'
require 'ptools'

class RenameIt

  def initialize(src_path, dest_path, name=nil, relacement=nil)
    @src_path = src_path
    @dest_path = dest_path
    @name = name || File.basename(src_path)
    @replacement = relacement || File.basename(dest_path)
  end

  def run
    copy_to_dest
    rename_files_in_path(@dest_path)
    replace_content_in_path(@dest_path)
  end

  private

  def copy_to_dest
    FileUtils.cp_r(@src_path, @dest_path)
  end

  def rename_files_in_path(path)
    Dir["#{path}/*"].each do |file|
      file_name = File.basename(file)

      file_name.scan(/^(.*)#{Regexp.quote(@name)}(.*)(\.*.*)$/) do |prefix, suffix, extension|
        File.rename(
          File.join(path, file_name),
          File.join(path, prefix+@replacement+suffix+(extension||''))
        )
      end

      rename_files_in_path(file) if File.directory?(file)
    end
  end

  def replace_content_in_path(path)
    Dir["#{path}/*"].each do |file|
      unless File.directory?(file) || File.binary?(file)
        content = File.read(file)
        new_contents = content.gsub(@name, @replacement)      
        File.write(file, new_contents)
      end

      replace_content_in_path(file) if File.directory?(file)
    end    
  end

end
