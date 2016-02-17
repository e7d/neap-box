#!/bin/bash

vagrant destroy --force
vagrant up --install-provider
rm -fr neap.box
vagrant package --output neap.box
