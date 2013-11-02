module Sequel
  module Schema
    module Dot
      module Generator
        module SchemaSourceType
          class Column < SchemaSourceType::Base
            def relations
              relations = []

              @tables.each do |table_name|
                @db[table_name].columns.select{|cn|cn=~/_id$/}.each do |column_name|
                  foreign_column = column_name.to_s
                  foreign_table = existing_table_name foreign_column.gsub(/_id$/, '')
                  relations << [foreign_table, 'id', table_name, foreign_column]
                end
              end

              relations
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
          end
        end
      end
    end
  end
end
