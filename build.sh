#!/bin/bash

vagrant destroy --force
vagrant up --install-provider
rm -rf neap.box
vagrant package --output neap.box
