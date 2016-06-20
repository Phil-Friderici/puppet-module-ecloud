require 'spec_helper'
describe 'ecloud' do

  context 'with defaults for all parameters' do
    it 'should fail' do
      expect {
        should contain_class('ecloud')
      }.to raise_error(Puppet::Error,/ecloud::cmhost needs to be defined/)
    end
  end

  context 'with cmhost set' do
    let(:facts) do
      { :processorcount => 4
      }
    end
    let(:params) do
      { :cmhost => 'cmhost.example.com',
      }
    end
    it { should contain_package('electricaccelerator').with('ensure' => 'present') }
    it { should contain_file('/etc/sysconfig/ecagent.conf').with({
      'ensure' => 'file',
      'owner' => 'root',
      'group' => 'root',
      'mode' => '0644',
      'require' => 'Package[electricaccelerator]',
    }) }
    it { should contain_file('/etc/sysconfig/ecagent.conf').with_content(/^CMHOST=cmhost.example.com$/) }
    it { should contain_file('/etc/sysconfig/ecagent.conf').with_content(/^CMPORT=8030$/) }
    it { should contain_file('/etc/sysconfig/ecagent.conf').with_content(/^INSTALL_ERUNNERD=$/) }
    it { should contain_file('/etc/sysconfig/ecagent.conf').with_content(/^LOG_REMOVE=No$/) }
    it { should contain_file('/etc/sysconfig/ecagent.conf').with_content(/^LSF_HOST=n$/) }
    it { should contain_file('/etc/sysconfig/ecagent.conf').with_content(/^MAX_OPEN_FDS=$/) }
    it { should contain_file('/etc/sysconfig/ecagent.conf').with_content(/^AGENT_NUMBER=4$/) }
    it { should contain_file('/etc/sysconfig/ecagent.conf').with_content(/^REBOOT=No$/) }
    it { should contain_file('/etc/sysconfig/ecagent.conf').with_content(/^SECURE_CONSOLE=n$/) }
    it { should contain_file('/etc/sysconfig/ecagent.conf').with_content(/^TEMPDIR=\/tmp$/) }

    it { should contain_service('ecagent').with({
      'ensure' => 'running',
      'enable' => true,
    }) }
  end

  context 'with all parameters set' do
    let(:facts) do
      { :processorcount => 4
      }
    end
    let(:params) do
      { :package_name => 'ea',
        :package_ensure => '1.0',
        :service_name => 'electric',
        :service_ensure => 'stopped',
        :service_enable => false,
        :sysconfig_file => '/etc/ecloud/ecloud.conf',
        :sysconfig_ensure => 'present',
        :sysconfig_owner => 'ecloud',
        :sysconfig_group => 'users',
        :sysconfig_mode => '0640',
        :cmhost => 'cm.example.com',
        :cmport => '1050',
        :install_erunnerd => 'Yes',
        :log_remove => 'Yes',
        :lsf_host => 'y',
        :max_open_fds => '10',
        :agent_number => '5',
        :reboot => 'Yes',
        :secure_console => 'y',
        :tmp_path => '/dev/null',
      }
    end
    it { should contain_package('ea').with('ensure' => '1.0') }
    it { should contain_file('/etc/ecloud/ecloud.conf').with({
      'ensure' => 'present',
      'owner' => 'ecloud',
      'group' => 'users',
      'mode' => '0640',
      'require' => 'Package[ea]',
    }) }
    it { should contain_file('/etc/ecloud/ecloud.conf').with_content(/^CMHOST=cm.example.com$/) }
    it { should contain_file('/etc/ecloud/ecloud.conf').with_content(/^CMPORT=1050$/) }
    it { should contain_file('/etc/ecloud/ecloud.conf').with_content(/^INSTALL_ERUNNERD=Yes$/) }
    it { should contain_file('/etc/ecloud/ecloud.conf').with_content(/^LOG_REMOVE=Yes$/) }
    it { should contain_file('/etc/ecloud/ecloud.conf').with_content(/^LSF_HOST=y$/) }
    it { should contain_file('/etc/ecloud/ecloud.conf').with_content(/^MAX_OPEN_FDS=10$/) }
    it { should contain_file('/etc/ecloud/ecloud.conf').with_content(/^AGENT_NUMBER=5$/) }
    it { should contain_file('/etc/ecloud/ecloud.conf').with_content(/^REBOOT=Yes$/) }
    it { should contain_file('/etc/ecloud/ecloud.conf').with_content(/^SECURE_CONSOLE=y$/) }
    it { should contain_file('/etc/ecloud/ecloud.conf').with_content(/^TEMPDIR=\/dev\/null$/) }

    it { should contain_service('electric').with({
      'ensure' => 'stopped',
      'enable' => false,
    }) }
  end

  describe 'with invalid parameters' do
    context 'package_name' do
      let(:facts) do
        { :processorcount => 4,
        }
      end
      let(:params) do
        { :cmhost => 'cm.example.com',
          :package_name => true,
        }
      end
      it 'should fail' do
        expect {
          should contain_class('ecloud')
        }.to raise_error(Puppet::Error,/true is not a string\.  It looks to be a TrueClass/)
      end
    end

    context 'package_ensure' do
      let(:facts) do
        { :processorcount => 4,
        }
      end
      let(:params) do
        { :cmhost => 'cm.example.com',
          :package_ensure => true,
        }
      end
      it 'should fail' do
        expect {
          should contain_class('ecloud')
        }.to raise_error(Puppet::Error,/true is not a string\.  It looks to be a TrueClass/)
      end
    end

    context 'service_name' do
      let(:facts) do
        { :processorcount => 4,
        }
      end
      let(:params) do
        { :cmhost => 'cm.example.com',
          :service_name => false,
        }
      end
      it 'should fail' do
        expect {
          should contain_class('ecloud')
        }.to raise_error(Puppet::Error,/false is not a string\.  It looks to be a FalseClass/)
      end
    end

    context 'service_ensure' do
      let(:facts) do
        { :processorcount => 4,
        }
      end
      let(:params) do
        { :cmhost => 'cm.example.com',
          :service_ensure => false,
        }
      end
      it 'should fail' do
        expect {
          should contain_class('ecloud')
        }.to raise_error(Puppet::Error,/ecloud::service_ensure may be either 'running' or 'stopped' and is set to <false>/)
      end
    end

    context 'service_enable' do
      let(:facts) do
        { :processorcount => 4,
        }
      end
      let(:params) do
        { :cmhost => 'cm.example.com',
          :service_enable => "yes",
        }
      end
      it 'should fail' do
        expect {
          should contain_class('ecloud')
        }.to raise_error(Puppet::Error,/"yes" is not a boolean\.  It looks to be a String/)
      end
    end

    context 'sysconfig_file' do
      let(:facts) do
        { :processorcount => 4,
        }
      end
      let(:params) do
        { :cmhost => 'cm.example.com',
          :sysconfig_file => "yes",
        }
      end
      it 'should fail' do
        expect {
          should contain_class('ecloud')
        }.to raise_error(Puppet::Error,/"yes" is not an absolute path/)
      end
    end

    context 'sysconfig_ensure' do
      let(:facts) do
        { :processorcount => 4,
        }
      end
      let(:params) do
        { :cmhost => 'cm.example.com',
          :sysconfig_ensure => "yes",
        }
      end
      it 'should fail' do
        expect {
          should contain_class('ecloud')
        }.to raise_error(Puppet::Error,/ecloud::sysconfig_ensure may be either 'present', 'absent', 'file' or 'link' and is set to <yes>/)
      end
    end

    context 'sysconfig_owner' do
      let(:facts) do
        { :processorcount => 4,
        }
      end
      let(:params) do
        { :cmhost => 'cm.example.com',
          :sysconfig_owner => true,
        }
      end
      it 'should fail' do
        expect {
          should contain_class('ecloud')
        }.to raise_error(Puppet::Error,/true is not a string\.  It looks to be a TrueClass/)
      end
    end

    context 'sysconfig_group' do
      let(:facts) do
        { :processorcount => 4,
        }
      end
      let(:params) do
        { :cmhost => 'cm.example.com',
          :sysconfig_group => true,
        }
      end
      it 'should fail' do
        expect {
          should contain_class('ecloud')
        }.to raise_error(Puppet::Error,/true is not a string\.  It looks to be a TrueClass/)
      end
    end

    context 'sysconfig_mode' do
      let(:facts) do
        { :processorcount => 4,
        }
      end
      let(:params) do
        { :cmhost => 'cm.example.com',
          :sysconfig_mode => true,
        }
      end
      it 'should fail' do
        expect {
          should contain_class('ecloud')
        }.to raise_error(Puppet::Error,/true is not a string\.  It looks to be a TrueClass/)
      end
    end

    context 'cmhost' do
      let(:facts) do
        { :processorcount => 4,
        }
      end
      let(:params) do
        { :cmhost => true,
        }
      end
      it 'should fail' do
        expect {
          should contain_class('ecloud')
        }.to raise_error(Puppet::Error,/true is not a string\.  It looks to be a TrueClass/)
      end
    end

    context 'cmport' do
      let(:facts) do
        { :processorcount => 4,
        }
      end
      let(:params) do
        { :cmhost => 'cm.example.com',
          :cmport => true,
        }
      end
      it 'should fail' do
        expect {
          should contain_class('ecloud')
        }.to raise_error(Puppet::Error,/true is not a string\.  It looks to be a TrueClass/)
      end
    end

    context 'install_erunnerd' do
      let(:facts) do
        { :processorcount => 4,
        }
      end
      let(:params) do
        { :cmhost => 'cm.example.com',
          :install_erunnerd => true,
        }
      end
      it 'should fail' do
        expect {
          should contain_class('ecloud')
        }.to raise_error(Puppet::Error,/true is not a string\.  It looks to be a TrueClass/)
      end
    end

    context 'log_remove' do
      let(:facts) do
        { :processorcount => 4,
        }
      end
      let(:params) do
        { :cmhost => 'cm.example.com',
          :log_remove => true,
        }
      end
      it 'should fail' do
        expect {
          should contain_class('ecloud')
        }.to raise_error(Puppet::Error,/ecloud::log_remove may be either 'Yes' or 'No' and is set to <true>/)
      end
    end

    context 'lsf_host' do
      let(:facts) do
        { :processorcount => 4,
        }
      end
      let(:params) do
        { :cmhost => 'cm.example.com',
          :lsf_host => true,
        }
      end
      it 'should fail' do
        expect {
          should contain_class('ecloud')
        }.to raise_error(Puppet::Error,/ecloud::lsf_host may be either 'y' or 'n' and is set to <true>/)
      end
    end

    context 'max_open_fds' do
      let(:facts) do
        { :processorcount => 4,
        }
      end
      let(:params) do
        { :cmhost => 'cm.example.com',
          :max_open_fds => true,
        }
      end
      it 'should fail' do
        expect {
          should contain_class('ecloud')
        }.to raise_error(Puppet::Error,/true is not a string\.  It looks to be a TrueClass/)
      end
    end

    context 'agent_number' do
      let(:facts) do
        { :processorcount => 4,
        }
      end
      let(:params) do
        { :cmhost => 'cm.example.com',
          :agent_number => true,
        }
      end
      it 'should fail' do
        expect {
          should contain_class('ecloud')
        }.to raise_error(Puppet::Error,/true is not a string\.  It looks to be a TrueClass/)
      end
    end

    context 'reboot' do
      let(:facts) do
        { :processorcount => 4,
        }
      end
      let(:params) do
        { :cmhost => 'cm.example.com',
          :reboot => true,
        }
      end
      it 'should fail' do
        expect {
          should contain_class('ecloud')
        }.to raise_error(Puppet::Error,/ecloud::reboot may be either 'Yes' or 'No' and is set to <true>/)
      end
    end

    context 'secure_console' do
      let(:facts) do
        { :processorcount => 4,
        }
      end
      let(:params) do
        { :cmhost => 'cm.example.com',
          :secure_console => true,
        }
      end
      it 'should fail' do
        expect {
          should contain_class('ecloud')
        }.to raise_error(Puppet::Error,/ecloud::secure_console may be either 'y' or 'n' and is set to <true>/)
      end
    end

    context 'tmp_path' do
      let(:facts) do
        { :processorcount => 4,
        }
      end
      let(:params) do
        { :cmhost => 'cm.example.com',
          :tmp_path => "yes",
        }
      end
      it 'should fail' do
        expect {
          should contain_class('ecloud')
        }.to raise_error(Puppet::Error,/"yes" is not an absolute path/)
      end
    end
  end
end
