pause;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%the program
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
for i=1:nsteps
 h.XDataSource ='x';
h.YDataSource = 'y';
 hm.XDataSource ='xm';
hm.YDataSource = 'ym';
       %calculate vx
       newvx=vx;
       newvy=vy;
       
     %update rocket  
     %grav force earth
       r2=((x-xe).^2+(y-ye).^2);
       r=sqrt(r2);
       g=G*me/r2;
       gx=g*(x-xe)/r;
       gy=g*(y-ye)/r;
       
       %grav force moon
       r2=((x-xm).^2+(y-ym).^2);
       r=sqrt(r2);
       g=G*mm/r2;
        gx=gx+g*(x-xm)/r;
       gy=gy+g*(y-ym)/r;
      
       %grav force sunn
       r2=((x-xs).^2+(y-ys).^2);
       r=sqrt(r2);
       g=G*ms/r2;
        gx=gx+g*(x-xs)/r;
       gy=gy+g*(y-ys)/r; 
       
       %grav force mars
       [gxt,gyt]=gravaccel(x,xma,y,yma,mmars)
       gx=gx+gxt;
       gy=gy+gyt;
       
       
       
       
       %calculate vy
       newvy=vy-gy*dt;
       newvx=vx-gx*dt;
 
        %store old position vector
        oldr(1,1)=x;
        oldr(1,2)=y;
        

        
       
       %calculate x
       x=x+0.5*(vx+newvx)*dt;
       
       %calculate y
       y=y+0.5*(vy+newvy)*dt;
%       refreshdata; 

%       h.XData=x;
%       h.YData=y;
      set(h,'XData',x);
      set(h,'YData',y);

       set(hm,'XData',xm);
      set(hm,'YData',ym);
     

           set(hs,'XData',xs);
      set(hs,'YData',ys);     
  
      
      
      
        set(hma,'XData',xma);
      set(hma,'YData',yma);     
     
      
      
      drawnow;
       vx=newvx;
       vy=newvy;

        newr(1,1)=x;
        newr(1,2)=y;
 
 %plot( x , y ,'o','MarkerFaceColor','g','MarkerSize',10);
 %hold on;
        %vectarrow(oldr, newr);
%         hold on;

%update position of moon, sun and planets

%moon
   %old locator for moon
%       thetam=thetam+dthetam*dt;
%       if thetam>(2*pi)
%          thetam=0; 
%       end
%       xm=dem*cos(thetam);
%       ym=dem*sin(thetam);
       gx=0;
       gy=0;
       [gxt,gyt]=gravaccel(xm,xe,ym,ye,me);%earth contrib
       gx=gx+gxt;
       gy=gy+gyt;
      [gxt,gyt]=gravaccel(xm,xs,ym,ys,ms);%sun contrib
       gx=gx+gxt;
       gy=gy+gyt;       
            
       %update velocity
       newvy=vym-gy*dt;
       newvx=vxm-gx*dt;
       xm=xm+0.5*(vxm+newvx)*dt;
       ym=ym+0.5*(vym+newvy)*dt;
       vxm=newvx;
       vym=newvy;

%mars
       gx=0;
       gy=0;
       [gxt,gyt]=gravaccel(xma,xe,yma,ye,me);%earth contrib
       gx=gx+gxt;
       gy=gy+gyt;
      [gxt,gyt]=gravaccel(xma,xs,yma,ys,ms);%sun contrib
       gx=gx+gxt;
       gy=gy+gyt;       
            
       %update velocity
       newvy=vyma-gy*dt;
       newvx=vxma-gx*dt;
       xma=xma+0.5*(vxma+newvx)*dt;
       yma=yma+0.5*(vyma+newvy)*dt;
       vxma=newvx;
       vyma=newvy;       
       
%earth
       gx=0;
       gy=0;
       [gxt,gyt]=gravaccel(xe,xma,ye,yma,mmars);%mars contrib
       gx=gx+gxt;
       gy=gy+gyt;
      [gxt,gyt]=gravaccel(xe,xs,ye,ys,ms);%sun contrib
       gx=gx+gxt;
       gy=gy+gyt;       
      [gxt,gyt]=gravaccel(xe,xm,ye,ym,mm);%moon contrib
       gx=gx+gxt;
       gy=gy+gyt;  
       
       
       
       %update velocity
       newvy=vye-gy*dt;
       newvx=vxe-gx*dt;
       xe=xe+0.5*(vxe+newvx)*dt;
       ye=ye+0.5*(vye+newvy)*dt;
       vxe=newvx;
       vye=newvy; 


end