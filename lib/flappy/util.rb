# encoding: utf-8

require_relative './util/build_apk'

module Flappy
  module Util
    extend ActiveSupport::Concern

    module ClassMethods
      include Flappy::BuildApk

      attr_accessor :logger

      def fetch_user_info(token)
        get fir_api[:user_url], api_token: token
      end

      def fetch_user_uuid(token)
        user_info = fetch_user_info(token)
        user_info[:uuid]
      end

      def check_file_exist(path)
        return if File.file?(path)

        logger.error 'File does not exist'
        exit 1
      end

      # def check_supported_file(path)
      #   return if APP_FILE_TYPE.include?(File.extname(path))
      #
      #   logger.error 'Unsupported file type'
      #   exit 1
      # end

      def check_token_cannot_be_blank(token)
        return unless token.blank?

        logger.error 'Token can not be blank'
        exit 1
      end

      def check_logined
        return unless current_token.blank?

        logger.error 'Please use `fir login` first'
        exit 1
      end

      def logger_info_blank_line
        logger.info ''
      end

      def logger_info_dividing_line
        logger.info '✈ -------------------------------------------- ✈'
      end

      # def generate_rqrcode(string, png_file_path)
      #   qrcode = ::RQRCode::QRCode.new(string.to_s)
      #   qrcode.as_png(size: 500, border_modules: 2, file: png_file_path)
      #   png_file_path
      # end
    end
  end
end
