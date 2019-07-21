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
git clone --single-branch -b master git@github.com:arkutils/Obelisk.git output
cd output
git config --local user.name "Raptor Claus"
git config --local user.email 52712839+RaptorClaus@users.noreply.github.com
git config --local core.sshCommand "ssh -o LogLevel=error -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no -i /app/config/id_rsa-raptor -F /dev/null"
```

### If needed, create new key for Raptor Claus
```sh
ssh-keygen -t rsa -b 4096 -C "52712839+RaptorClaus@users.noreply.github.com"
# empty passcode, output to config/id_rsa-raptor
```
* Install in Raptor Claus's ssh keys, cleaning out obsolete ones

### To run it
```sh
docker-compose pull
docker-compose run --rm purlovia
```
It should be possible to schedule a task to do this easily. *Just remember to set the correct working directory!*
