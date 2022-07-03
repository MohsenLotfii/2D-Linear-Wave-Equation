clear all
clc

% FOR 20*20 GRID:
% nx=20;                    %Number of steps in space(x)
% ny=20;                    %Number of steps in space(y)
% dt=2;                     %Width of each time step for 20*20 grid
% nt=13;                    %Number of time steps for  t=25
% nt=25;                    %Number of time steps for  t=50
% nt=38;                    %Number of time steps for  t=75
% nt=50;                    %Number of time steps for  t=100


% % FOR 40*40 GRID:
% nx=40;                    %Number of steps in space(x)
% ny=40;                    %Number of steps in space(y)
% dt=0.97;                  %Width of each time step for 40*40 grid
% nt=26;                    %Number of time steps for  t=25
% nt=52;                    %Number of time steps for  t=50
% nt=77;                    %Number of time steps for  t=75 
% nt=103;                   %Number of time steps for  t=100


% FOR 80*80 GRID:
% nx=80;                    %Number of steps in space(x)
% ny=80;                    %Number of steps in space(y) 
% dt=0.48;                  %Width of each time step for 80*80 grid
% nt=52;                    %Number of time steps for  t=25
% nt=104;                   %Number of time steps for  t=50
% nt=156;                   %Number of time steps for  t=75
% nt=208;                   %Number of time steps for  t=100

c=1;                        %Velocity of wave propagation
nx=20;                      %Number of steps in space(x)
ny=20;                      %Number of steps in space(y)
dx=200/(nx-1);              %Width of space step(x)
dy=200/(ny-1);              %Width of space step(y)
x=0:dx:200;                 %Range of x(0,2) and specifying the grid points
y=0:dy:200;                 %Range of y(0,2) and specifying the grid points
u=zeros(nx,ny);             %Preallocating u
dt=2;                       %Width of each time step for 20*20 grid
nt=100;                      %Number of time steps for  t=150


%Initial Conditions
for i=1:nx
    for j=1:ny 
        if (0<=x(i) && x(i)<=20) && (0<=y(j) && y(j)<=10) 
           u(i,j)=100;
        else
            u(i,j)=0;           
        end
    end
end

%Boundary conditions
u(1,:)=100;
u(:,1)=100;
u(nx,:)=0;
u(:,ny)=u(:,ny-1);

% plotting Exact solution:
for k=1:dt:nt
    t=k*dt;
    u_exact=u;
    figure(3)
    h=surf(x,y,u','EdgeColor','none');   %plotting the velocity profile
    axis([0 200 0 200 0 200])
    shading faceted %interp
    title({['2-D Linear Convection with {\itc} = ',num2str(c)];['time(\itt) = ',num2str(k*dt)]})
    xlabel('x')
    ylabel('y')
    zlabel('u')
    colorbar
    view([0 90]);  % Better view from this angle
    drawnow
    refreshdata(h)
    
   for i=2:nx-1
       for j=2:ny-1
           u(i,j) = 100*(1-exp(-t/(c*((i*dx)+(j*dy)))));
       end
   end
  
end



