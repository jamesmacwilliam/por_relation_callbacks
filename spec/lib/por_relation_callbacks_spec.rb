require 'spec_helper'

class Test
  include PorRelationCallbacks

  after_add :after_add_action

  after_remove :after_remove_action

  callbacks_for :my_relation

  def after_remove_action(_) end
  def after_add_action(_) end
end

RSpec.describe PorRelationCallbacks do
  let(:before_relation) { [] }
  let(:after_relation)  { [] }
  let(:test_object)  { double(update_attributes: "", reload: "") }

  subject(:test_wrapper) { Test.new(test_object, {}) }

  before do
    allow(test_object).to receive(:my_relation).
      and_return(before_relation, after_relation)
    allow(ActiveRecord::Base).to receive(:transaction).and_yield
  end

  after { test_wrapper.save }

  context "when things were added to relation" do
    before { after_relation.push(1) }

    it { is_expected.not_to receive(:after_remove_action) }
    it { is_expected.to     receive(:after_add_action) }
  end

  context "when things were removed from relation" do
    before { before_relation.push(1) }

    it { is_expected.not_to receive(:after_add_action) }
    it { is_expected.to     receive(:after_remove_action) }
  end
end
