require 'spec_helper'

describe 'logstash' do
  context 'supported operating systems' do
    on_supported_os.each do |os, facts|
      context "on #{os}" do
        let(:facts) do
          facts
        end

        context "logstash class without any parameters" do
          let(:params) {{ }}

          it { should compile.with_all_deps }

          it { should contain_class('logstash') }
          it { should contain_class('logstash::params') }
          it { should contain_class('logstash::install').that_comes_before('logstash::service') }
          it { should contain_class('logstash::service') }

          it { should contain_service('logstash') }

          it do
            should contain_file('/opt/logstash')
              .with({
                'ensure' => 'directory',
                'owner' => 'logstash',
                'group' => 'logstash',
                'mode' => '0750',
              })
              .that_comes_before('Class[staging]')
          end

          it do
            should contain_class('staging')
              .with({
                'path'  => '/opt/logstash/.staging',
                'mode'  => '0700',
              })
          end

          it do
            should contain_staging__file('logstash-2.0.0.tar.gz')
              .with({
                'source' => 'https://download.elastic.co/logstash/logstash/logstash-2.0.0.tar.gz',
              })
          end

          it do
            should contain_staging__extract('logstash-2.0.0.tar.gz')
              .with({
                'target' => '/opt/logstash',
                'creates' => '/opt/logstash/logstash-2.0.0/NOTICE.TXT',
              })
              .that_requires('Staging::File[logstash-2.0.0.tar.gz]')
          end

          it do
            should contain_file('/etc/logstash')
              .with({
                'ensure' => 'directory',
                'owner' => 'logstash',
                'group' => 'logstash',
                'mode' => '0750',
              })
              .that_requires('Staging::File[logstash-2.0.0.tar.gz]')
          end

          it do
            should contain_file('/etc/logstash/conf.d')
              .with({
                'ensure' => 'directory',
                'owner' => 'logstash',
                'group' => 'logstash',
                'mode' => '0750',
              })
              .that_requires('File[/etc/logstash]')
          end

          it do
            should contain_file('/etc/init.d/logstash')
              .with({
                'ensure' => 'present',
                'owner' => 'root',
                'group' => 'root',
                'mode' => '0775',
              })
               
          end

          it do 
            should contain_file('/opt/logstash/latest')
              .with({
                'ensure' => 'link',
                'owner' => 'logstash',
                'group' => 'logstash',
                'target' => '/opt/logstash/logstash-2.0.0',
              })
              .that_requires('Staging::Extract[logstash-2.0.0.tar.gz]')
          end
        end
      end
    end
  end
end
