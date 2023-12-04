Name:       store 
Version:    %RELEASE_NUMBER% 
Release:    1%{?dist} 
Summary:    Store package 
Group:      System Environment/Base 
License:    GPLv3+ 
Source0:    store-%RELEASE_NUMBER%.tar.gz 

%description 
store application package. 

%prep 
%setup -q
 
%install 
cp -rfa * %{buildroot} 

%files 
/* 

 
