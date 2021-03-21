# frozen_string_literal: true

module SharedServiceObjectSpecs
    RSpec.shared_examples 'successful call' do
      it 'returns success result' do
        expect(subject.success?).to be true
      end
    end
  
    RSpec.shared_examples 'unsuccessful call' do
      it 'returns failed result' do
        expect(subject.failure?).to be true
      end
    end
  end
  