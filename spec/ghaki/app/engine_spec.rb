require 'ghaki/app/engine'

describe Ghaki::App::Engine do
  subject { Ghaki::App::Engine }
  it { should respond_to :instance }
end
