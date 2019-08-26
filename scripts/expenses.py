#!/usr/bin/env python3.6

""" script to store expenses in a json file
    structure is {date}{amount spent}{purpose}
    entries are delimited by a line break
    values within an entry are delimited by a comma

    TODO
    =====
    * allow to provide the date as argument
    * allow deleting of entries 
"""
import pandas
import argparse
import json
from pathlib import Path
import os
import sys
import datetime

def usage():
    print("incorrect number of arguments")
    print("usage: expenses.py {amount spent} [purpose/category]")

def parse_args(args):
    purpose = None
    if len(args) > 3 or len(args) < 2:
        usage()
        sys.exit()
    elif len(args) == 3:
        purpose = str(args[2])
    amount = float(args[1])

    return amount, purpose

def get_store_path():
    home = str(Path.home())
    f_name = "expenses.json"
    store_path = os.path.join(home, "Documents", f_name)
    return store_path

def add_entry():
    amount, purpose = parse_args(sys.argv)
    store_path = get_store_path()

    # get date (yyyy-mm-dd)
    date = str(datetime.datetime.now()).split(' ')[0]

    with open(store_path, "a") as f:
        f.write(f"{date},{amount},{purpose}\n")

    print(f"added entry -> date: {date},amount: {amount}, purpose: {purpose}")

def delete_entry():
    pass

def main():
    # TODO: parse flags (-d1 to delete the last line, -d2 for last two lines etc)
    parser = argparse.ArgumentParser()
    group = parser.add_mutually_exclusive_group()
    group.add_argument("-a", "--add", help="add entry")
    group.add_argument("-l", "--list", help="list money spent", action="store_true")
    
    args = parser.parse_args()
    if args.list: 
        print("hi")

    #add_entry()


if __name__ == "__main__":
    main()


