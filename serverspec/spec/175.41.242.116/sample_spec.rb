# rails_helperの読み込み
require 'spec_helper'

describe package('git') do
  it { should be_installed }
end      

if os_platform_amazon?
  %w{aws-cli s3cmd}.each do |pkg|
    describe package(pkg) do
      it { should be_installed }
    end
