module Library
  module Commentable

    @@total_comments_counter = 0

    def self.included(base)
      base.send :extend, ClassMethods
      base.send :prepend, Initializer
    end

    module ClassMethods

      def comments_quantity
        self.class_variable_get :@@comments_counter
      end

      def inc_comment_or_init increment = 0
        if self.class_variables.include? :@@comments_counter
          self.class_variable_set :@@comments_counter, self.class_variable_get(:@@comments_counter) + increment
        else
          self.class_variable_set :@@comments_counter, 0 
        end
      end

    end

    module Initializer
      def initialize *args
        self.class.inc_comment_or_init
        @comments = []
        super *args
      end
    end

    def self.total_comments_quantity
      @@total_comments_counter
    end

    def add_comment comment = ""
      self.class.inc_comment_or_init 1
      @@total_comments_counter += 1
      @comments << comment
    end

    def comments
      @comments
    end

  end
end
