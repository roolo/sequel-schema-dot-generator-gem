require 'sequel/schema/dot/generator/version'
require 'erb'
require 'logger'
require 'sequel'
require 'active_support/inflector'

module Sequel
  module Schema
    module Dot
      # Module for generating Sequel schema structure into Dot language format
      module Generator
        class Generator
          @db     = nil
          @dot_template_path    = nil
          @logger = nil
          @colored_associations = nil

          # @todo Consider write the params as block
          #
          # @param [Hash] params Setup of Generator instance
          #   :db                   [Sequel::Database]  required From this one will be generated the diagram
          #   :logger               [Logger]            optional Will be used for logging
          #   :dot_template_path    [String]            optional Template is supposed to be ERB template. Will be used as template for resulting Dot file
          #   :colored_associations [Boolean]           optional Whether lines representing associations will be draw in color (=False)
          #
          def initialize params
            check_params params

            @db     = params[:db]
            @logger = params[:logger] || Logger.new(STDERR)
            @dot_template_path    = params[:dot_template_path] || File.join(File.dirname(__FILE__), 'generator/diagram.dot.erb')
            @colored_associations = params[:colored_associations]
          end

          # @return [String] Content which can be passed to dot parsing tool
          def generate
            relations = []
            tables    = []

            @db.tables.each do |table_name|
              next if table_name == :schema_info
              tables << [table_name, @db.schema(table_name)]

              # foreign keys by <table>_id name format
              # @todo Read it from model
              @db[table_name].columns.select{|cn|cn=~/_id$/}.each do |column_name|
                foreign_column = column_name.to_s
                foreign_table = existing_table_name foreign_column.gsub(/_id$/, '')
                relations << [foreign_table, 'id', table_name, foreign_column]
              end
            end

            if @colored_associations
              edge_colors = random_color_set relations.count
            else
              edge_colors = Array.new relations.count, '000000'
            end

            ERB.new( File.read(@dot_template_path),nil,'>' ).result(binding)
          end

          private

          # @param  [String] name
          #
          # @return [String] form of name param in which it is name of existing table
          def existing_table_name name
            tables = @db.tables.map(&:to_s)
            table_name = name if tables.include? name
            table_name ||= name.pluralize if tables.include? name.pluralize
            table_name ||= name.singularize if tables.include? name.singularize
            table_name ||= 'association_table_not_found'

            table_name
          end

          # @param  [Integer] number of colors we want to generate
          #
          # @return [Array]   of random and unique colors
          def random_color_set number
            raise 'Number of colors must be greater than 0' if number < 1
            colors = []
            (1..number).each do
              colors << random_unique_hex_color(colors)
            end

            colors
          end


          # @param [Array] existing colors which should be avoided
          #
          # @return [String] Random color which is not presented in existing param
          def random_unique_hex_color existing
            color = '%06x' % (rand * 0xffffff)
            if existing.include?(color)
              random_unique_hex_color existing
            else
              color
            end
          end

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
            unless  params[:colored_associations].nil? || !!params[:colored_associations] == params[:colored_associations]
              raise 'Colored association is supposed to be boolean. %s given'%params[:colored_associations].inspect
            end
          end
        end
      end
    end
  end
end
