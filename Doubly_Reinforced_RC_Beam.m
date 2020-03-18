
%% Defining the Parameters %%
disp ("The programm is only valid for rectangular cross-section");
disp("All the dimensions should be in mm and stress should be in MPa");
Es = 2*10^5;
b = input("enter the width of beam = ");
D = input("enter the total depth of beam = ");
d_d = input("enter the nominal cover at tension side = ");
d_c = input("enter the nominal cover at compression side = ");
d = D - d_d;
fck = input("enter the grade of concrete = ");
phi_t = input("enter the rebar diameter at tension side = ");
nu_t = input("enter the number of rebars at tension side =");
phi_c = input("enter the rebar diameter at compressio side = ");
nu_c = input("enter the number of rebars at compression side =");
fy_t = input("enter the rebar yeild strength at tension side = ");
fy_c = input("enter the rebar yeild strength at compression side = ");
Ast_t = (pi/4)*phi_t^2*nu_t;
Ast_c = (pi/4)*phi_c^2*nu_c;
%% Determining the depth of neutral axis using fixed point iteration method %%
x0 = 100;
itr = 10;
x = x0;
strain_cs = 0.0035*(x-d_c)/x;
fsc = strain_cs * (2*10^5);
for i = 1:itr
     if fy_c == 250
                 if strain_cs > 0.0010875
                    fsc = 0.87*250;
                end
        x = ((0.87*fy_t*Ast_t) -Ast_c*(fsc - 0.45*fck))/(0.36*fck*b); 
   
     elseif fy_c ~=250
         x = ((0.87*fy_t*Ast_t) -Ast_c*(fsc - 0.45*fck))/(0.36*fck*b);
         if (strain_cs > (0.8*0.87*fy_c / Es) && strain_cs < (0.87*fy_c/Es))
             fsc_y = [0.8, 0.85, 0.90, 0.95, 0.975, 1]*0.87*fy_c; 
             s_cs_y = [0 , 0.0001, 0.0003, 0.0007, 0.001, 0.002]+ fsc_y*(1/Es);
             fsc = interp1(s_cs_y,fsc_y,strain_cs);
             x = ((0.87*fy_t*Ast_t) -Ast_c*(fsc - 0.45*fck))/(0.36*fck*b);
         elseif strain_cs >= 0.87*fy_c/Es
             fsc = 0.87*fy_c;
             x = ((0.87*fy_t*Ast_t) -Ast_c*(fsc - 0.45*fck))/(0.36*fck*b);
         end
         
         
         
     end
end
if fy_t == 250
    xu = 0.53*d;
elseif fy_t == 415
    xu = 0.48*d;
elseif fy_t ==500
    xu = 0.46*d;
elseif fy_t ==550
    xu = 0.44*d;
end

if x > xu
    x = xu;
end
%% Determination of Moment Capacity of Beam %%
M = (0.36*fck*b*x*(d-0.416*x) + Ast_c*(fsc - 0.45*fck)*(d - d_c))*10^-6; 
disp (M);