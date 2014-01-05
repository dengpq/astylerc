#!/bin/python
import os
import os.path
import string

def update_vim_plugin(plugin_dir, parent_dir):
    #first enter the target vim plugin directory 
    os.chdir(plugin_dir)
    print("now update %s..." %(plugin_dir))
    #then update this plugin
    os.system("git pull origin master")
    #last, return the parent directory
    os.chdir(parent_dir)
    print("update %s OK, now return %s" %(plugin_dir, parent_dir))

def main():
    parent_dir = os.getcwd()
    file_lists = os.listdir(parent_dir)
    plugin_dir = ""
    for plugin_dir in file_lists:
        if os.path.isdir(plugin_dir) and cmp(plugin_dir, ".") != 0 and \
                cmp(plugin_dir, "..") != 0:
           update_vim_plugin(plugin_dir, parent_dir)

if __name__ == '__main__':
    main()
