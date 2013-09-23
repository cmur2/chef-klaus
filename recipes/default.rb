
include_recipe "python"

python_pip 'klaus' do
  action :install
end

# read projects.list file if specified and if it exists,
# populate the repositories list with it
if node['klaus']['projects_list_path'] and node['klaus']['projects_root_path'] and ::File.exists?(node['klaus']['projects_list_path'])
  contents = ::File.open(node['klaus']['projects_list_path']) do |f| f.read end
  projects = contents.split("\n")
  root = node['klaus']['projects_root_path']
  node.set['klaus']['repositories'] = projects.map { |name| root + '/' + name }.join(' ')
end

# build daemon options from specified attributes
daemon_opts = ""
daemon_opts << " --host #{node['klaus']['host']}" if node['klaus']['host']
daemon_opts << " --port #{node['klaus']['port']}" if node['klaus']['port']
daemon_opts << " --site-name #{node['klaus']['sitename']}" if node['klaus']['sitename']
daemon_opts << " --smarthttp" if node['klaus']['smarthttp']
daemon_opts << " --htdigest #{node['klaus']['htdigest']}" if node['klaus']['htdigest']
daemon_opts << " #{node['klaus']['repositories']}"

template "/etc/init.d/klaus" do
  source "klaus.init.erb"
  owner "root"
  group "root"
  mode 00755
  variables ({
    :daemon => node['klaus']['daemon_binary'],
    :daemon_opts => daemon_opts
  })
  notifies :restart, "service[klaus]"
end

service "klaus" do
  action [:enable, :start]
end
