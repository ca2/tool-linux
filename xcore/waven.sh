#!/bin/bash


function run_app() {


	cd /xcore/time/x64/basis


	exec /xcore/time/x64/basis/app : app=app-veriwell/waven  build_number=basis locale=_std schema=_std


}


run_app



