function logPz = HPW_OU_Pz(z,parameters)

p_esc=parameters(1);
p_trap=parameters(2);

N=length(z);


logPz=sum(log(...
    z(2:end).*z(1:end-1).*(1-p_esc)...
    +z(2:end).*(1-z(1:end-1)).*p_trap...
    +(1-z(2:end)).*z(1:end-1).*p_esc...
    +(1-z(2:end)).*(1-z(1:end-1)).*(1-p_trap)...
    ));
            
%add contribution from prior (based on stationary probabilities)
logPz=logPz+log(z(1)*p_trap/(p_trap+p_esc) + (1-z(1))*p_esc/(p_trap+p_esc));


end