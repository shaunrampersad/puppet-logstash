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
            should contain_class('staging').with({
              'path'  => '/opt/logstash/.staging',
              'mode'  => '0700',
              'owner' => 'logstash',
              'group' => 'logstash',
            })
          end

          it do
            should contain_staging__file('logstash-2.0.0.tar.gz').with({
              'source' => 'https://download.elastic.co/logstash/logstash/logstash-2.0.0.tar.gz',
            })
          end

          it { should contain_file('/etc/logstash').with({
            'ensure' => 'directory',
            'owner' => 'logstash',
            'group' => 'logstash',
            'mode' => '0640',
          })}

          it { should contain_file('/etc/logstash/conf.d').with({
            'ensure' => 'directory',
            'owner' => 'logstash',
            'group' => 'logstash',
            'mode' => '0640',
          })}

          it { should contain_file('/etc/init.d/logstash').with({
            'ensure' => 'present',
            'owner' => 'root',
            'group' => 'root',
            'mode' => '0775',
          })}


          it { should contain_file('/opt/logstash/latest').with({
            'ensure' => 'link',
            'owner' => 'logstash',
            'group' => 'logstash',
            'target' => '/opt/logstash/logstash-2.0.0',
          })}

        end
      end
    end
  end

#  context 'unsupported operating system' do
#    describe 'logstash class without any parameters on Solaris/Nexenta' do
#      let(:facts) do
#        {
#          :kernel        => 'Solaris',
#        }
#      end

#      it { expect { should contain_service('logstash') }.to raise_error(Puppet::Error, /Nexenta not supported/) }
#    end
#  end
end
