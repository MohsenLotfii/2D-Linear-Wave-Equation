clear all
clc
% % FOR 20*20 GRID:
nx=20;                    %Number of steps in space(x)
ny=20;                    %Number of steps in space(y)
dt=2;                     %Width of each time step for 20*20 grid
nt=25;                    %Number of time steps for  t=50
% nt=50;                    %Number of time steps for  t=100
% nt=75;                    %Number of time steps for  t=150
% nt=100;                   %Number of time steps for  t=200

 
% % % FOR 40*40 GRID:
% nx=40;                    %Number of steps in space(x)
% ny=40;                    %Number of steps in space(y)
% dt=0.97;                  %Width of each time step for 40*40 grid
% nt=51.55;                 %Number of time steps for  t=50
% nt=103.1;                 %Number of time steps for  t=100
% nt=154.64;                %Number of time steps for  t=150 
% nt=206.18;                %Number of time steps for  t=200 


% FOR 80*80 GRID:
% nx=80;                    %Number of steps in space(x)
% ny=80;                    %Number of steps in space(y) 
% dt=0.48;                  %Width of each time step for 80*80 grid
% nt=104.17;                %Number of time steps for  t=50
% nt=208.3;                 %Number of time steps for  t=100
% nt=312.5;                 %Number of time steps for  t=150
% nt=416.7;                 %Number of time steps for  t=200

c=1;                        %Velocity of wave propagation
dx=200/(nx-1);              %Width of space step(x)
dy=200/(ny-1);              %Width of space step(y)
x=0:dx:200;                 %Range of x(0,2) and specifying the grid points
y=0:dy:200;                 %Range of y(0,2) and specifying the grid points
u=zeros(nx,ny);             %Preallocating u
un=zeros(nx,ny);            %Preallocating un
CN_x=abs(c)*dt/dx;          %Courant Number x
CN_y=abs(c)*dt/dy;          %Courant Number y

%Initial Conditions
for i=1:nx
    for j=1:ny 
        if (0<=x(i) && x(i)<=20)  
           u(i,j)=100;
        else if (0<=y(j) && y(j)<=20)
            u(i,j)=100;
            end
        end
    end
end

%Boundary conditions
u(1,:)=100;
u(nx,:)=0;
u(:,1)=100;
for i=1:nx
    if j==ny && j>=i
       u(i,j)=u(i,j-1);
    end
end

% plotting Exact solution:
for k=1:dt:nt
    t=k*dt;
    u_exact=u;
%     figure(3)
%     h=surf(x,y,u','EdgeColor','none');   %plotting the velocity profile
%     axis([0 200 0 200 0 200])
%     shading faceted %interp
%     title({['2-D Linear Convection with {\itc} = ',num2str(c)];['time(\itt) = ',num2str(k*dt)]})
%     xlabel('x')
%     ylabel('y')
%     zlabel('u')
%     colorbar
%     view([0 90]);  % Better view from this angle
%     drawnow
%     refreshdata(h)
    
   for i=2:nx-1
       for j=2:ny-1
           u(i,j) = 100*(1-exp(-t/(c*((i*dx)+(j*dy)))));
       end
   end
  
end


% plotting Numerical solution:
i=3:nx-1;
j=3:ny-1;

for it=1:nt 
    un=u;
%     figure(4)
%     h=surf(x,y,u','EdgeColor','none');   %plotting the velocity profile
%     axis([0 200 0 200 -500 500])
%     shading faceted %interp
%     title({['2-D Linear Convection with {\itc} = ',num2str(c),' and Courant Number = ',num2str(CN_x)];['time(\itt) = ',num2str(dt*it)]})
%     xlabel('x')
%     ylabel('y')
%     zlabel('u')
%     colorbar
%     view([0 90]);  % Better view from this angle
%     drawnow
%     refreshdata(h)
%     
    % forms of equation:
    
    % FOU-2D :
    u(i,j)=un(i,j)-(CN_x*(un(i,j)-un(i-1,j)))-(CN_y*(un(i,j)-un(i,j-1)));
    
    % SOU-2D :
%     u(i,j)=un(i,j)-(0.5*CN_x)*(3*un(i,j)-2*un(i-1,j)-un(i-2,j))-(0.5*CN_y)*(3*un(i,j)-2*un(i,j-1)-un(i,j-2));
 
    % QUICK-1D:
%      u(i,j)=un(i,j)-(CN_x/8)*(7*un(i,j)-3*un(i-1,j)-un(i+1,j)-3*un(i-2,j))-(CN_y/8)*(7*un(i,j)-3*un(i,j-1)-un(i,j+1)-3*un(i,j-2));
end

% Calculating Error:
 Error = abs(u_exact - u);
 Err = (norm(Error)/norm(u_exact))
