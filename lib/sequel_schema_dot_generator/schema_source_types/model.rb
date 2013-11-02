module Sequel
  module Schema
    module Dot
      module Generator
        module SchemaSourceType
          class Model < SchemaSourceType::Base
            def relations
              relations = {}

              @tables.collect do |table_name|
                model = table_name.to_s.singularize.classify.constantize
                model.associations.each do |assoc|
                  assoc_info = model.association_reflection(assoc)

                  right_key = assoc_info[:join_table].to_s+assoc_info[:right_key].to_s
                  left_key = assoc_info[:join_table].to_s+assoc_info[:left_key].to_s

                  if assoc_info[:type] == :many_to_many
                    relations[right_key] = [assoc_info[:join_table].to_s, assoc_info[:right_key], assoc_info[:class_name].constantize.implicit_table_name, assoc_info[:class_name].constantize.primary_key]
                    relations[left_key] = [assoc_info[:join_table].to_s, assoc_info[:left_key],  assoc_info[:model].implicit_table_name, assoc_info[:model].primary_key]
                  else
                    # one_to_many
                    table_name = assoc_info[:model].implicit_table_name.to_s
                    table_key = assoc_info[:key].to_s
                    relations[right_key] = [table_name, table_key, assoc_info[:class_name].constantize.implicit_table_name, assoc_info[:class_name].constantize.primary_key]
                  end
                end
              end
              relations.values
            end
          end
        end
      end
    end
  end
end
