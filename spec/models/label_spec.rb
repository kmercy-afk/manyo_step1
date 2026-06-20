require 'rails_helper'

RSpec.describe Label, type: :model do
  describe 'Validation test' do
    context 'If the label name is an empty string' do
      it 'Validation fails' do
        label = Label.new(name: '')
        expect(label).not_to be_valid
      end
    end

    context 'If the label name has a value' do
      it 'Validation succeeds' do
        label = Label.new(name: 'label_1')
        expect(label).to be_valid
      end
    end
  end
end