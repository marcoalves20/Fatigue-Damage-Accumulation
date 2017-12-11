function [] = fatigueX(n,varinow)
%defines inputs for strength model, and runs bundleX

%%%Declaring variables%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Inputs
global Xmax DX Xlevel rX
global Lin Xavg CoV m Xin
global Lref Xref Lout
global Tsl T freebounds Ef
global Df Vf
global k z
global N DeltaN
global sigmath 
global iTest

%%%Input variables%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Fatigue Cycles Defenition
DeltaN=zeros(2000,1);
DeltaN(1:2000)=25;
%--------------------

N=length(DeltaN); % Number of iterations
R=0.1; % Fatigue Stress Ratio

%Numerical variables
Xmax=40000; DX=100; Xlevel=3200;

%Row corresponding to load level considered
rX=(Xlevel/DX)+1; 

%Input fibre strength distribution
% Lin=5; Xavg=8500; CoV=0.25; %Original Parametric study

Lin=10; Xavg=5000; CoV=0.25; %Original

%Interfacial shear strengthnn
Tsl=70;

%Youngs Modulus of single fibre
Ef=200000; %MPa

%Geometry and composite
Df=0.007; Vf=0.5; % T700 CF 

%Shear lag boundary:
%4-quadrangular, 6-hexagonal;
%1-interface, 3-matrix, 5-shortest.
T=41; freebounds=0;

%Lengths
%T700G Lref = 66
%T700S Lref = 50
%T700 Yuaxin Zhou Lref = 8
%Reference length (unitary)
Lref=1; 
% Output length
Lout=10; 

%Stress concentrations
k=varinow;

% Non-linearity factor for half-broken bundle
z=1+(k-1)/4;

%%%Preliminary calculations%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Fibre strength distribution
% T700G==========
% m=8.44;       %=
% Xref=5054;    %=
%===============
% T700S=========
% m=4.8;       %=
% Xref==========
% m=4.8; Original Parametric Study  
m=5;

% m=fzero(@(m) sqrt(gamma(1+2/m)/(gamma(1+1/m)^2)-1)-CoV, 1.2/CoV)
Xin=Xavg/(gamma(1+1/m));
Xref=Xin*((Lref/Lin)^(-1/m)); 

%Test Bundle level
iTest=12;

%%%Calculates strength distributions%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
bundleX(n,DeltaN,N,R,Df);

end