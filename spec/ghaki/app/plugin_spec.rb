require 'ghaki/app/plugin'

describe Ghaki::App::Plugin do

  describe 'class extended by' do
    class UsingPlugin < Ghaki::App::Plugin ; end
    subject { UsingPlugin }
    it { should respond_to :app_plugin_make }
    it { should respond_to :app_plugin_link }
  end


  describe '#app_plugin_make' do
    class Chicken
      def initialize opts={}; end
    end
    class ChickenApp < Ghaki::App::Plugin
      app_plugin_make Chicken, :chicken
    end
    subject { ChickenApp.instance }
    context 'using source <chicken>' do
      context 'generates plugin' do
        it { should respond_to :chicken }
        it { should respond_to :chicken= }
        it { should respond_to :chicken_opts }
        it { should respond_to :chicken_opts= }
        it { should respond_to :chicken_defs }
        it { should respond_to :chicken_defs= }
        it { subject.chicken.should be_an_instance_of(Chicken) }
      end
    end
  end

  class Cow
    def initialize opts={}; end
  end

  describe '#app_plugin_link' do

    context 'using source only <cow>' do
      class CowSourceOnly < Ghaki::App::Plugin
        app_plugin_make Cow, :cow
        app_plugin_link :cow
      end
      context 'generates plugin' do
        subject { CowSourceOnly.instance }
        it { should respond_to :cow }
        it { subject.cow.should be_an_instance_of(Cow) }
      end
      context 'updates engine' do
        subject { Ghaki::App::Engine.instance }
        it { should respond_to :cow }
        it { subject.cow.should be_an_instance_of(Cow) }
      end
    end

    context 'using source <cow> and target <bull>' do
      class CowSourceAndTarget < Ghaki::App::Plugin
        app_plugin_make Cow, :cow
        app_plugin_link :cow, :bull
      end
      context 'generates plugin' do
        subject { CowSourceAndTarget.instance }
        it { should respond_to :cow }
        it { subject.cow.should be_an_instance_of(Cow) }
      end
      context 'updates engine' do
        subject { Ghaki::App::Engine.instance }
        it { should respond_to :bull }
        it { subject.bull.should be_an_instance_of(Cow) }
      end
    end

  end

end
