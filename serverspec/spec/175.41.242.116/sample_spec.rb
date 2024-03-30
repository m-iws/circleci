# rails_helperの読み込み
require 'spec_helper'

describe package('git') do
  it { should be_installed }
end      
