require 'ghaki/app/mixer'

describe Ghaki::App::Mixer do

  class TestUsing
    include Ghaki::App::Mixer
  end

  context 'class using include' do
    subject { TestUsing }
    it { should respond_to :app_engine_eigen_mixin }
    it { should respond_to :app_engine_class_mixin }
    it { should respond_to :app_engine_mixin }
  end

  context 'using eigen mixin' do
    class TestEigen
      include Ghaki::App::Mixer
      app_engine_eigen_mixin :app_eigen
    end
    subject { TestEigen }
    it { should respond_to :app_eigen }
  end

  context 'using class mixin' do
    class TestKlass
      include Ghaki::App::Mixer
      app_engine_class_mixin :app_klass
    end
    subject { TestKlass.new }
    it { should respond_to :app_klass }
  end

  context 'using mixed mixin' do

    class TestMixed
      include Ghaki::App::Mixer
      app_engine_mixin :app_mixed
    end

    context 'with eigen access' do
      subject { TestMixed }
      it { should respond_to :app_mixed }
    end

    context 'with class access' do
      subject { TestMixed.new }
      it { should respond_to :app_mixed }
    end

  end

end
