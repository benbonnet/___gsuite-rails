module Firestore
  class Model
    def self.all
      ::Firestore::Index.new(self.name.downcase).process.map do |node|
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

    attr_reader(:class_name)

    def initialize(**data)
      @class_name = self.class.name.downcase
      data.each do |key, value|
        define_singleton_method(key.to_sym) do
          value
        end
      end
    end

    def save(payload)
      ::Firestore::Update.new(
        class_name,
        id,
        payload
      ).process
    end

    def destroy
      ::Firestore::Delete.new(class_name, id).process
    end
  end
end