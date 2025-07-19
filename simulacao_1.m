%% Declaração das variáveis

x=zeros(2,1);
x_desejada=[2;2];
v_desejada=[0;0];
psi_desejado=0;
k=1;
psi=0;
a=0.15;
dt=1/30;
t=0;
t_sim=20;
t1=tic;
t2=tic;
x_plot=[];
T=10;
r=1;


while toc(t1)<t_sim
    if toc(t2)>dt
        t2=tic;

        % Equações
        x_desejada=[r*cos(2*pi*t/T);r*sin(2*pi*t/T)];
        v_desejada=[-r*2*pi/T*sin(2*pi*t/T); r*2*pi/T*cos(2*pi*t/T)];
        
        x_plot=[x_plot x];
        A=[cos(psi) -sin(psi);sin(psi)/a cos(psi)/a];
        A_inv=[cos(psi) sin(psi);-sin(psi)/a cos(psi)/a];
        v_ref=v_desejada+k*(x_desejada-x);
        u=A_inv*v_ref;
        v=v_ref;
        w=u(2);
        x=x+v*dt;
        psi=psi+w*dt;
        t=t+dt;
        
        drawnow
        plot(x_plot(2,:),x_plot(1,:))
        axis([-2 2 -2 2])
        disp(x)

    end
end

