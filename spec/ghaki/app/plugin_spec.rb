require 'ghaki/app/plugin'

describe Ghaki::App::Plugin do

  class UsingPlugin < Ghaki::App::Plugin
  end

  describe 'class extended by' do
    subject { UsingPlugin }
    it { should respond_to :app_plugin_make }
    it { should respond_to :app_plugin_link }
  end

  class Chicken
    def initialize opts={}; end
  end

  describe '#app_plugin_make' do
    class ChickenApp < Ghaki::App::Plugin
      app_plugin_make Chicken, :chicken
    end
    subject { ChickenApp.instance }
    describe 'generated plugin' do
      it { should respond_to :chicken }
      it { should respond_to :chicken= }
      it { should respond_to :chicken_opts }
      it { should respond_to :chicken_opts= }
      it { should respond_to :chicken_defs }
      it { should respond_to :chicken_defs= }
      it { subject.chicken.should be_an_instance_of(Chicken) }
    end
  end

  class Cow
    def initialize opts={}; end
  end

  describe '#app_plugin_link' do

    describe 'using source only' do
      class CowSourceOnly < Ghaki::App::Plugin
        app_plugin_make Cow, :cow
        app_plugin_link :cow
      end
      describe 'generated plugin' do
        subject { CowSourceOnly.instance }
        it { should respond_to :cow }
        it { subject.cow.should be_an_instance_of(Cow) }
      end
      describe 'updated engine' do
        subject { Ghaki::App::Engine.instance }
        it { should respond_to :cow }
        it { subject.cow.should be_an_instance_of(Cow) }
      end
    end

    describe 'using source and target' do
      class CowSourceAndTarget < Ghaki::App::Plugin
        app_plugin_make Cow, :cow
        app_plugin_link :cow, :bull
      end
      describe 'generated plugin' do
        subject { CowSourceAndTarget.instance }
        it { should respond_to :cow }
        it { subject.cow.should be_an_instance_of(Cow) }
      end
      describe 'updated engine' do
        subject { Ghaki::App::Engine.instance }
        it { should respond_to :bull }
        it { subject.bull.should be_an_instance_of(Cow) }
      end
    end

  end

end
