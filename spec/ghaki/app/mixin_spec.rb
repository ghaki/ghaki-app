require 'ghaki/app/mixin'

describe Ghaki::App::Mixin do
  class Tester
    include Ghaki::App::Mixin
  end
  describe 'class using include' do
    subject { Tester.new }
    it { should respond_to :app }
  end
end
