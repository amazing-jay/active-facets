FactoryGirl.define do
  factory :resource_a do

    explicit_attr { 'explicit_attr' }
    implicit_attr { 'implicit_attr' }
    custom_attr { 'custom_attr' }
    nested_accessor { { nested_attr: 'nested_attr'} }
    dynamic_accessor { 'dynamic_accessor' }
    private_accessor { 'private_accessor' }
    aliased_accessor { 'aliased_accessor' }
    from_accessor { 'from_accessor' }
    to_accessor { 'to_accessor' }
    compound_accessor { 'compound_accessor' }
    nested_compound_accessor { 'nested_compound_accessor' }
    unexposed_attr { 'unexposed_attr' }

    trait :with_parent do
      parent { FactoryGirl.create :resource_a }
    end

    trait :with_master do
      master { FactoryGirl.create :resource_b }
    end

    trait :with_leader do
      leader { FactoryGirl.create :resource_b }
    end

    trait :with_children do
      children { create_list(:resource_a, 3) }
    end

    trait :with_others do
      others { create_list(:resource_b, 3) }
    end

    trait :extras do
      extras { create_list(:resource_b, 3) }
    end
  end
end
