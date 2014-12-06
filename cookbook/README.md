Installs citizen_approved
---

1. ```bundle install```
2. add your ssh key on the koding server to /root/.ssh/authorized_keys
3. to deploy, run:
```
rm -rf cookbooks && \
bundle exec berks vendor cookbooks && \
bundle exec knife zero bootstrap 54.69.152.178 -N citizen_approved-dev01 -r 'citizen_approved::all' -x root -E development -c knife.rb
git commit -m 'update nodes/clients' nodes clients
```


to deploy a cluster on digital ocean, set up tugboat gem and configure it to your liking, then run:
```rm -rf cookbooks/ && \
bundle exec berks vendor cookbooks && \
bundle exec chef-client -c knife.rb -z recipes/cluster.rb
git commit -m 'update nodes/clients' nodes clients
```
