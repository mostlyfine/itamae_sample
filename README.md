### execute example

```
$ bundle exec itamae ssh -h vagrant -j nodes/vagrant.json recipes/rbenv.rb
$ bundle exec itamae ssh -h 127.0.0.1 -u sawa -p 2222 -j nodes/vagrant.json recipes/rbenv.rb
```

### ssh configure

```
$ vagrant ssh-config >> ~/.ssh/config
```
