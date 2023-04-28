#!/usr/bin/env nu

def main [ file: string ] {
    open $file | to json 
}
