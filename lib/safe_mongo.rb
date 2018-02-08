require "safe_mongo/version"
require 'fusu/concern'
module SafeMongo
  extend Fusu::Concern

  class_methods do
    def safe_mode(val = false)
      @_safe_mode = val
    end
  end

  included do
    before_create :_in_safe_mode
    before_update :_in_safe_mode
  end

  def _in_safe_mode
    with(safe: true) if @_safe_mode
  end
end

module Mongoid::Document
  include SafeMongo
end
