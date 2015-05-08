#!/usr/bin/env bats

@test "File should be exist" {
    [[ -e ./setup.sh ]]
}

@test "Display help message" {
    run bash setup.sh -h
    [[ ${lines[0]} =~ "Usage" ]]
}

@test "Bash should be installed" {
    run which bash
    [[ ${lines[0]} =~ "bash" ]]
}