require 'ghaki/app/plugin'
require 'ghaki/app/mixable'

describe Ghaki::App::Mixable do

  class UsingMixable
    include Ghaki::App::Mixable
  end

  describe 'class using include' do
    subject { UsingMixable }
    it { should respond_to :app_mixin_reader }
    it { should respond_to :app_mixin_writer }
    it { should respond_to :app_mixin_accessor }
  end

  class Cow
    def initialize opts={} ; end
  end

  class TheCow < Ghaki::App::Plugin
    app_plugin_link Cow, :cow
  end

  describe '#app_mixin_reader' do

    describe 'using source only' do
      class UsingReaderSourceOnly
        include Ghaki::App::Mixable
        app_mixin_reader TheCow, :cow
      end
      subject { UsingReaderSourceOnly.new }
      it { should respond_to :cow }
      it { subject.cow.should be_an_instance_of(Cow) }
    end

    describe 'using source and target' do
      class UsingReaderSourceAndTarget
        include Ghaki::App::Mixable
        app_mixin_reader TheCow, :cow, :bull
      end
      subject { UsingReaderSourceAndTarget.new }
      it { should respond_to :bull }
      it { subject.bull.should be_an_instance_of(Cow) }
    end

  end

  describe '#app_mixin_writer' do
    class UsingWriter
      include Ghaki::App::Mixable
      app_mixin_writer :cow
    end
    subject { UsingWriter.new }
    it { should respond_to :cow= }
  end

  describe '#app_mixin_accessor' do

    describe 'using source only' do
      class UsingAccessorSourceOnly
        include Ghaki::App::Mixable
        app_mixin_accessor Cow, :cow
      end
      subject { UsingAccessorSourceOnly.new }
      it { should respond_to :cow }
      it { should respond_to :cow= }
    end
    
    describe 'using source and target' do
      class UsingAccessorSourceAndTarget
        include Ghaki::App::Mixable
        app_mixin_accessor Cow, :cow, :bull
      end
      subject { UsingAccessorSourceAndTarget.new }
      it { should respond_to :bull }
      it { should respond_to :bull= }
    end

  end

end
