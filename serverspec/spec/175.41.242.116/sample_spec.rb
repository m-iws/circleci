# rails_helperの読み込み
require 'spec_helper'

describe package('git') do
  it { should be_installed }
end      

def os_platform_amazon?
  Specinfra.backend.run_command('uname -r').stdout.include?("amzn1")
end