

clear all;
close all;

f0=100;


fe=2000;
te=1/fe;
N=1000;
t=[0:N-1]*te;

x=10*cos(2*pi*f0*t);


[imf,ort,nbits] = emd(x,t);
emd_visu(x,t,imf);