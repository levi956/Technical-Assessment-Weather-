#!/usr/bin/python3
# python script that runs "bulid runner" to generate dart code
import os
cmd = "dart run build_runner build --delete-conflicting-outputs"
os.system(cmd)