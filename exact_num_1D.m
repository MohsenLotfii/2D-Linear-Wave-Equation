clear all
clc

% FOR 20*20 GRID:
% nx=20;                    %Number of steps in space(x)
% ny=20;                    %Number of steps in space(y)
% dt=2;                     %Width of each time step for 20*20 grid
% nt=25;                    %Number of time steps for  t=50
% nt=50;                    %Number of time steps for  t=100
% nt=75;                    %Number of time steps for  t=150
% nt=100;                   %Number of time steps for  t=200


% % FOR 40*40 GRID:
% nx=40;                    %Number of steps in space(x)
% ny=40;                    %Number of steps in space(y)
% dt=0.97;                  %Width of each time step for 40*40 grid
% nt=52;                    %Number of time steps for  t=50
% nt=103;                   %Number of time steps for  t=100
% nt=155;                   %Number of time steps for  t=150
% nt=206;                   %Number of time steps for  t=200 


% FOR 80*80 GRID:
% nx=80;                    %Number of steps in space(x)
% ny=80;                    %Number of steps in space(y) 
% dt=0.48;                  %Width of each time step for 80*80 grid
% nt=104;                   %Number of time steps for  t=50
% nt=208;                   %Number of time steps for  t=100
% nt=313;                   %Number of time steps for  t=150
% nt=417;                   %Number of time steps for  t=200

c=1;                        %Velocity of wave propagation
dx=200/(nx-1);              %Width of space step(x)
dy=200/(ny-1);              %Width of space step(y)
x=0:dx:200;                 %Range of x(0,2) and specifying the grid points
y=0:dy:200;                 %Range of y(0,2) and specifying the grid points
u=zeros(nx,ny);             %Preallocating u
un=zeros(nx,ny);            %Preallocating un
CN_x=abs((c)*(dt/dx));      %Courant Number


%Initial Conditions
for i=1:nx
    for j=1:ny 
        if 0<=x(i) && x(i)<=20
           u(i,j)=100;
        else
            u(i,j)=0;           
        end
    end
end


%Boundary conditions
u(1,:)=100;
u(nx,:)=0;
if  u(:,ny)
    u(i,j-1)=u(i,j);
elseif u(:,1)
    u(i,j)= u(i,j+1);
end

% plotting the Exact solution:
for k=1:dt:nt
    t=k*dt;
    u_exact=u;
%     figure(1)
%     h=surf(x,y,u','EdgeColor','none');   %plotting the velocity profile
%     axis([0 200 0 200 0 200])
%     shading faceted %interp
%     title({['1-D Linear Convection with {\itc} = ',num2str(c)];['time(\itt) = ',num2str(k*dt)]})
%     xlabel('x')
%     ylabel('y')
%     zlabel('u')
%     colorbar
%     view([0 90]);  % Better view from this angle
%     drawnow
%     refreshdata(h)
    
   for i=2:nx-1
       for j=1:ny-1
           u(i,j) = 100*(1-exp(-t/(c*(i*dx))));
       end
   end

end

% plotting Numerical solution:
i=3:nx-1;
j=1:ny-1;

for it=1:nt 
    un=u;
%     figure(2)
%     h=surf(x,y,u','EdgeColor','none');   %plotting the velocity profile
%     axis([0 200 0 200 -500 200])
%     shading faceted %interp
%     title({['1-D Linear Convection with {\itc} = ',num2str(c),' and Courant Number = ',num2str(CN_x)];['time(\itt) = ',num2str(dt*it)]})
%     xlabel('x')
%     ylabel('y')
%     zlabel('u')
%     colorbar
%     view([0 90]);  % Better view from this angle
%     drawnow
%     refreshdata(h)
    
%     forms of equation:
    
    % FOU :
    u(i,j)=un(i,j)-(CN_x*(un(i,j)-un(i-1,j)));
    
    % SOU-1D:
%     u(i,j)=un(i,j)-(0.5*CN_x*(3*un(i,j)-2*un(i-1,j)-un(i-2,j)));


    % QUICK-1D: 
%      u(i,j)=un(i,j)-(CN_x/8)*(7*un(i,j)-3*un(i-1,j)-un(i+1,j)-3*un(i-2,j));

   

    % Set boundary conditions
     
    u(1,:)=100;
    u(nx,:)=0;
    if  u(:,ny)
        u(i,j-1)=u(i,j);
    elseif u(:,1)
        u(i,j)= u(i,j+1);
    end
end

% Calculating Error:
 Error = abs(u_exact - u);
 Err = (norm(Error)/norm(u_exact))

