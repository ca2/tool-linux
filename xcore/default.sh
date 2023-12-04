#!/bin/bash


function run_app() {


	cd /xcore/time/x64/basis


	exec /xcore/time/x64/basis/app $2 : app=$1  build_number=basis locale=_std schema=_std


}


run_app $1 $2



