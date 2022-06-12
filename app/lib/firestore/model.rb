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

    def self.find_by(**args)
      make_where = args.map { |k, v| [k, '==', v] }
      all(make_where).first
    end

    def self.find(id)
      data = ::Firestore::Show.new(self.name.downcase, id).process
      self.new(**data).show
    end

    def self.create(**payload)
      if (payload.keys - allowed_attributes).length >= 1
        diff = payload.keys - allowed_attributes
        raise(StandardError.new("Invalid attr(s) : #{diff.to_sentence})"))
      end
      data = ::Firestore::Create.new(self.name.downcase, payload).process
      self.new(**data).show
    end

    attr_reader(:class_name, :initial_data, :data)

    def initialize(**data)
      @class_name = self.class.name.downcase
      @initial_data = data
      @data = define_attributes!(data)
    end

    def show
      data
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