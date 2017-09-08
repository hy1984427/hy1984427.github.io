def test_passwd_file(host):
    print("Validate the string in passwd file, the user and permission of the file")
    passwd = host.file("/etc/passwd")
    assert passwd.contains("root")
    assert passwd.user == "root"
    assert passwd.group == "root"
    assert passwd.mode == 0o644

def test_tmp_folder(host):
    tmp_folder=host.file("/tmp")
    assert tmp_folder.is_directory

def test_group_exist(host):
    group=host.group("ec2")
    assert group.exists
    assert group.gid == 1001

def test_package_installed(host):
    assert host.package("python-backports-1.0-8.el7.x86_64").is_installed

def test_process(host):
    process=host.process.get(user="root", stat="R")
    assert process.contains("[rcu_sched]")

def test_service(host):
    service1=host.service("postfix")
    service2=host.service("ntpd")
    assert service1.is_running
    assert service1.is_enabled
    assert service2.is_running

def test_socket(host):
    socket=host.socket("tcp://22")
    assert socket.is_listening
    assert host.socket("unix:///var/run/docker.sock").is_listening

def test_sysctl(host):
    hostname=host.sysctl("kernel.hostname")
    release=host.sysctl("kernel.osrelease")
    assert hostname == "hostname"
    assert release == "release"

def test_system_info(host):
    os_type=host.system_info.type
    distribution=host.system_info.distribution
    release=host.system_info.release
    assert os_type == "linux"
    assert distribution == "rhel"
    assert release == "7.4"

def test_user_info(host):
    username=host.user("ec2").name
    uid=host.user("ec2").uid
    home=host.user("ec2").home
    assert username == "ec2"
    assert uid == 1001
    assert home == "/home/ec2"

def test_command_output(host):
    cmd = host.run("id -nu")
    assert cmd.stdout=="ec2\n"
