require 'flappy/version'

module Flappy
  class CLI < Thor
    class_option :token,   type: :string,  aliases: '-T', desc: "User's API Token at fir.im"
    class_option :logfile, type: :string,  aliases: '-L', desc: 'Path to writable logfile'
    class_option :verbose, type: :boolean, aliases: '-V', desc: 'Show verbose', default: true
    class_option :quiet,   type: :boolean, aliases: '-q', desc: 'Silence commands'
    class_option :help,    type: :boolean, aliases: '-h', desc: 'Show this help message and quit'


    desc 'build_apk BUILD_DIR', 'Build Android app (alias: `ba`).'
    long_desc <<-LONGDESC
      `build_apk` command will auto build your project to an apk package
      and it also can auto publish your built apk to fir.im if use `-p` option.
      Internally, it use `gradle` to accomplish these things, use `gradle --help` to get more information.

      Example:

      $ fir ba <project dir> [-o <apk output dir> -c <changelog> -p -Q -T <your api token>]

      $ fir ba <project dir> [-f <flavor> -o <apk output dir> -c <changelog> -p -Q -T <your api token>]

      $ fir ba <git ssh url> [-B develop -o <apk output dir> -c <changelog> -p -Q -T <your api token>]
    LONGDESC
    map ['ba'] => :build_apk
    method_option :branch,    type: :string,  aliases: '-B', desc: 'Set branch if project is a git repo, the default is `master`'
    method_option :output,    type: :string,  aliases: '-o', desc: 'APK output path, the default is: BUILD_DIR/build/outputs/apk'
    method_option :publish,   type: :boolean, aliases: '-p', desc: 'true/false if publish to fir.im'
    method_option :flavor,    type: :string,  aliases: '-f', desc: 'Set flavor if have productFlavors'
    method_option :short,     type: :string,  aliases: '-s', desc: 'Set custom short link if publish to fir.im'
    method_option :name,      type: :string,  aliases: '-n', desc: 'Set custom apk name when builded'
    method_option :changelog, type: :string,  aliases: '-c', desc: 'Set changelog if publish to fir.im, support string/file'
    method_option :qrcode,    type: :boolean, aliases: '-Q', desc: 'Generate qrcode'
    method_option :open,      type: :boolean, desc: 'true/false if open for everyone, the default is: true', default: true
    method_option :password,  type: :string,  desc: 'Set password for app'
    def build_apk(*args)
      prepare :build_apk

      Flappy.build_apk(*args, options)
    end

    desc 'help', 'Describe available commands or one specific command (aliases: `h`).'
    map Thor::HELP_MAPPINGS => :help
    def help(command = nil, subcommand = false)
      super
    end

    no_commands do
      def invoke_command(command, *args)
        # logfile = options[:logfile].blank? ? STDOUT : options[:logfile]
        # logfile = '/dev/null' if options[:quiet]
        #
        # FIR.logger       = Logger.new(logfile)
        # FIR.logger.level = options[:verbose] ? Logger::INFO : Logger::ERROR
        super
      end
    end

    private

    def prepare(task)
      if options.help?
        help(task.to_s)
        fail SystemExit
      end
      $DEBUG = true if ENV['DEBUG']
    end




  end
end
