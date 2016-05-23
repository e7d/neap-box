#!/bin/bash

vagrant destroy --force
vagrant up --install-provider --destroy-on-error
rm -rf neap.box
vagrant package --output neap.box
