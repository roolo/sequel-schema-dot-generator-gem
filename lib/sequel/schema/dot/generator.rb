require 'sequel/schema/dot/generator/version'
require 'erb'
require 'logger'
require 'sequel'

module Sequel
  module Schema
    module Dot
      # Module for generating Sequel schema structure into Dot language format
      module Generator
        class Generator
          @db = nil
          @dot_template_path = nil
          @logger = nil

          # @todo Consider write the params as block
          #
          # @param [Hash] params Setup of Generator instance
          #   :db                   [Sequel::Database]  required From this one will be generated the diagram
          #   :logger               [Logger]            optional Will be used for logging
          #   :dot_template_path    [String]            optional Template is supposed to be ERB template. Will be used as template for resulting Dot file
          #
          def initialize params
            check_params params

            @db     = params[:db]
            @logger = params[:logger] || Logger.new(STDERR)
            @dot_template_path = params[:dot_template_path] || File.join(File.dirname(__FILE__), 'generator/diagram.dot.erb')
          end

          # @return [String] Content which can be passed to dot parsing tool
          def generate
            relations = []
            tables    = []
  
            @db.tables.each do |table_name|
              next if table_name == :schema_info
              tables << [table_name, @db[table_name]]

              # foreign keys by <table>_id name format
              # @todo Read it from model
              @db[table_name].columns.each do |column_name|
                next unless column_name =~ /_id$/
                foreign_column = column_name.to_s
                foreign_table = foreign_column.gsub(/_id$/, '')
                relations << [foreign_table, 'id', table_name, foreign_column]
              end
            end

            ERB.new( File.read(@dot_template_path),nil,'>' ).result(binding)
          end

          private

          # Checks if all parameters for new Object are alright
          def check_params params
            unless  params[:db].is_a?Sequel::Database
              raise 'Database connection is supposed to be Sequel::Database. %s given'%params[:database_connection].class.name
            end
            unless  params[:dot_template_path].nil? || params[:dot_template_path].is_a?(String) || File.exist?(params[:dot_template_path])
              raise 'Template path is supposed to be string with an existing file. %s given'%params[:dot_template_path].inspect
            end
            unless  params[:logger].nil? || params[:logger].is_a?(Logger)
              raise 'Logger is supposed to be... Logger, know. %s given'%params[:logger].inspect
            end
          end
        end
      end
    end
  end
end
