module Runable
  extend ActiveSupport::Concern

  included do
    def self.run(*args)
      new(*args).run
    end
  end

  def initialize(*args)
    args.first.each {|k, v| self.send("#{k}=", v)} unless args.empty? || args.first.nil?
  end

end
