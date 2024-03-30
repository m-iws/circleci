# rails_helperの読み込み
require 'spec_helper'

#80番ポートを指定
listen_port = 80

#指定されたポートをlistenしているか確認
describe port(listen_port) do
  it { should be_listening }
end

describe package('git') do
  it { should be_installed }
end      

describe package('nginx') do
  it { should be_installed }
end
