clc
clear
gazebo = ExampleHelperGazeboCommunicator();
resetSim(gazebo);

Epsilon = cell(1, 100);
max_E = [];
time = [];
RMS_E = [];
i = 1;
JOptimum = [];
XX = cell(1, 20);
YY = cell(1, 20);


lam=1.25;
ki=0;
for kp = 1:0.2:2
   for ki = 0:0.2:0.6
%       for lam = 1
 
   out = sim('revise_2_28_test_path_L_F');
   Epsilon{i} = out.epsilon;
   max_E  = [max_E, max(out.epsilon)];
   time = [time, max(out.tout)]; 
   SumSquareEpsilon = out.epsilon'    * out.epsilon;
   RMSEpsilon       = sqrt( SumSquareEpsilon / length(out.epsilon) );
   RMS_E            = [RMS_E, RMSEpsilon];
   J_Optimum = EpsArea(out.Progress,out.f.Data);
   JOptimum  = [JOptimum, J_Optimum]; 
   XX{i} = out.X;
   YY{i} = out.Y;
   
   resetSim(gazebo);
   sim('turtlebot_publish_cmd_vel_0');
   pause(1)
   resetSim(gazebo);
   pause(1)
   sim('turtlebot_publish_cmd_vel_0');
   pause(1)
   resetSim(gazebo);
   pause(2)
   resetSim(gazebo);
   i = i + 1; 
   end
end
%end