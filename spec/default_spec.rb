require 'chefspec'

describe 'klaus::default' do
  let(:chef_runner) do
    cb_path = [Pathname.new(File.join(File.dirname(__FILE__), '..', '..')).cleanpath.to_s, 'spec/support/cookbooks']
    ChefSpec::ChefRunner.new(:cookbook_path => cb_path)
  end

  let(:chef_run) do
    chef_runner.converge 'klaus::default'
  end
  
  it 'installs klaus via pip' do
    pending "Cannot test python_pip"
  end
  
  it 'creates an init.d script' do
    expect(chef_run).to create_file_with_content "/etc/init.d/klaus", ""
  end
  
  it 'enables and starts klaus' do
    expect(chef_run).to start_service "klaus"
    expect(chef_run).to set_service_to_start_on_boot "klaus"
  end
end
