require 'spec_helper'

RSpec.describe 'a nested SoberSwag::Blueprint' do
  let(:target) { { id: 1, ceo: { id: 1, name: 'Mark' } } }

  let(:person_blueprint) do
    SoberSwag::Blueprint.define do
      identifier 'Person'
      field :id, primitive(:Integer)
      field :name, primitive(:String)
    end
  end

  let(:company_blueprint) do
    pb = person_blueprint
    SoberSwag::Blueprint.define do
      identifier 'Company'
      field :id, primitive(:Integer)
      field :ceo, pb
    end
  end

  describe 'the returned serializer' do
    subject { company_blueprint }
    it { should respond_to(:serialize) }
    it { should respond_to(:type) }
    it { should respond_to(:base) }
  end

  describe 'serializing' do
    it 'does so without error' do
      expect { company_blueprint.serialize(target) }.to_not raise_error
    end
    it 'serializes properly' do
      expect(company_blueprint.serialize(target)).to eq(target)
    end
    it 'roundtrips' do
      expect {
        company_blueprint.type.new(company_blueprint.serialize(target))
      }.to_not raise_error
    end
  end
end
