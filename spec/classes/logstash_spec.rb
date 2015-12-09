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

          it { is_expected.to compile.with_all_deps }

          it { is_expected.to contain_class('logstash') }
          it { is_expected.to contain_class('logstash::params') }
#          it { is_expected.to contain_class('logstash::install').that_comes_before('logstash::config') }
#          it { is_expected.to contain_class('logstash::config') }
#          it { is_expected.to contain_class('logstash::service').that_subscribes_to('logstash::config') }

#          it { is_expected.to contain_service('logstash') }
#          it { is_expected.to contain_package('logstash').with_ensure('present') }

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

#      it { expect { is_expected.to contain_package('logstash') }.to raise_error(Puppet::Error, /Nexenta not supported/) }
#    end
#  end
end
