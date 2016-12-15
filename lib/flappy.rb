# encoding: utf-8

require 'thor'
require 'logger'
require 'yaml'
require 'json'
require 'securerandom'
require 'fileutils'
require 'tempfile'

# TODO: remove rescue when https://github.com/tajchert/ruby_apk/pull/4 merged
begin
  require 'ruby_android'
rescue LoadError
  require 'ruby_apk'
end

require 'flappy/patches'
require 'flappy/util'
require 'flappy/version'
require 'flappy/cli'

module Flappy
  include Util
end
