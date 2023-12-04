#!/bin/bash


function run_app() {


	cd /xcore/time/x64/basis


	exec /xcore/time/x64/basis/app_core_commander : $1=$2

}


run_app $1 $2



