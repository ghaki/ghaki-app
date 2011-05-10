require 'ghaki/app/mixin'

describe Ghaki::App::Mixin do

  describe 'using include' do
    class TestInclude
      include Ghaki::App::Mixin
    end
    subject { TestInclude.new }
    it { should respond_to :app }
  end

  describe 'using extend' do
    class TestExtend
      extend Ghaki::App::Mixin
    end
    subject { TestExtend }
    it { should respond_to :app }
  end

end
