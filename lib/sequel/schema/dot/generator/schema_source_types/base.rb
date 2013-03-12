module Sequel
  module Schema
    module Dot
      module Generator
        module SchemaSourceType
          class Base
            # Initialize Schema Source Type
            #
            # Tables could be retrieved from db connection, but there is plan to provide
            # control over what tables will be in output structure
            #
            # @param [Sequel::Database] db     for which should be acquired data
            # @param [Array]            tables for which should be acquired data
            def initialize db, tables
              @tables = tables
              @db = db
            end

            # @return [Array] associations for tables given to constructor
            #   Each item is array of [<foreign_table>, <id>, <table_name>, <foreign_column>]
            def relations
              raise NotImplementedError
            end
          end
        end
      end
    end
  end
end
