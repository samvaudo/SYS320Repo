#!/bin/bash

ip addr | grep -oP 'inet\s+\K10\.0\.17\.\d+'
