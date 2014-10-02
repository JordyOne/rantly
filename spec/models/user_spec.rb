require 'spec_helper'

describe "User", :type => :model do

  it { should respond_to(:rant)}
  it { should respond_to(:relationships)}

end