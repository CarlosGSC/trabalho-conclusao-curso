% Tarefa: Simular o controle de 4 robos usando o consensus
clear all
a=0.15;
t=0;
P=5;
w=2*pi/P;
r=5;
erro=0;
k=1;
xd=[0;0];
vd=[0;0];
psi=[ 0;0;0;0];

x=[-0.5 0.5; -0.5 -0.5; 0.5 -0.5; 0.5 0.5]*10; % Posição inicial dos robôs
% x=[2 -7; 5 5; -3 -2; 3 5 ]; % Posição inicial dos robôs

u1=[0;0];
u2=[0;0];
u3=[0;0];
u4=[0;0];

% L=[-3 1 1 1; 1 -3 1 1; 1 1 -3 1; 1 1 1 -3]; % Matriz laplaciana 
L=[0 0 0 0; 1 -3 1 1; 1 1 -3 1; 1 1 1 -3]; % Matriz laplaciana 

xf=[-1.5 0; -0.5 0; 0.5 0; 1.5 0]; % Posição de formação dos robôs

T=1/30;
t1=tic;

Tsim=40;
t2=tic;

i=1;
x_plot=[];
y_plot=[];

% while toc(t2)<Tsim
while true
    if toc(t1)>T
        t1=tic;
        xref=L*(x-xf);

        % xd=[r*cos(w*t);r*sin(2*w*t)];
        % vd=[-r*w*sin(w*t);r*w*2*cos(2*w*t)];

        xd=[r*cos(w*t);r*sin(w*t)];
        vd=[-r*w*sin(w*t);r*w*cos(w*t)];

        t=t+T;

        erro=xd-x(1,:)';
        xref1=vd+k*erro;


        % u1=[cos(psi(1)) sin(psi(1)); -sin(psi(1))/a cos(psi(1))/a]*xref(1,:)';
        u1=[cos(psi(1)) sin(psi(1)); -sin(psi(1))/a cos(psi(1))/a]*xref1;
        u2=[cos(psi(2)) sin(psi(2)); -sin(psi(2))/a cos(psi(2))/a]*xref(2,:)';
        u3=[cos(psi(3)) sin(psi(3)); -sin(psi(3))/a cos(psi(3))/a]*xref(3,:)';
        u4=[cos(psi(4)) sin(psi(4)); -sin(psi(4))/a cos(psi(4))/a]*xref(4,:)';

        v1=[cos(psi(1)) -a*sin(psi(1)); sin(psi(1)) a*cos(psi(1))]*u1;
        v2=[cos(psi(2)) -a*sin(psi(2)); sin(psi(2)) a*cos(psi(2))]*u2;
        v3=[cos(psi(3)) -a*sin(psi(3)); sin(psi(3)) a*cos(psi(3))]*u3;
        v4=[cos(psi(4)) -a*sin(psi(4)); sin(psi(4)) a*cos(psi(4))]*u4;

        psi(1)=psi(1)+u1(2)*T;
        psi(2)=psi(2)+u2(2)*T;
        psi(3)=psi(3)+u3(2)*T;
        psi(4)=psi(4)+u4(2)*T;
        
        v=[v1';v2';v3';v4'];

        x_plot=[x_plot;x(:,1)'];
        y_plot=[y_plot;x(:,2)'];

        x=x+v*T;

        u1=[cos(psi(1)) sin(psi(1)); -sin(psi(1))/a cos(psi(1))/a]*xref(1,:)';
        u2=[cos(psi(2)) sin(psi(2)); -sin(psi(2))/a cos(psi(2))/a]*xref(2,:)';
        u3=[cos(psi(3)) sin(psi(3)); -sin(psi(3))/a cos(psi(3))/a]*xref(3,:)';
        u4=[cos(psi(4)) sin(psi(4)); -sin(psi(4))/a cos(psi(4))/a]*xref(4,:)';

        % disp(x)
        
        drawnow
        figure(1)
        % plot(x_plot(:,1),y_plot(:,1),'*',x_plot(:,2),y_plot(:,2),'*',x_plot(:,3),y_plot(:,3),'*',x_plot(:,4),y_plot(:,4),'*')
        plot(x_plot(:,1),y_plot(:,1),x_plot(:,2),y_plot(:,2),x_plot(:,3),y_plot(:,3),x_plot(:,4),y_plot(:,4))
        axis([-10 10 -10 10])
        hold on
        quiver(x_plot(i,1),y_plot(i,1),cos(psi(1)),sin(psi(1)),'k*')
        quiver(x_plot(i,2),y_plot(i,2),cos(psi(2)),sin(psi(2)),'k*')
        quiver(x_plot(i,3),y_plot(i,3),cos(psi(3)),sin(psi(3)),'k*')
        quiver(x_plot(i,4),y_plot(i,4),cos(psi(4)),sin(psi(4)),'k*')

        hold off
        grid on

        % disp(psi')
            
        i=i+1;

    end
end

