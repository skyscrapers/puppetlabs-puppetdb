require 'spec_helper'

describe 'puppetdb::server::global', :type => :class do
  context 'on a supported platform' do
    let (:facts) do
      {
        :osfamily => 'RedHat',
        :fqdn     => 'foo.com',
      }
    end

    it { should contain_class('puppetdb::server::global') }

    describe 'when using default values' do
      it { should contain_ini_setting('puppetdb_global_vardir').
        with(
          'ensure' => 'present',
          'path' => '/etc/puppetlabs/puppetdb/conf.d/config.ini',
          'section' => 'global',
          'setting' => 'vardir',
          'value' => '/opt/puppetlabs/server/data/puppetdb'
      )}
      it { should contain_file('/etc/puppetlabs/puppetdb/conf.d/config.ini').
        with(
             'ensure'  => 'file',
             'owner'   => 'puppetdb',
             'group'   => 'puppetdb',
             'mode'    => '0600'
      )}
    end

    describe 'when using a legacy puppetdb version' do
      let (:pre_condition) { 'class { "puppetdb::globals": version => "2.2.0", }' }
      it {should contain_ini_setting('puppetdb_global_vardir').
        with(
          'ensure' => 'present',
          'path' => '/etc/puppetdb/conf.d/config.ini',
          'section' => 'global',
          'setting' => 'vardir',
          'value' => '/var/lib/puppetdb'
      )}
    end
  end
end
