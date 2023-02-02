# Runner for Purlovia

Requires Docker.


### Setup local volumes for `livedata` and `logs`
```sh
mkdir -p livedata logs
```
* `livedata` directory will grow to 30Gb+
* Log detail, rotation and purging is configurable in `config/logging.yaml`

### Setup output repo
```sh
git clone --single-branch -b master https://github.com/arkutils/Obelisk.git output
cd output
git config --local user.name "Raptor Claus"
git config --local user.email 52712839+RaptorClaus@users.noreply.github.com
git config --local core.sshCommand "ssh -o LogLevel=error -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no -i /app/config/id_rsa-raptor -F /dev/null"
```

(then repeat for the ObeliskSOTF repository in `output-sotf`)

## If needed, create new key for Raptor Claus
```sh
ssh-keygen -t rsa -b 4096 -C "52712839+RaptorClaus@users.noreply.github.com"
# empty passcode, output to id_rsa-raptor
```
* Install in Raptor Claus's ssh keys, cleaning out obsolete ones

### To run it
```sh
docker-compose pull
docker-compose run --rm purlovia
```
It should be possible to schedule a task to do this easily. *Just remember to set the correct working directory!*

### Scheduling with SystemD
Examples of a unit and timer can be found in the `systemd/` directory.

If you choose to use it, make sure the runner path is right for you and install it:
```sh
## User mode
ln -s $PWD/systemd/purlovia-runner.service ~/.config/systemd/user/purlovia-runner.service
ln -s $PWD/systemd/purlovia-runner.timer ~/.config/systemd/user/purlovia-runner.timer
## ... if you want it to run on boot, remember to enable lingering for the user.

## System-wide
install -Dm0644 $PWD/systemd/purlovia-runner.service /etc/systemd/system/purlovia-runner.service
install -Dm0644 $PWD/systemd/purlovia-runner.timer /etc/systemd/system/purlovia-runner.timer
## ... or soft link
ln -s systemd/purlovia-runner.service /etc/systemd/system/purlovia-runner.service
ln -s systemd/purlovia-runner.timer /etc/systemd/system/purlovia-runner.timer
```

Remember to reload loaded units with `systemctl daemon-reload` when updating the units.
