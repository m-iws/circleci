# rails_helperの読み込み
require 'spec_helper'

#80番ポートを指定
listen_port = 80

#追加テスト01（rubyが指定のバージョンでインストールされているか確認）
describe command('ruby -v') do
  let(:path) { '/home/ec2-user/.rbenv/shims:$PATH' }
  its(:stdout) { should match /ruby 3.2.3/ }
end

#Nginxがインストールされているか確認
describe package('nginx') do
  it { should be_installed }
end

#追加テスト02（Nginxが起動しているか確認）
describe service('nginx') do
  it { should be_running }
end

#指定されたポートをlistenしているか確認
describe port(listen_port) do
  it { should be_listening }
end

#curlでHTTPアクセスして200 OKが返ってくるか確認する
describe command('curl http://127.0.0.1:#{listen_port}/_plugin/head/ -o /dev/null -w "%{http_code}\n" -s') do
  its(:stdout) { should match /^200$/ }
end
