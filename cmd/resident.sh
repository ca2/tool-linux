#!/bin/bash

function resident()
{



	cd /xcore/stage/x86
	/xcore/stage/x86/app : app=app-core/resident build_number=basis locale=_std schema=_std


}


resident
