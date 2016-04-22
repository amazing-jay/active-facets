require 'spec_helper'

describe ActiveFacet::DocumentCache do

  describe ".fetch" do
    let(:facade) { ActiveFacet::Serializer::Facade.new(serializer, resource, options)}
    let(:options) { make_options({fields: [:basic, :children, :master]}) }
    let(:resource) { create :resource_a, :with_children, :with_master }
    let(:cache_opts) { { force: force } }
    let(:force) { false }
    let(:serializer) { V1::ResourceA::ResourceASerializer.instance }

    let(:natural_result) { { a: :b } }
    let(:cached_result) { { c: :d } }
    let(:fetched_result) { { c: :d } }

    subject { described_class.fetch(facade, cache_opts) { natural_result } }
    let(:cached_subject) { described_class.fetch(facade) { cached_result } }
    let(:fetched_subject) { described_class.fetch(facade) { fetched_result } }

    before do
      temp = ActiveFacet.cache_enabled
      ActiveFacet.cache_enabled = true
      cached_subject
      ActiveFacet.cache_enabled = temp
    end

    context "cache disabled" do
      it { expect(subject).to eq( natural_result ) }
      it { expect(cached_subject).to eq( cached_result ) }
      it { expect(fetched_subject).to eq( fetched_result ) }
    end

    context "cache enabled" do
      before do
        temp = ActiveFacet.cache_enabled
        ActiveFacet.cache_enabled = true
        subject
        ActiveFacet.cache_enabled = temp
      end

      it { expect(subject).to eq( cached_result ) }
      it { expect(cached_subject).to eq( cached_result ) }
      it { expect(fetched_subject).to eq( cached_result ) }

      context "forced" do
        context "context" do
          let(:force) { true }
          it { expect(subject).to eq( natural_result ) }
          it { expect(cached_subject).to eq( cached_result ) }
          it { expect(fetched_subject).to eq( fetched_result ) }
        end
        context "configuration" do
          around do |example|
            Rails.cache.clear
            temp = ActiveFacet::default_cache_options
            ActiveFacet::default_cache_options = { force: true }
            example.run
            ActiveFacet::default_cache_options = temp
          end
          it { expect(subject).to eq( natural_result ) }
          it { expect(cached_subject).to eq( cached_result ) }
          it { expect(fetched_subject).to eq( fetched_result ) }
        end
      end

      context "miss" do
        before do
          allow(described_class).to receive(:digest_key).and_return("a", "b")
          subject
        end
        it { expect(subject).to eq( natural_result ) }
        it { expect(fetched_subject).to eq( fetched_result ) }
      end
    end
  end

  describe ".fetch_association" do
    skip ("abstract method intentionally not implemented")
  end

  describe ".digest_key" do
    subject { described_class.digest_key(facade) }
    let(:facade) { double("facade") }
    before do
      allow(facade).to receive(:cache_key) { 3 }
      subject
    end
    it { expect(facade).to have_received(:cache_key) }
    it { expect(subject).to eq('d684aece5c3b9b5a45f0acd5bad3b872') }
  end

  describe ".cacheable?" do
    subject { described_class.cacheable?(facade) }
    let(:facade) { double("facade", :opts => {
      ActiveFacet.cache_bypass_key => cache_bypass,
      ActiveFacet.cache_force_key => cache_force
    } ) }
    let(:cache_bypass) { false }
    let(:cache_force) { false }
    let(:enabled) { true }
    around do |example|
      temp = ActiveFacet.cache_enabled
      ActiveFacet.cache_enabled = enabled
      example.run
      ActiveFacet.cache_enabled = temp
    end

    it { expect(subject).to eq(enabled) }
    context "cache force enabled" do
      let(:cache_force) { true }
      it { expect(subject).to eq(enabled) }
    end

    context "cache bypass enabled" do
      let(:cache_bypass) { true }
      it { expect(subject).to be false }
    end

    context "disabled" do
      let(:enabled) { false }
      it { expect(subject).to be false }
    end
  end
end