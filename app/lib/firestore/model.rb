module Firestore
  class Model
    def self.attributes(fields)
      define_singleton_method(:allowed_attributes) do
        fields
      end

      define_method(:allowed_attributes) do
        fields + [:id]
      end
    end

    def self.all(where = [])
      ::Firestore::Index.new(self.name.downcase, where: where).process.map do |node|
        self.new(**node)
      end
    end

    # def self.find_by(**args)
    #   all.select { }
    # end

    def self.find(id)
      data = ::Firestore::Show.new(self.name.downcase, id).process
      self.new(**data)
    end

    def self.create(**payload)
      raise(StandardError.new("Invalid field in use")) if (payload.keys - allowed_attributes).length >= 1
      data = ::Firestore::Create.new(self.name.downcase, payload).process
      self.new(**data)
    end

    # def self.belongs_to(klass)
    #   define_singleton_method(key.to_sym) do
    #     value
    #   end
    # end

    # def self.has_many(klass)
    #   define_singleton_method(klass.pluralize.to_sym) do
    #     klass.capitalize.constantize.all
    #   end
    # end

    # def self.has_one(klass)
    #   define_singleton_method(klass.to_sym) do
    #     klass.capitalize.constantize.find("#{self.class.name.underscore}_id")
    #   end
    # end

    attr_reader(:class_name, :initial_data)

    def initialize(**data)
      @class_name = self.class.name.downcase
      @initial_data = data
      define_attributes!(data)
    end

    def save(payload)
      raise(StandardError.new("Invalid field in use")) if (payload.keys - allowed_attributes).length >= 1
      data = ::Firestore::Update.new(class_name, id, payload).process
      define_attributes!(data)
    end

    def destroy
      ::Firestore::Delete.new(class_name, id).process
    end

    private

    def define_attributes!(data)
      data.each do |key, value|
        if allowed_attributes.include?(key)
          define_singleton_method(key.to_sym) do
            value
          end
        else
          raise(StandardError("#{key} is unallowed"))
        end
      end
    end
  end
end