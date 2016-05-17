require "por_relation_callbacks/version"
require "active_record"
require "active_support"

module PorRelationCallbacks
  extend ActiveSupport::Concern

  included do
    cattr_accessor :_after_add, :_after_remove, :_watched_relation
    attr_accessor :object, :prms
  end

  module ClassMethods
    def after_add(*methods)
      self._after_add = methods
    end

    def after_remove(*methods)
      self._after_remove = methods
    end

    def callbacks_for(rel)
      self._watched_relation = rel
    end
  end

  def initialize(object, prms)
    @object = object
    @prms = prms

    self._after_add    ||= []
    self._after_remove ||= []
  end

  def save
    return unless object
    ActiveRecord::Base.transaction do
      @existing_relation_state = object.send(_watched_relation).to_a
      object.update_attributes(prms)
      object.reload
      @updated_relation_state = object.send(_watched_relation).to_a
      hooks
    end
    true
  end

  private

  def hooks
    after_add
    after_remove
  end

  def after_add
    return true if _after_add.empty?
    (@updated_relation_state - @existing_relation_state).each do |rel|
      _after_add.each do |method|
        send(method, rel)
      end
    end
  end

  def after_remove
    return true if _after_remove.empty?
    (@existing_relation_state - @updated_relation_state).each do |rel|
      _after_remove.each do |method|
        send(method, rel)
      end
    end
  end
end
