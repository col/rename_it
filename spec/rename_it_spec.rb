require 'fileutils'
require_relative '../src/rename_it.rb'

describe RenameIt do
  
  let(:src_path) { 'Example/ProjTemplate' }
  let(:dest_path) { 'Example/NewProject' }

  let(:src_name) { 'Template' }
  let(:dest_name) { 'Project' }

  let(:rename_it) { RenameIt.new(src_path, dest_path, src_name, dest_name) }

  before do
    FileUtils.rm_rf('Example') if File.exist?('Example')    
    FileUtils.mkdir_p(src_path)
  end

  after do
    FileUtils.rm_rf('Example') if File.exist?('Example')
  end

  it "should copy the source directory to the destination" do
    rename_it.run
    expect(File.exist?(dest_path)).to be_truthy
  end

  it "should rename subdirectories that match the src name" do
    FileUtils.mkdir_p(File.join(src_path, src_name))
    rename_it.run
    expect(File.exist?(File.join(dest_path, dest_name))).to be_truthy
  end

  it "should rename subdirectories that match the src name with a suffix" do
    FileUtils.mkdir_p(File.join(src_path, src_name+'Suffix'))
    rename_it.run
    expect(File.exist?(File.join(dest_path, dest_name+'Suffix'))).to be_truthy
  end

  it "should rename subdirectories that match the src name with a prefix" do
    FileUtils.mkdir_p(File.join(src_path, 'Prefix'+src_name))
    rename_it.run
    expect(File.exist?(File.join(dest_path, 'Prefix'+dest_name))).to be_truthy
  end

  it "should rename subdirectories that match the src name with a suffix and prefix" do
    FileUtils.mkdir_p(File.join(src_path, 'Prefix'+src_name+'Suffix'))
    rename_it.run
    expect(File.exist?(File.join(dest_path, 'Prefix'+dest_name+'Suffix'))).to be_truthy
  end

  it "should rename subdirectories recursively" do
    FileUtils.mkdir_p(File.join(src_path, 'SubFolder', src_name))
    rename_it.run
    expect(File.exist?(File.join(dest_path, 'SubFolder', dest_name))).to be_truthy
  end

  it "should rename files that match the src name" do
    FileUtils.touch(File.join(src_path, src_name))
    rename_it.run
    expect(File.exists?(File.join(dest_path, dest_name))).to be_truthy
  end

  it "should rename files that match the src name with a suffix" do
    FileUtils.touch(File.join(src_path, src_name+'Suffix'))
    rename_it.run
    expect(File.exists?(File.join(dest_path, dest_name+'Suffix'))).to be_truthy
  end

  it "should rename files that match the src name with a prefix" do
    FileUtils.touch(File.join(src_path, 'Prefix'+src_name))
    rename_it.run
    expect(File.exists?(File.join(dest_path, 'Prefix'+dest_name))).to be_truthy
  end

  it "should rename files that match the src name with a suffix and prefix" do
    FileUtils.touch(File.join(src_path, 'Prefix'+src_name+'Suffix'))
    rename_it.run
    expect(File.exists?(File.join(dest_path, 'Prefix'+dest_name+'Suffix'))).to be_truthy
  end

  it "should find and replace the src name with the replacement in all the file content" do
    content_src_file = File.join(src_path, 'content_example.txt')
    contact_dest_file = File.join(dest_path, 'content_example.txt')
    File.write(content_src_file, "Sample content that contains the #{src_name} in it.")
    rename_it.run    
    expect(File.read(contact_dest_file)).to eq "Sample content that contains the #{dest_name} in it."
  end  

  it "should find and replace the src name with the replacement in all the file content recursively" do
    FileUtils.mkdir_p(File.join(src_path, 'SubFolder'))
    content_src_file = File.join(src_path, 'SubFolder', 'content_example.txt')
    contact_dest_file = File.join(dest_path, 'SubFolder', 'content_example.txt')
    File.write(content_src_file, "Sample content that contains the #{src_name} in it.")
    rename_it.run    
    expect(File.read(contact_dest_file)).to eq "Sample content that contains the #{dest_name} in it."
  end  

end