require 'net/http'
require 'fileutils'
require 'os'

class GlimmerApplication
  SWT_ZIP_FILE = File.join(`echo ~`.strip, '.glimmer', 'vendor', 'swt.zip')
  SWT_JAR_FILE = File.join(File.dirname(SWT_ZIP_FILE), 'swt.jar')

  OPERATING_SYSTEMS = ["mac", "windows", "linux"]

  SWT_URL = {
    "mac_x86_64" => "http://mirror.csclub.uwaterloo.ca/eclipse/eclipse/downloads/drops4/R-4.7-201706120950/swt-4.7-cocoa-macosx-x86_64.zip",
    "linux_x86_64" => "http://mirror.cc.vt.edu/pub/eclipse/eclipse/downloads/drops4/R-4.7-201706120950/swt-4.7-gtk-linux-x86_64.zip",
    "linux_x86" => "http://mirror.csclub.uwaterloo.ca/eclipse/eclipse/downloads/drops4/R-4.7-201706120950/swt-4.7-gtk-linux-x86.zip",
    "windows_x86_64" => "http://mirror.csclub.uwaterloo.ca/eclipse/eclipse/downloads/drops4/R-4.7-201706120950/swt-4.7-win32-win32-x86_64.zip",
    "windows_x86" => "http://eclipse.mirror.rafal.ca/eclipse/downloads/drops4/R-4.7-201706120950/swt-4.7-win32-win32-x86.zip"
  }

  attr_reader :setup_requested, :application
  alias :setup_requested? :setup_requested

  # Accepts the following options string:
  # --setup app_file_path.rb
  # or
  # --setup
  # or
  # app_file_path.rb
  def initialize(options)
    @setup_requested = options.first == '--setup'
    @application = setup_requested? ? options[1] : options.first
  end

  def start
    usage unless setup_requested? || application

    setup if setup_requested? || !File.exist?(SWT_JAR_FILE)

    if application
      puts "Starting Glimmer Application #{application}"
      system "ruby #{additional_options} -J-classpath \"#{SWT_JAR_FILE}\" #{application}"
    end
  end

  def usage
    puts <<-MULTILINE
Usage: glimmer [--setup] [application_ruby_file_path.rb]

Example 1: glimmer hello_combo.rb
This runs the Glimmer application hello_combo.rb
If the SWT Jar is missing, it downloads it and sets it up first.

Example 2: glimmer --setup hello_combo.rb
This performs setup and then runs the Glimmer application hello_combo.rb
It downloads and sets up the SWT jar whether missing or not.

Example 3: glimmer --setup
This downloads and sets up the SWT jar whether missing or not.
    MULTILINE
  end

  def setup
    puts "#{SWT_JAR_FILE} is missing! Will obtain a new copy now." unless File.exist?(SWT_JAR_FILE)
    FileUtils.mkdir_p(File.dirname(SWT_ZIP_FILE))
    download(SWT_ZIP_FILE)
    puts "Unzipping #{SWT_ZIP_FILE}"
    `unzip -o #{SWT_ZIP_FILE} -d #{File.dirname(SWT_ZIP_FILE)}`
    puts "Finished unzipping"
  end

  def download(file)
    uri = URI(platform_swt_url)
    puts "Downloading #{uri}"
    File.open(file, 'w') do |f|
      f.write(Net::HTTP.get(uri))
    end
    puts "Finished downloading"
  end

  def platform_swt_url
    SWT_URL[platform_swt_url_key]
  end

  def platform_swt_url_key
    "#{platform_os}_#{platform_cpu}"
  end

  def platform_os
    OPERATING_SYSTEMS.detect {|os| OS.send("#{os}?")}
  end

  def platform_cpu
    OS.host_cpu
  end

  def additional_options
    OS.mac? ? "-J-XstartOnFirstThread" : ""
  end
end