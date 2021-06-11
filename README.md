# Install

Simply use ansible-playbook on ansible-setup

```sh
ansible-playbook -K ansible-setup.yml
```

Then simply put this on your zshrc:

```sh
source <("${HOME}/.cargo/bin/sheldon" source)`
```
